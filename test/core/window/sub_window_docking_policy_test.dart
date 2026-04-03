import 'dart:ui';

import 'package:bookstore_management_system/core/window/sub_window_docking_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maximize docking keeps the stored host bounds', () {
    const storedBounds = Rect.fromLTWH(0, 0, 1480, 920);
    const floatingBounds = Rect.fromLTWH(180, 120, 1080, 860);

    final resolved = resolveDockedWindowBounds(
      storedHostBounds: storedBounds,
      reportedSubWindowBounds: floatingBounds,
      minimized: false,
      reason: 'maximize',
    );

    expect(resolved, storedBounds);
  });

  test('minimize docking keeps the stored host bounds', () {
    const storedBounds = Rect.fromLTWH(0, 0, 1480, 920);
    const floatingBounds = Rect.fromLTWH(200, 100, 1040, 820);

    final resolved = resolveDockedWindowBounds(
      storedHostBounds: storedBounds,
      reportedSubWindowBounds: floatingBounds,
      minimized: true,
      reason: 'minimize',
    );

    expect(resolved, storedBounds);
  });

  test('standard docking still uses reported bounds when provided', () {
    const storedBounds = Rect.zero;
    const reportedBounds = Rect.fromLTWH(120, 80, 900, 680);

    final resolved = resolveDockedWindowBounds(
      storedHostBounds: storedBounds,
      reportedSubWindowBounds: reportedBounds,
      minimized: false,
    );

    expect(resolved, reportedBounds);
  });

  test('maximize docking waits briefly before hiding floating child', () {
    expect(
      resolveSubWindowHideDelay('maximize'),
      const Duration(milliseconds: 180),
    );
    expect(resolveSubWindowHideDelay('minimize'), Duration.zero);
  });

  test('minimize and maximize docking close the floating child window', () {
    expect(
      resolveFloatingChildDisposition(
        minimized: true,
        reason: 'minimize',
      ),
      FloatingChildDisposition.close,
    );
    expect(
      resolveFloatingChildDisposition(
        minimized: false,
        reason: 'maximize',
      ),
      FloatingChildDisposition.close,
    );
  });

  test('host does not re-close a sub-window that already requested close', () {
    expect(shouldHostCloseFloatingChildFromCloseRequest(), isFalse);
  });
}
