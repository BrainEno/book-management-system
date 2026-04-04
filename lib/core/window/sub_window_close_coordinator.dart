import 'dart:async';

typedef ListOpenSubWindowIds = Future<List<String>> Function();
typedef WindowCloseDelay = Future<void> Function(Duration duration);

class SubWindowCloseCoordinator {
  SubWindowCloseCoordinator({
    required ListOpenSubWindowIds listOpenWindowIds,
    WindowCloseDelay delay = Future<void>.delayed,
    this.pollInterval = const Duration(milliseconds: 120),
    this.maxPollCount = 40,
    this.minimumCloseSettleTime = const Duration(seconds: 3),
    DateTime Function()? now,
  }) : _listOpenWindowIds = listOpenWindowIds,
       _delay = delay,
       _now = now ?? DateTime.now;

  final ListOpenSubWindowIds _listOpenWindowIds;
  final WindowCloseDelay _delay;
  final Duration pollInterval;
  final int maxPollCount;
  final Duration minimumCloseSettleTime;
  final DateTime Function() _now;

  final Set<String> _pendingClosingWindowIds = <String>{};
  final Map<String, DateTime> _closingSince = <String, DateTime>{};

  Set<String> get pendingClosingWindowIds =>
      Set<String>.unmodifiable(_pendingClosingWindowIds);

  void markClosing(String windowId) {
    if (windowId.isEmpty) {
      return;
    }
    _pendingClosingWindowIds.add(windowId);
    _closingSince.putIfAbsent(windowId, _now);
  }

  void markClosed(String windowId) {
    _pendingClosingWindowIds.remove(windowId);
    _closingSince.remove(windowId);
  }

  Future<bool> waitForPendingClosures() async {
    if (_pendingClosingWindowIds.isEmpty) {
      return true;
    }

    for (var pollIndex = 0; pollIndex < maxPollCount; pollIndex++) {
      final openWindowIds = (await _listOpenWindowIds()).toSet();
      _pendingClosingWindowIds.removeWhere(
        (windowId) =>
            !openWindowIds.contains(windowId) && _hasSettled(windowId),
      );
      if (_pendingClosingWindowIds.isEmpty) {
        return true;
      }
      if (pollIndex < maxPollCount - 1) {
        await _delay(pollInterval);
      }
    }

    return _pendingClosingWindowIds.isEmpty;
  }

  bool _hasSettled(String windowId) {
    final closingSince = _closingSince[windowId];
    if (closingSince == null) {
      return true;
    }
    final settled = _now().difference(closingSince) >= minimumCloseSettleTime;
    if (settled) {
      _closingSince.remove(windowId);
    }
    return settled;
  }
}
