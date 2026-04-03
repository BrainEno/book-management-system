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
  return DateFormat('yyyy-MM-dd HH:mm').format(value);
}
