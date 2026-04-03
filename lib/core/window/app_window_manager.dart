import 'package:bookstore_management_system/core/window/window_info.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AppWindowManager extends ChangeNotifier {
  final Uuid _uuid = const Uuid();

  // A map to hold all opened windows, so we don't create duplicates
  final Map<String, WindowInfo> _openedWindows = {};

  // Track the ID of the window currently shown in the main docked area
  String? _activeWindowId;

  // A list to track minimized windows
  final List<WindowInfo> _minimizedWindows = [];

  // Expose the active window object
  WindowInfo? get activeWindow =>
      _activeWindowId == null ? null : _openedWindows[_activeWindowId!];

  // Expose the list of minimized windows
  List<WindowInfo> get minimizedWindows => _minimizedWindows;

  // This method is called when you click a menu item
  void openOrFocusWindow({
    required String title,
    required Widget content,
    required String popOutPageKey,
  }) {
    // Check if a window with this key already exists
    var existingWindow = _openedWindows.values.firstWhere(
      (w) => w.popOutPageKey == popOutPageKey,
      orElse: () => WindowInfo(
        id: '',
        title: '',
        content: Container(),
        popOutPageKey: '',
      ),
    );

    if (existingWindow.id.isNotEmpty) {
      // If it exists, make it active
      _activeWindowId = existingWindow.id;
      // If it was minimized, restore it
      _minimizedWindows.removeWhere((w) => w.id == existingWindow.id);
    } else {
      // If it doesn't exist, create a new one
      final newWindow = WindowInfo(
        id: _uuid.v4(),
        title: title,
        content: content,
        popOutPageKey: popOutPageKey,
      );
      _openedWindows[newWindow.id] = newWindow;
      _activeWindowId = newWindow.id;
    }

    notifyListeners();
  }

  void closeActiveWindow() {
    if (_activeWindowId != null) {
      _openedWindows.remove(_activeWindowId);
      _activeWindowId = null;
      // Optional: open the next available window? For now, we just close.
    }
    notifyListeners();
  }

  void minimizeActiveWindow() {
    if (activeWindow != null && !_minimizedWindows.contains(activeWindow)) {
      _minimizedWindows.add(activeWindow!);
      _activeWindowId = null; // Clear the main view
    }
    notifyListeners();
  }

  void restoreMinimizedWindow(String id) {
    final window = _minimizedWindows.firstWhere((w) => w.id == id);
    _minimizedWindows.remove(window);
    _activeWindowId = window.id; // Make it active again
    notifyListeners();
  }

  // This method is called by the "Float" button
  void floatActiveWindow() {
    if (activeWindow != null) {
      // When floating, we simply close the internal representation.
      // The new OS window is now independent.
      closeActiveWindow();
    }
    // No need to notify listeners, as closeActiveWindow already does.
  }
}
