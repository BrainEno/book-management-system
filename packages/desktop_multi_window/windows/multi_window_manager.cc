#include "multi_window_manager.h"

#include <rpc.h>
#include <iomanip>
#include <memory>
#include <random>
#include <sstream>
#pragma comment(lib, "rpcrt4.lib")

#include <iostream>
#include "flutter_window.h"
#include "flutter_window_wrapper.h"
#include "include/desktop_multi_window/desktop_multi_window_plugin.h"
#include "multi_window_plugin_internal.h"
#include "win32_window.h"
#include "window_configuration.h"

namespace {

std::string GenerateWindowId() {
  UUID uuid;
  UuidCreate(&uuid);

  RPC_CSTR uuid_str = nullptr;
  UuidToStringA(&uuid, &uuid_str);

  std::string result(reinterpret_cast<char*>(uuid_str));
  RpcStringFreeA(&uuid_str);

  return result;
}

WindowCreatedCallback _g_window_created_callback = nullptr;

}  // namespace

// static
MultiWindowManager* MultiWindowManager::Instance() {
  static auto manager = std::make_shared<MultiWindowManager>();
  return manager.get();
}

MultiWindowManager::MultiWindowManager() : windows_() {}

std::string MultiWindowManager::Create(const flutter::EncodableMap* args) {
  std::cout << "[desktop_multi_window] Create.begin pending_remove_ids="
            << pending_remove_ids_.size() << " managed_windows="
            << managed_flutter_windows_.size() << " wrappers=" << windows_.size()
            << std::endl;
  CleanupRemovedWindows();
  std::cout << "[desktop_multi_window] Create.step after_cleanup managed_windows="
            << managed_flutter_windows_.size() << " wrappers="
            << windows_.size() << std::endl;

  std::string window_id = GenerateWindowId();
  std::cout << "[desktop_multi_window] Create.step generated_window_id="
            << window_id << std::endl;
  WindowConfiguration config = WindowConfiguration::FromEncodableMap(args);
  std::cout << "[desktop_multi_window] Create.step parsed_config hidden_at_launch="
            << config.hidden_at_launch << std::endl;

  auto flutter_window = std::make_unique<FlutterWindow>(window_id, config);
  std::cout << "[desktop_multi_window] Create.step flutter_window_allocated window_id="
            << window_id << std::endl;

  std::wstring title = L"";
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(800, 600);

  std::cout << "[desktop_multi_window] Create.step before_flutter_window_create window_id="
            << window_id << std::endl;
  if (!flutter_window->Create(title, origin, size)) {
    std::cerr << "Failed to create window." << std::endl;
    return "";
  }
  std::cout << "[desktop_multi_window] Create.step after_flutter_window_create window_id="
            << window_id << " hwnd=" << flutter_window->GetHandle()
            << std::endl;

  ::ShowWindow(flutter_window->GetHandle(),
               config.hidden_at_launch ? SW_HIDE : SW_SHOW);
  std::cout << "[desktop_multi_window] Create.step after_show_window window_id="
            << window_id << std::endl;

  auto wrapper = std::make_unique<FlutterWindowWrapper>(
      window_id, flutter_window->GetHandle(), config.arguments);
  std::cout << "[desktop_multi_window] Create.step wrapper_allocated window_id="
            << window_id << std::endl;

  windows_[window_id] = std::move(wrapper);
  std::cout << "[desktop_multi_window] Create.step wrapper_stored window_id="
            << window_id << " wrappers=" << windows_.size() << std::endl;

  if (_g_window_created_callback) {
    std::cout << "[desktop_multi_window] Create.step before_window_created_callback window_id="
              << window_id << std::endl;
    _g_window_created_callback(flutter_window->GetFlutterViewController());
    std::cout << "[desktop_multi_window] Create.step after_window_created_callback window_id="
              << window_id << std::endl;
  }
  std::cout << "[desktop_multi_window] Create.step before_registrar_lookup window_id="
            << window_id << std::endl;
  auto registrar = flutter_window->GetFlutterViewController()
                       ->engine()
                       ->GetRegistrarForPlugin("DesktopMultiWindowPlugin");
  std::cout << "[desktop_multi_window] Create.step after_registrar_lookup window_id="
            << window_id << " registrar=" << registrar << std::endl;
  std::cout << "[desktop_multi_window] Create.step before_internal_register window_id="
            << window_id << std::endl;
  InternalMultiWindowPluginRegisterWithRegistrar(registrar,
                                                 windows_[window_id].get());
  std::cout << "[desktop_multi_window] Create.step after_internal_register window_id="
            << window_id << std::endl;

  // keep flutter_window alive
  managed_flutter_windows_[window_id] = std::move(flutter_window);
  std::cout << "[desktop_multi_window] Create.step managed_window_stored window_id="
            << window_id << " managed_windows="
            << managed_flutter_windows_.size() << std::endl;

  // Notify all windows about the change
  std::cout << "[desktop_multi_window] Create.step before_notify_windows_changed window_id="
            << window_id << std::endl;
  NotifyWindowsChanged();
  std::cout << "[desktop_multi_window] Create.step after_notify_windows_changed window_id="
            << window_id << std::endl;

  std::cout << "[desktop_multi_window] Create.end window_id=" << window_id
            << " managed_windows=" << managed_flutter_windows_.size()
            << " wrappers=" << windows_.size() << std::endl;

  return window_id;
}

void MultiWindowManager::AttachFlutterMainWindow(
    HWND window_handle,
    FlutterDesktopPluginRegistrarRef registrar) {
  // check if window already exists
  for (const auto& [id, window] : windows_) {
    if (GetAncestor(window->GetWindowHandle(), GA_ROOT) == window_handle) {
      return;
    }
  }

  const std::string window_id = GenerateWindowId();
  auto wrapper =
      std::make_unique<FlutterWindowWrapper>(window_id, window_handle);

  windows_[window_id] = std::move(wrapper);

  InternalMultiWindowPluginRegisterWithRegistrar(registrar,
                                                 windows_[window_id].get());

  // Notify all windows about the change
  NotifyWindowsChanged();
}

FlutterWindowWrapper* MultiWindowManager::GetWindow(
    const std::string& window_id) {
  auto it = windows_.find(window_id);
  if (it != windows_.end()) {
    return it->second.get();
  }
  return nullptr;
}

flutter::EncodableList MultiWindowManager::GetAllWindows() {
  flutter::EncodableList windows;
  for (const auto& [id, window] : windows_) {
    flutter::EncodableMap window_info;
    window_info[flutter::EncodableValue("windowId")] =
        flutter::EncodableValue(window->GetWindowId());
    window_info[flutter::EncodableValue("windowArgument")] =
        flutter::EncodableValue(window->GetWindowArgument());
    windows.push_back(flutter::EncodableValue(window_info));
  }
  return windows;
}

std::vector<std::string> MultiWindowManager::GetAllWindowIds() {
  std::vector<std::string> window_ids;
  for (const auto& [id, window] : windows_) {
    window_ids.push_back(id);
  }
  return window_ids;
}

void MultiWindowManager::RemoveWindow(const std::string& window_id) {
  std::cout << "[desktop_multi_window] RemoveWindow.begin window_id="
            << window_id << " wrappers=" << windows_.size()
            << " managed_windows=" << managed_flutter_windows_.size()
            << std::endl;
  auto it = windows_.find(window_id);
  if (it != windows_.end()) {
    windows_.erase(it);
    NotifyWindowsChanged();
  }
  std::cout << "[desktop_multi_window] RemoveWindow.end window_id=" << window_id
            << " wrappers=" << windows_.size() << " managed_windows="
            << managed_flutter_windows_.size() << std::endl;
  
  // quit application if no windows left
  if (windows_.empty()) {
    PostQuitMessage(0);
  }
}

void MultiWindowManager::RemoveManagedFlutterWindowLater(
    const std::string& window_id) {
  std::cout << "[desktop_multi_window] RemoveManagedFlutterWindowLater window_id="
            << window_id << std::endl;
  pending_remove_ids_.push_back(window_id);
}

// FIXME:maybe need a more robust way to cleanup removed windows
void MultiWindowManager::CleanupRemovedWindows() {
  std::cout << "[desktop_multi_window] CleanupRemovedWindows.begin pending="
            << pending_remove_ids_.size() << " managed_windows="
            << managed_flutter_windows_.size() << std::endl;
  for (auto& id : pending_remove_ids_) {
    auto it = managed_flutter_windows_.find(id);
    if (it != managed_flutter_windows_.end()) {
      std::cout << "[desktop_multi_window] Deferred managed flutter window cleanup until process shutdown: "
                << id << std::endl;
    }
  }
  pending_remove_ids_.clear();
  std::cout << "[desktop_multi_window] CleanupRemovedWindows.end pending="
            << pending_remove_ids_.size() << " managed_windows="
            << managed_flutter_windows_.size() << std::endl;
}

void MultiWindowManager::NotifyWindowsChanged() {
  auto window_ids = GetAllWindowIds();
  flutter::EncodableList window_ids_list;
  for (const auto& id : window_ids) {
    window_ids_list.push_back(flutter::EncodableValue(id));
  }

  flutter::EncodableMap data;
  data[flutter::EncodableValue("windowIds")] =
      flutter::EncodableValue(window_ids_list);

  for (const auto& [id, window] : windows_) {
    window->NotifyWindowEvent("onWindowsChanged", data);
  }
}

void DesktopMultiWindowSetWindowCreatedCallback(
    WindowCreatedCallback callback) {
  _g_window_created_callback = callback;
}
