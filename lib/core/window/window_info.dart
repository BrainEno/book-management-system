import 'package:flutter/material.dart';

class WindowInfo {
  final String id;
  final String title;
  final Widget content;
  final String popOutPageKey;
  Offset position;
  Size size;
  bool isMinimized;

  WindowInfo({
    required this.id,
    required this.title,
    required this.content,
    required this.popOutPageKey,
    this.position = Offset.zero,
    this.size = const Size(800, 600),
    this.isMinimized = false,
  });
}
