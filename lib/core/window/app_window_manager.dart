import 'package:bookstore_management_system/core/window/window_info.dart';
import 'dart:ui';

import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class AppWindowManager extends ChangeNotifier {
  final Uuid _uuid = const Uuid();
  int _zIndexSeed = 0;

  final Map<String, WindowInfo> _openedWindows = {};

  List<WindowInfo> get windows {
    final items = _openedWindows.values.toList()
      ..sort((left, right) => left.zIndex.compareTo(right.zIndex));
    return items;
  }

  List<WindowInfo> get embeddedWindows =>
      windows.where((window) => window.isEmbedded).toList();

  List<WindowInfo> get floatingWindows =>
      windows.where((window) => window.isFloating).toList();

  List<WindowInfo> get minimizedWindows =>
      windows.where((window) => window.isMinimized).toList();

  WindowInfo? get activeWindow =>
      embeddedWindows.isEmpty ? null : embeddedWindows.last;

  WindowInfo? windowById(String id) => _openedWindows[id];

  WindowInfo openWindow({
    required String title,
    required String popOutPageKey,
    AppWindowPayload payload = const AppWindowPayload(),
    Rect? bounds,
    AppWindowDisplayMode displayMode = AppWindowDisplayMode.embedded,
  }) {
    final newWindow = WindowInfo(
      id: _uuid.v4(),
      title: title,
      popOutPageKey: popOutPageKey,
      payload: payload,
      bounds: bounds ?? _defaultBoundsFor(_openedWindows.length),
      displayMode: displayMode,
      zIndex: ++_zIndexSeed,
    );
    _openedWindows[newWindow.id] = newWindow;

    notifyListeners();
    return newWindow;
  }

  void focusWindow(String id) {
    final window = _openedWindows[id];
    if (window == null) {
      return;
    }

    _openedWindows[id] = window.copyWith(
      displayMode: AppWindowDisplayMode.embedded,
      zIndex: ++_zIndexSeed,
    );
    notifyListeners();
  }

  void closeWindow(String id) {
    if (_openedWindows.remove(id) != null) {
      notifyListeners();
    }
  }

  void minimizeWindow(String id) {
    final window = _openedWindows[id];
    if (window == null) {
      return;
    }

    _openedWindows[id] = window.copyWith(
      displayMode: AppWindowDisplayMode.minimized,
      clearFloatingWindowId: true,
    );
    notifyListeners();
  }

  void restoreMinimizedWindow(String id, {Rect? bounds}) {
    final window = _openedWindows[id];
    if (window == null) {
      return;
    }

    _openedWindows[id] = window.copyWith(
      displayMode: AppWindowDisplayMode.embedded,
      bounds: bounds ?? window.bounds,
      zIndex: ++_zIndexSeed,
      clearFloatingWindowId: true,
    );
    notifyListeners();
  }

  void markWindowFloating(String id, {String? floatingWindowId}) {
    final window = _openedWindows[id];
    if (window == null) {
      return;
    }

    _openedWindows[id] = window.copyWith(
      displayMode: AppWindowDisplayMode.floating,
      floatingWindowId: floatingWindowId,
      zIndex: ++_zIndexSeed,
    );
    notifyListeners();
  }

  void dockWindow(
    String id, {
    required Rect bounds,
    bool minimized = false,
  }) {
    final window = _openedWindows[id];
    if (window == null) {
      return;
    }

    _openedWindows[id] = window.copyWith(
      displayMode: minimized
          ? AppWindowDisplayMode.minimized
          : AppWindowDisplayMode.embedded,
      bounds: bounds,
      zIndex: ++_zIndexSeed,
      clearFloatingWindowId: true,
    );
    notifyListeners();
  }

  void updateWindowBounds(String id, Rect bounds) {
    final window = _openedWindows[id];
    if (window == null) {
      return;
    }

    _openedWindows[id] = window.copyWith(bounds: bounds);
    notifyListeners();
  }

  void updateWindowPayload(String id, AppWindowPayload payload) {
    final window = _openedWindows[id];
    if (window == null) {
      return;
    }

    _openedWindows[id] = window.copyWith(payload: payload);
    notifyListeners();
  }

  Rect _defaultBoundsFor(int index) {
    return Rect.zero;
  }
}
