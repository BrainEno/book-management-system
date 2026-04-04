import 'dart:math' as math;
import 'dart:ui';

import 'package:intl/intl.dart';

List<String> mergeProductQueryOptions(
  List<String> defaults,
  Iterable<String> extras,
) {
  final merged = <String>[...defaults];
  final seen = <String>{...defaults};
  final extraValues = <String>[];

  for (final extra in extras) {
    final normalized = extra.trim();
    if (normalized.isNotEmpty && !seen.contains(normalized)) {
      extraValues.add(normalized);
      seen.add(normalized);
    }
  }

  extraValues.sort((a, b) => a.compareTo(b));
  merged.addAll(extraValues);
  return merged;
}

String formatProductQueryDateTime(DateTime? value) {
  if (value == null) {
    return '--';
  }
  return DateFormat('yyyy-MM-dd').format(value);
}

Rect resolveProductEditorFloatingBounds(Size workspaceSize) {
  final maxWidth = math.max(760.0, workspaceSize.width - 40);
  final maxHeight = math.max(700.0, workspaceSize.height - 40);
  final preferredWidth = (workspaceSize.width * 0.78).clamp(980.0, 1180.0);
  final preferredHeight = (workspaceSize.height * 0.88).clamp(780.0, 920.0);
  final width = math.min(preferredWidth, maxWidth);
  final height = math.min(preferredHeight, maxHeight);
  final left = math.max(20.0, (workspaceSize.width - width) / 2);
  final top = math.max(20.0, (workspaceSize.height - height) / 2);

  return Rect.fromLTWH(left, top, width, height);
}
