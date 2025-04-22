import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

/// Sets the window size for a Flutter desktop app on Windows and macOS.
///
/// [width] and [height] are the desired dimensions in pixels.
Future<void> setWindowSize(double width, double height) async {
  await windowManager.setPosition(Offset.zero);
  await windowManager.setSize(Size(width, height));
}
