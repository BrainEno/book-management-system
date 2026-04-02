import 'package:bookstore_management_system/features/product/utils/isbn_scanner_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ISBN scanner utils', () {
    test('normalizeIsbn removes separators and uppercases X', () {
      expect(normalizeIsbn('978-7-121-15535-2'), '9787121155352');
      expect(normalizeIsbn('0-8044-2957-x'), '080442957X');
    });

    test('isLikelyIsbn accepts isbn10 and isbn13', () {
      expect(isLikelyIsbn('9787121155352'), isTrue);
      expect(isLikelyIsbn('080442957X'), isTrue);
      expect(isLikelyIsbn('12345'), isFalse);
    });

    test('buildScannerDiagnosis points to permission issue first', () {
      const metrics = ScannerDebugMetrics(permissionGranted: false);
      expect(buildScannerDiagnosis(metrics), contains('权限问题'));
    });

    test(
      'buildScannerDiagnosis points to camera issue when no camera found',
      () {
        const metrics = ScannerDebugMetrics(
          cameraFound: false,
          cameraCount: 0,
          pageUrl: 'http://127.0.0.1:18080/isbn_scanner.html',
          secureContext: true,
        );
        expect(buildScannerDiagnosis(metrics), contains('未检测到可用摄像头'));
      },
    );

    test('buildScannerDiagnosis points to context issue for file url', () {
      const metrics = ScannerDebugMetrics(
        cameraFound: false,
        cameraCount: 0,
        pageUrl: 'file:///scanner/isbn_scanner.html',
        secureContext: false,
      );
      expect(buildScannerDiagnosis(metrics), contains('页面上下文问题'));
      expect(buildScannerDiagnosis(metrics), contains('localhost'));
    });

    test('buildScannerDiagnosis points to focus and lighting issue', () {
      const metrics = ScannerDebugMetrics(
        elapsedSeconds: 20,
        decodeErrorCount: 80,
        cameraCount: 1,
      );
      expect(buildScannerDiagnosis(metrics), contains('成像/对焦问题'));
    });

    test('buildScannerDiagnosis points to engine fallback when detector unsupported', () {
      const metrics = ScannerDebugMetrics(
        startupError: 'Error: 当前 WebView2 环境不支持 BarcodeDetector',
      );
      expect(buildScannerDiagnosis(metrics), contains('ZXing'));
    });
  });
}
