import 'package:flutter_test/flutter_test.dart';
import 'package:bookstore_management_system/features/product/utils/url_resolver.dart';

void main() {
  group('resolveDesktopUrl', () {
    test('returns desktop URL for normal IPv4 address on Android and iOS', () {
      final attributes = {'ip': '192.168.1.5'};

      expect(resolveDesktopUrl(attributes, 8080, false), 'http://192.168.1.5:8080');
      expect(resolveDesktopUrl(attributes, 8080, true), 'http://192.168.1.5:8080');
    });

    test('returns Android emulator loopback address for localhost on Android', () {
      final attributes = {'ip': '127.0.0.1'};

      expect(resolveDesktopUrl(attributes, 8080, true), 'http://10.0.2.2:8080');
    });

    test('returns null when ip is empty or invalid', () {
      expect(resolveDesktopUrl({'ip': ''}, 8080, false), isNull);
      expect(resolveDesktopUrl({'ip': null}, 8080, false), isNull);
    });

    test('returns null when port is less than or equal to zero', () {
      expect(resolveDesktopUrl({'ip': '192.168.1.5'}, 0, false), isNull);
      expect(resolveDesktopUrl({'ip': '192.168.1.5'}, -1, true), isNull);
    });
  });
}
