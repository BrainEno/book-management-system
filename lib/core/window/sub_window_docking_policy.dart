import 'dart:ui';

enum FloatingChildDisposition { hide, close }

bool shouldReuseStoredHostBoundsForDock({
  required String? reason,
  required bool minimized,
}) {
  return minimized || reason == 'maximize';
}

Rect resolveDockedWindowBounds({
  required Rect storedHostBounds,
  required Rect? reportedSubWindowBounds,
  required bool minimized,
  String? reason,
}) {
  if (shouldReuseStoredHostBoundsForDock(
    reason: reason,
    minimized: minimized,
  )) {
    return storedHostBounds;
  }

  return reportedSubWindowBounds ?? storedHostBounds;
}

Duration resolveSubWindowHideDelay(String? reason) {
  if (reason == 'maximize') {
    return const Duration(milliseconds: 180);
  }
  return Duration.zero;
}

FloatingChildDisposition resolveFloatingChildDisposition({
  required bool minimized,
  String? reason,
}) {
  if (minimized || reason == 'maximize' || reason == 'close') {
    return FloatingChildDisposition.close;
  }
  return FloatingChildDisposition.hide;
}

bool shouldHostCloseFloatingChildFromCloseRequest() {
  return false;
}
