import 'package:bookstore_management_system/features/product/presentation/controllers/mobile_isbn_scanner_controller.dart';
import 'package:bookstore_management_system/features/product/utils/isbn_sender.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mocktail/mocktail.dart';

class _MockIsbnSender extends Mock implements IsbnSender {}

void main() {
  group('MobileIsbnScannerController', () {
    late _MockIsbnSender sender;
    late MobileIsbnScannerController controller;
    late DateTime now;

    setUp(() {
      sender = _MockIsbnSender();
      now = DateTime(2026, 4, 2, 23, 30);
      controller = MobileIsbnScannerController(
        desktopUrl: 'http://192.168.1.8:8080',
        sender: sender,
        elapsedTick: Duration.zero,
        now: () => now,
      );
    });

    test('keeps success status for immediate duplicate detections', () async {
      when(() => sender.sendIsbn(any(), any())).thenAnswer((_) async => true);

      final capture = BarcodeCapture(
        barcodes: const <Barcode>[
          Barcode(rawValue: '9787300000001', format: BarcodeFormat.ean13),
        ],
      );

      await controller.handleCapture(capture);
      await controller.handleCapture(capture);

      verify(
        () => sender.sendIsbn('9787300000001', 'http://192.168.1.8:8080'),
      ).called(1);
      expect(controller.debugState.sentCount, 1);
      expect(controller.debugState.lastSuccessfulIsbn, '9787300000001');
      expect(controller.debugState.status, 'ISBN 已发送到桌面端');
    });

    test('shows duplicate status after the suppress window expires', () async {
      when(() => sender.sendIsbn(any(), any())).thenAnswer((_) async => true);

      final capture = BarcodeCapture(
        barcodes: const <Barcode>[
          Barcode(rawValue: '9787300000001', format: BarcodeFormat.ean13),
        ],
      );

      await controller.handleCapture(capture);
      now = now.add(const Duration(seconds: 6));
      await controller.handleCapture(capture);

      verify(
        () => sender.sendIsbn('9787300000001', 'http://192.168.1.8:8080'),
      ).called(1);
      expect(controller.debugState.status, '重复 ISBN，已忽略');
    });

    test('does not send non-isbn barcodes and keeps debug trace', () async {
      final capture = BarcodeCapture(
        barcodes: const <Barcode>[
          Barcode(rawValue: 'HELLO-QR', format: BarcodeFormat.qrCode),
        ],
      );

      final result = await controller.handleCapture(capture);

      expect(result, isFalse);
      verifyNever(() => sender.sendIsbn(any(), any()));
      expect(controller.debugState.invalidDetectionCount, 1);
      expect(controller.debugState.lastInvalidCode, 'HELLO-QR');
      expect(controller.debugState.status, '检测到非 ISBN 条码，已忽略');
    });

    test('tracks send failures in debug state', () async {
      when(() => sender.sendIsbn(any(), any())).thenAnswer((_) async => false);

      final capture = BarcodeCapture(
        barcodes: const <Barcode>[
          Barcode(rawValue: '9787300000002', format: BarcodeFormat.ean13),
        ],
      );

      final result = await controller.handleCapture(capture);

      expect(result, isFalse);
      expect(controller.debugState.sendFailureCount, 1);
      expect(controller.debugState.lastSendResult, 'failure');
      expect(controller.debugState.status, 'ISBN 发送失败，请检查网络连接');
    });

    test('mirrors scanner state into debug information', () {
      controller.updateScannerState(
        const MobileScannerState(
          availableCameras: 2,
          cameraDirection: CameraFacing.back,
          cameraLensType: CameraLensType.any,
          isInitialized: true,
          isStarting: false,
          isRunning: true,
          size: Size.zero,
          torchState: TorchState.off,
          zoomScale: 1,
          deviceOrientation: DeviceOrientation.portraitUp,
        ),
      );

      expect(controller.debugState.permissionState, 'granted');
      expect(controller.debugState.cameraCount, 2);
      expect(controller.debugState.running, isTrue);
      expect(
        buildMobileIsbnScannerDiagnosis(controller.debugState),
        contains('移动端扫描器运行中'),
      );
    });

    test('tracks temporary cooldown after a successful send', () {
      controller.beginSuccessCooldown(const Duration(seconds: 3));

      expect(controller.debugState.cooldownActive, isTrue);
      expect(controller.debugState.cooldownRemainingSeconds, 3);
      expect(controller.debugState.status, contains('3 秒后可继续扫描'));

      controller.endSuccessCooldown();

      expect(controller.debugState.cooldownActive, isFalse);
      expect(controller.debugState.cooldownRemainingSeconds, 0);
    });
  });
}
