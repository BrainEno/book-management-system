import 'dart:ui';

import 'package:bookstore_management_system/core/window/window_layout_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('default embedded window fills the whole workspace when bounds are empty',
      () {
    final resolved = resolveEmbeddedWindowBounds(
      requestedBounds: Rect.zero,
      workspaceSize: const Size(1460, 920),
    );

    expect(resolved, const Rect.fromLTWH(0, 0, 1460, 920));
  });

  test('non-empty embedded bounds are clamped into the visible workspace', () {
    final resolved = resolveEmbeddedWindowBounds(
      requestedBounds: const Rect.fromLTWH(1200, 900, 800, 700),
      workspaceSize: const Size(1500, 1000),
      workspacePadding: 12,
    );

    expect(resolved.left, lessThanOrEqualTo(1500 - resolved.width - 12));
    expect(resolved.top, lessThanOrEqualTo(1000 - resolved.height - 12));
    expect(resolved.width, lessThanOrEqualTo(1500 - 24));
    expect(resolved.height, lessThanOrEqualTo(1000 - 24));
  });
}
