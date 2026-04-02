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

    test(
      'buildScannerDiagnosis points to engine fallback when detector unsupported',
      () {
        const metrics = ScannerDebugMetrics(
          startupError: 'Error: 当前 WebView2 环境不支持 BarcodeDetector',
        );
        expect(buildScannerDiagnosis(metrics), contains('ZXing'));
      },
    );

    test('buildMacOsScannerDiagnosis points to permission issue first', () {
      const metrics = MacOsScannerDebugMetrics(permissionState: 'denied');
      expect(buildMacOsScannerDiagnosis(metrics), contains('权限问题'));
    });

    test(
      'buildMacOsScannerDiagnosis explains unknown camera count when preview is running',
      () {
        const metrics = MacOsScannerDebugMetrics(
          permissionState: 'granted',
          initialized: true,
          running: true,
          elapsedSeconds: 18,
          cameraCount: null,
        );
        expect(buildMacOsScannerDiagnosis(metrics), contains('没有返回摄像头数量'));
        expect(buildMacOsScannerDiagnosis(metrics), contains('对焦'));
      },
    );

    test(
      'buildMacOsScannerDiagnosis points out non-isbn detections when invalid detections exist',
      () {
        const metrics = MacOsScannerDebugMetrics(
          permissionState: 'granted',
          initialized: true,
          running: true,
          elapsedSeconds: 14,
          invalidDetections: 3,
          lastInvalidCode: 'HELLO-QR',
        );
        expect(buildMacOsScannerDiagnosis(metrics), contains('不是 ISBN 条码'));
      },
    );

    test(
      'buildMacOsScannerDiagnosis points to startup issue when error exists',
      () {
        const metrics = MacOsScannerDebugMetrics(
          errorMessage: 'Camera initialization failed',
        );
        expect(buildMacOsScannerDiagnosis(metrics), contains('启动异常'));
        expect(
          buildMacOsScannerDiagnosis(metrics),
          contains('Camera initialization failed'),
        );
      },
    );

    test('buildMacOsScannerDebugCode includes diagnosis and key fields', () {
      const metrics = MacOsScannerDebugMetrics(
        permissionState: 'granted',
        initialized: true,
        running: true,
        cameraCount: 1,
        elapsedSeconds: 9,
        invalidDetections: 2,
        lastSuccessfulCode: '9787121155352',
        status: '摄像头已就绪',
      );
      final debugCode = buildMacOsScannerDebugCode(metrics);
      expect(debugCode, contains('ISBN_SCANNER_DEBUG_V2_MACOS'));
      expect(debugCode, contains('permissionState=granted'));
      expect(debugCode, contains('cameraCount=1'));
      expect(debugCode, contains('lastSuccessfulCode=9787121155352'));
      expect(debugCode, contains('diagnosis='));
    });
  });
}
