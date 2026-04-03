import 'dart:math' as math;
import 'dart:ui';

Rect resolveEmbeddedWindowBounds({
  required Rect requestedBounds,
  required Size workspaceSize,
  double minWindowWidth = 540,
  double minWindowHeight = 320,
  double workspacePadding = 12,
}) {
  if (requestedBounds.width <= 0 || requestedBounds.height <= 0) {
    return Rect.fromLTWH(0, 0, workspaceSize.width, workspaceSize.height);
  }

  final maxWidth = math.max(
    minWindowWidth,
    workspaceSize.width - (workspacePadding * 2),
  );
  final maxHeight = math.max(
    minWindowHeight,
    workspaceSize.height - (workspacePadding * 2),
  );
  final width = math.max(
    minWindowWidth,
    math.min(requestedBounds.width, maxWidth),
  );
  final height = math.max(
    minWindowHeight,
    math.min(requestedBounds.height, maxHeight),
  );
  final left = requestedBounds.left
      .clamp(
        workspacePadding,
        math.max(workspacePadding, workspaceSize.width - width - workspacePadding),
      )
      .toDouble();
  final top = requestedBounds.top
      .clamp(
        workspacePadding,
        math.max(
          workspacePadding,
          workspaceSize.height - height - workspacePadding,
        ),
      )
      .toDouble();

  return Rect.fromLTWH(left, top, width, height);
}
