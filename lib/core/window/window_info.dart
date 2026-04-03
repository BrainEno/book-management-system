import 'dart:ui';

import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';

enum AppWindowDisplayMode { embedded, floating, minimized }

class WindowInfo {
  WindowInfo({
    required this.id,
    required this.title,
    required this.popOutPageKey,
    this.payload = const AppWindowPayload(),
    this.bounds = Rect.zero,
    this.displayMode = AppWindowDisplayMode.embedded,
    this.zIndex = 0,
    this.floatingWindowId,
  });

  final String id;
  final String title;
  final String popOutPageKey;
  final AppWindowPayload payload;
  final Rect bounds;
  final AppWindowDisplayMode displayMode;
  final int zIndex;
  final String? floatingWindowId;

  bool get isEmbedded => displayMode == AppWindowDisplayMode.embedded;
  bool get isFloating => displayMode == AppWindowDisplayMode.floating;
  bool get isMinimized => displayMode == AppWindowDisplayMode.minimized;

  WindowInfo copyWith({
    String? id,
    String? title,
    String? popOutPageKey,
    AppWindowPayload? payload,
    Rect? bounds,
    AppWindowDisplayMode? displayMode,
    int? zIndex,
    String? floatingWindowId,
    bool clearFloatingWindowId = false,
  }) {
    return WindowInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      popOutPageKey: popOutPageKey ?? this.popOutPageKey,
      payload: payload ?? this.payload,
      bounds: bounds ?? this.bounds,
      displayMode: displayMode ?? this.displayMode,
      zIndex: zIndex ?? this.zIndex,
      floatingWindowId: clearFloatingWindowId
          ? null
          : (floatingWindowId ?? this.floatingWindowId),
    );
  }
}
