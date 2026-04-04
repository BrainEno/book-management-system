import 'package:bookstore_management_system/core/window/sub_window_lifecycle_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maximize docking is ignored before lifecycle is armed', () {
    expect(
      shouldDockSubWindowOnMaximize(
        maximizeDockArmed: false,
        handlingWindowTransition: false,
      ),
      isFalse,
    );
  });

  test('maximize docking is ignored while a transition is already running', () {
    expect(
      shouldDockSubWindowOnMaximize(
        maximizeDockArmed: true,
        handlingWindowTransition: true,
      ),
      isFalse,
    );
  });

  test('maximize docking only proceeds when armed and idle', () {
    expect(
      shouldDockSubWindowOnMaximize(
        maximizeDockArmed: true,
        handlingWindowTransition: false,
      ),
      isTrue,
    );
  });

  test('sub-window termination always uses close to avoid quitting the app loop', () {
    expect(
      resolveSubWindowTerminationMethod(fromNativeCloseRequest: true),
      SubWindowTerminationMethod.close,
    );
    expect(
      resolveSubWindowTerminationMethod(fromNativeCloseRequest: false),
      SubWindowTerminationMethod.close,
    );
  });

  test('shared sub-window event channel is only registered by the root host', () {
    expect(
      shouldRegisterSharedSubWindowEventHandler(isSubWindow: true),
      isFalse,
    );
    expect(
      shouldRegisterSharedSubWindowEventHandler(isSubWindow: false),
      isTrue,
    );
  });
}
