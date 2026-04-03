import 'dart:ui';

import 'package:bookstore_management_system/core/window/main_window_presentation_controller.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeMainWindowPresentationOperations
    implements MainWindowPresentationOperations {
  final List<String> calls = [];
  final List<Size> sizes = [];

  @override
  Future<void> center() async {
    calls.add('center');
  }

  @override
  Future<void> maximize() async {
    calls.add('maximize');
  }

  @override
  Future<void> setSize(Size size) async {
    calls.add('setSize');
    sizes.add(size);
  }
}

void main() {
  test('applyInitialPresentation sets windowed size then centers then maximizes',
      () async {
    final operations = FakeMainWindowPresentationOperations();
    final controller = MainWindowPresentationController(
      operations,
      windowedSize: const Size(1500, 920),
    );

    await controller.applyInitialPresentation();

    expect(operations.calls, ['setSize', 'center', 'maximize']);
    expect(operations.sizes.single, const Size(1500, 920));
  });

  test('restoreToCenteredWindowed recenters window in windowed mode', () async {
    final operations = FakeMainWindowPresentationOperations();
    final controller = MainWindowPresentationController(
      operations,
      windowedSize: const Size(1366, 840),
    );

    await controller.restoreToCenteredWindowed();

    expect(operations.calls, ['setSize', 'center']);
    expect(operations.sizes.single, const Size(1366, 840));
  });
}
