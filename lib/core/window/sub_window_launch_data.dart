import 'dart:convert';
import 'dart:ui';

class SubWindowBounds {
  const SubWindowBounds({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  final double left;
  final double top;
  final double width;
  final double height;

  Rect toRect() => Rect.fromLTWH(left, top, width, height);

  Map<String, dynamic> toJson() => {
    'left': left,
    'top': top,
    'width': width,
    'height': height,
  };

  factory SubWindowBounds.fromJson(Map<String, dynamic> json) {
    return SubWindowBounds(
      left: (json['left'] as num?)?.toDouble() ?? 0,
      top: (json['top'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0,
    );
  }

  factory SubWindowBounds.fromRect(Rect rect) {
    return SubWindowBounds(
      left: rect.left,
      top: rect.top,
      width: rect.width,
      height: rect.height,
    );
  }
}

class SubWindowLaunchData {
  const SubWindowLaunchData({
    required this.page,
    required this.title,
    required this.hostWindowId,
    this.state = const {},
    this.bounds,
  });

  final String page;
  final String title;
  final String hostWindowId;
  final Map<String, dynamic> state;
  final SubWindowBounds? bounds;

  Map<String, dynamic> toJson() => {
    'page': page,
    'title': title,
    'hostWindowId': hostWindowId,
    'state': state,
    if (bounds != null) 'bounds': bounds!.toJson(),
  };

  String encode() => jsonEncode(toJson());

  factory SubWindowLaunchData.fromJson(Map<String, dynamic> json) {
    final rawState = json['state'];
    final rawBounds = json['bounds'];

    return SubWindowLaunchData(
      page: json['page'] as String? ?? '',
      title: json['title'] as String? ?? '',
      hostWindowId: json['hostWindowId'] as String? ?? '',
      state: rawState is Map<String, dynamic>
          ? rawState
          : rawState is Map
          ? Map<String, dynamic>.from(rawState)
          : const {},
      bounds: rawBounds is Map<String, dynamic>
          ? SubWindowBounds.fromJson(rawBounds)
          : rawBounds is Map
          ? SubWindowBounds.fromJson(Map<String, dynamic>.from(rawBounds))
          : null,
    );
  }

  factory SubWindowLaunchData.decode(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) {
      return SubWindowLaunchData.fromJson(decoded);
    }
    if (decoded is Map) {
      return SubWindowLaunchData.fromJson(Map<String, dynamic>.from(decoded));
    }
    throw const FormatException('Invalid sub-window launch payload');
  }
}
