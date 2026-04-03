import 'dart:ui';

import 'package:window_manager/window_manager.dart';

abstract interface class MainWindowPresentationOperations {
  Future<void> setSize(Size size);

  Future<void> center();

  Future<void> maximize();
}

class WindowManagerPresentationOperations
    implements MainWindowPresentationOperations {
  const WindowManagerPresentationOperations();

  @override
  Future<void> center() => windowManager.center();

  @override
  Future<void> maximize() => windowManager.maximize();

  @override
  Future<void> setSize(Size size) => windowManager.setSize(size);
}

class MainWindowPresentationController {
  const MainWindowPresentationController(
    this._operations, {
    this.windowedSize = const Size(1440, 900),
  });

  final MainWindowPresentationOperations _operations;
  final Size windowedSize;

  Future<void> applyInitialPresentation({bool maximize = true}) async {
    await _operations.setSize(windowedSize);
    await _operations.center();
    if (maximize) {
      await _operations.maximize();
    }
  }

  Future<void> restoreToCenteredWindowed() async {
    await _operations.setSize(windowedSize);
    await _operations.center();
  }
}
