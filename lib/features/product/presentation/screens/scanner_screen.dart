import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bookstore_management_system/features/product/presentation/controllers/mobile_isbn_scanner_controller.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  final String desktopUrl;
  final bool debugMode;

  const ScannerScreen({
    super.key,
    required this.desktopUrl,
    this.debugMode = false,
  });

  @override
  State<ScannerScreen> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerScreen> {
  static const double _previewSize = 320;
  static const Rect _scanWindow = Rect.fromLTWH(32, 108, 256, 104);
  static const Duration _successPauseDuration = Duration(seconds: 3);

  final MobileScannerController _cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  final AudioPlayer _audioPlayer = AudioPlayer();
  late final MobileIsbnScannerController _scannerController;
  Timer? _resumeTimer;
  DateTime? _ignoreDetectionsUntil;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileIsbnScannerController(
      desktopUrl: widget.desktopUrl,
    )..startSession();
    _cameraController.addListener(_syncScannerState);
    _syncScannerState();
    unawaited(_audioPlayer.setSource(AssetSource('sounds/scan_success.mp3')));
  }

  @override
  void dispose() {
    _resumeTimer?.cancel();
    _cameraController.removeListener(_syncScannerState);
    _cameraController.dispose();
    _audioPlayer.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  void _syncScannerState() {
    _scannerController.updateScannerState(_cameraController.value);
  }

  Future<void> _onBarcodeDetect(BarcodeCapture capture) async {
    final ignoreDetectionsUntil = _ignoreDetectionsUntil;
    if (ignoreDetectionsUntil != null &&
        DateTime.now().isBefore(ignoreDetectionsUntil)) {
      return;
    }

    final sentSuccessfully = await _scannerController.handleCapture(capture);
    if (sentSuccessfully) {
      _ignoreDetectionsUntil = DateTime.now().add(_successPauseDuration);
      unawaited(_audioPlayer.play(AssetSource('sounds/scan_success.mp3')));
      unawaited(_pauseScannerAfterSuccess());
    }
  }

  Future<void> _pauseScannerAfterSuccess() async {
    _resumeTimer?.cancel();
    _scannerController.beginSuccessCooldown(_successPauseDuration);

    try {
      await _cameraController.pause();
    } catch (_) {}

    _resumeTimer = Timer(_successPauseDuration, () {
      if (!mounted) {
        return;
      }
      unawaited(_resumeScannerAfterCooldown());
    });
  }

  Future<void> _resumeScannerAfterCooldown() async {
    try {
      await _cameraController.start();
    } catch (_) {
      _scannerController.endSuccessCooldown();
      return;
    }

    _scannerController.endSuccessCooldown();
    _ignoreDetectionsUntil = null;
    _syncScannerState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scannerController,
      builder: (context, _) {
        final state = _scannerController.debugState;
        final debugCode = buildMobileIsbnScannerDebugCode(state);

        return Scaffold(
          appBar: AppBar(
            title: const Text('扫描器'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      state.status,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.lastDisplayedCode.isEmpty
                          ? 'ISBN识别结果: 暂无'
                          : 'ISBN识别结果: ${state.lastDisplayedCode}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: _previewSize,
                        height: _previewSize,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              MobileScanner(
                                controller: _cameraController,
                                onDetect: _onBarcodeDetect,
                                scanWindow: _scanWindow,
                              ),
                              IgnorePointer(
                                child: CustomPaint(
                                  size: const Size(_previewSize, _previewSize),
                                  painter: _MobileScanWindowPainter(
                                    scanWindow: _scanWindow,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (widget.debugMode) ...[
                      const SizedBox(height: 20),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '移动端扫描调试信息',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 12),
                              SelectableText(
                                debugCode,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MobileScanWindowPainter extends CustomPainter {
  const _MobileScanWindowPainter({required this.scanWindow});

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final dimmedPaint = Paint()
      ..color = Colors.black.withAlpha(110)
      ..style = PaintingStyle.fill;

    final clearPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(scanWindow, const Radius.circular(14)),
      );
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final overlayPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      clearPath,
    );

    canvas.drawPath(overlayPath, dimmedPaint);

    final borderPaint = Paint()
      ..color = Colors.lightGreenAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(scanWindow, const Radius.circular(14)),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _MobileScanWindowPainter oldDelegate) {
    return oldDelegate.scanWindow != scanWindow;
  }
}
