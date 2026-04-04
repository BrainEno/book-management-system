import 'package:bookstore_management_system/core/window/sub_window_feature_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SubWindowFeaturePolicy.supportsAudioFeedback', () {
    test('returns true for main windows on Windows', () {
      expect(
        SubWindowFeaturePolicy.supportsAudioFeedback(
          isSubWindow: false,
          isWindows: true,
        ),
        isTrue,
      );
    });

    test('returns false for Windows sub-windows', () {
      expect(
        SubWindowFeaturePolicy.supportsAudioFeedback(
          isSubWindow: true,
          isWindows: true,
        ),
        isFalse,
      );
    });

    test('returns true for non-Windows sub-windows', () {
      expect(
        SubWindowFeaturePolicy.supportsAudioFeedback(
          isSubWindow: true,
          isWindows: false,
        ),
        isTrue,
      );
    });
  });
}
