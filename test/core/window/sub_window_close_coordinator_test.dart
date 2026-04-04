import 'package:bookstore_management_system/core/window/sub_window_close_coordinator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('waitForPendingClosures returns immediately when nothing is pending', () async {
    final coordinator = SubWindowCloseCoordinator(
      listOpenWindowIds: () async => const <String>[],
      delay: (_) async {},
      now: () => DateTime(2026, 4, 3, 23, 0, 0),
    );

    expect(await coordinator.waitForPendingClosures(), isTrue);
    expect(coordinator.pendingClosingWindowIds, isEmpty);
  });

  test('waitForPendingClosures waits until tracked window disappears', () async {
    var pollCount = 0;
    var currentTime = DateTime(2026, 4, 3, 23, 0, 0);
    final coordinator = SubWindowCloseCoordinator(
      listOpenWindowIds: () async {
        pollCount += 1;
        if (pollCount == 1) {
          return const <String>['child-1'];
        }
        return const <String>[];
      },
      delay: (_) async {
        currentTime = currentTime.add(const Duration(seconds: 3));
      },
      maxPollCount: 3,
      now: () => currentTime,
    );

    coordinator.markClosing('child-1');

    expect(await coordinator.waitForPendingClosures(), isTrue);
    expect(coordinator.pendingClosingWindowIds, isEmpty);
    expect(pollCount, 2);
  });

  test('waitForPendingClosures reports timeout when tracked window never disappears', () async {
    var currentTime = DateTime(2026, 4, 3, 23, 0, 0);
    final coordinator = SubWindowCloseCoordinator(
      listOpenWindowIds: () async => const <String>['child-1'],
      delay: (_) async {
        currentTime = currentTime.add(const Duration(seconds: 1));
      },
      maxPollCount: 3,
      now: () => currentTime,
    );

    coordinator.markClosing('child-1');

    expect(await coordinator.waitForPendingClosures(), isFalse);
    expect(coordinator.pendingClosingWindowIds, contains('child-1'));
  });

  test('waitForPendingClosures keeps a recently closed window in settling state', () async {
    var currentTime = DateTime(2026, 4, 3, 23, 0, 0);
    final coordinator = SubWindowCloseCoordinator(
      listOpenWindowIds: () async => const <String>[],
      delay: (_) async {
        currentTime = currentTime.add(const Duration(seconds: 1));
      },
      maxPollCount: 2,
      minimumCloseSettleTime: const Duration(seconds: 3),
      now: () => currentTime,
    );

    coordinator.markClosing('child-1');

    expect(await coordinator.waitForPendingClosures(), isFalse);
    expect(coordinator.pendingClosingWindowIds, contains('child-1'));
  });
}
