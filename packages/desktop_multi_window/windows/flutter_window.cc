#include "flutter_window.h"

#include "flutter_windows.h"

#include "tchar.h"

#include <iostream>

#include "multi_window_manager.h"
#include "multi_window_plugin_internal.h"

FlutterWindow::FlutterWindow(const std::string& id,
                             const WindowConfiguration config)
    : id_(id), window_argument_(config.arguments) {}

bool FlutterWindow::OnCreate() {
  // Called when the window is created
  std::cout << "[desktop_multi_window] FlutterWindow::OnCreate.begin window_id="
            << id_ << std::endl;
  RECT frame = GetClientArea();
  std::cout << "[desktop_multi_window] FlutterWindow::OnCreate.client_area window_id="
            << id_ << " width=" << (frame.right - frame.left)
            << " height=" << (frame.bottom - frame.top) << std::endl;

  flutter::DartProject project(L"data");
  std::vector<std::string> entrypoint_args = {"multi_window", id_,
                                              window_argument_};
  project.set_dart_entrypoint_arguments(entrypoint_args);
  std::cout << "[desktop_multi_window] FlutterWindow::OnCreate.before_controller window_id="
            << id_ << std::endl;
  flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
      frame.right - frame.left, frame.bottom - frame.top, project);
  std::cout << "[desktop_multi_window] FlutterWindow::OnCreate.after_controller window_id="
            << id_ << " controller=" << flutter_controller_.get()
            << std::endl;

  // Ensure that basic setup of the controller was successful.
  if (!flutter_controller_->engine() || !flutter_controller_->view()) {
    std::cerr << "Failed to setup FlutterViewController." << std::endl;
    return false;
  }
  std::cout << "[desktop_multi_window] FlutterWindow::OnCreate.engine_ready window_id="
            << id_ << " engine=" << flutter_controller_->engine()
            << " view=" << flutter_controller_->view() << std::endl;

  auto view_handle = flutter_controller_->view()->GetNativeWindow();
  std::cout << "[desktop_multi_window] FlutterWindow::OnCreate.before_set_child_content window_id="
            << id_ << " view_handle=" << view_handle << std::endl;
  SetChildContent(view_handle);
  std::cout << "[desktop_multi_window] FlutterWindow::OnCreate.end window_id="
            << id_ << std::endl;

  return true;
}

void FlutterWindow::OnDestroy() {
  std::cout << "[desktop_multi_window] FlutterWindow::OnDestroy.begin window_id="
            << id_ << " controller=" << flutter_controller_.get()
            << std::endl;
  if (flutter_controller_) {
    flutter_controller_ = nullptr;
  }
  std::cout << "[desktop_multi_window] FlutterWindow::OnDestroy.after_controller_reset window_id="
            << id_ << std::endl;
  MultiWindowManager::Instance()->RemoveManagedFlutterWindowLater(id_);
  std::cout << "[desktop_multi_window] FlutterWindow::OnDestroy.end window_id="
            << id_ << std::endl;
}

LRESULT FlutterWindow::MessageHandler(HWND hwnd,
                                      UINT const message,
                                      WPARAM const wparam,
                                      LPARAM const lparam) noexcept {
  // Give Flutter, including plugins, an opportunity to handle window messages.
  if (flutter_controller_) {
    std::optional<LRESULT> result =
        flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam,
                                                      lparam);
    if (result) {
      return *result;
    }
  }

  switch (message) {
    case WM_FONTCHANGE:
      flutter_controller_->engine()->ReloadSystemFonts();
      break;
  }

  return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}

FlutterWindow::~FlutterWindow() {
  std::cout << "[desktop_multi_window] FlutterWindow::~FlutterWindow window_id="
            << id_ << std::endl;
}
