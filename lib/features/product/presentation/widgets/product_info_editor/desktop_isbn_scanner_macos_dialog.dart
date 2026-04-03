import 'dart:async';
import 'dart:math' as math;

import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/desktop_isbn_scanner_shared_widgets.dart';
import 'package:bookstore_management_system/features/product/utils/isbn_scanner_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MacOsDesktopIsbnScannerDialog extends StatefulWidget {
  const MacOsDesktopIsbnScannerDialog({super.key});

  @override
  State<MacOsDesktopIsbnScannerDialog> createState() =>
      _MacOsDesktopIsbnScannerDialogState();
}

class _MacOsDesktopIsbnScannerDialogState
    extends State<MacOsDesktopIsbnScannerDialog> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 300,
    facing: CameraFacing.front,
    formats: const [],
  );

  final Stopwatch _debugStopwatch = Stopwatch();
  Timer? _debugTicker;
  bool _hasCompleted = false;
  String _statusText = '正在初始化 macOS 扫描器...';
  String _lastCode = '';
  String _lastInvalidCode = '';
  int _invalidDetectionCount = 0;

  @override
  void initState() {
    super.initState();
    _debugStopwatch.start();
    _debugTicker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _hasCompleted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _debugTicker?.cancel();
    _debugStopwatch.stop();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _closeDialog() async {
    try {
      await _controller.stop();
    } catch (_) {}
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (_hasCompleted) {
      return;
    }

    for (final barcode in capture.barcodes) {
      final rawValue = barcode.rawValue?.trim();
      if (rawValue == null || rawValue.isEmpty) {
        continue;
      }

      final normalized = normalizeIsbn(rawValue);
      if (!isLikelyIsbn(normalized)) {
        if (!mounted) {
          continue;
        }

        setState(() {
          _lastInvalidCode = rawValue;
          _invalidDetectionCount += 1;
          _statusText = '已识别到条码，但不是有效 ISBN：$rawValue';
        });
        continue;
      }

      _hasCompleted = true;
      if (mounted) {
        setState(() {
          _lastCode = normalized;
          _statusText = '识别成功，正在写入 ISBN...';
        });
      }
      await _controller.stop();
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(normalized);
      return;
    }
  }

  String _buildStatus(MobileScannerState state) {
    if (_hasCompleted) {
      return _statusText;
    }
    if (state.error != null) {
      final details = state.error!.errorDetails?.message;
      if (details != null && details.isNotEmpty) {
        return details;
      }
      return state.error!.errorCode.message;
    }
    if (state.isStarting) {
      return '正在启动摄像头...';
    }
    if (state.isRunning) {
      return _lastCode.isEmpty ? '摄像头已就绪，请将 ISBN 条码对准取景框中部。' : _statusText;
    }
    if (state.isInitialized && !state.hasCameraPermission) {
      return '摄像头权限未授予，请在系统设置中允许访问后重试。';
    }
    return _statusText;
  }

  String _permissionState(MobileScannerState state) {
    final errorCode = state.error?.errorCode;
    if (errorCode == MobileScannerErrorCode.permissionDenied) {
      return 'denied';
    }
    if (state.hasCameraPermission) {
      return 'granted';
    }
    return 'unknown';
  }

  MacOsScannerDebugMetrics _buildDebugMetrics(MobileScannerState state) {
    return MacOsScannerDebugMetrics(
      permissionState: _permissionState(state),
      initialized: state.isInitialized,
      starting: state.isStarting,
      running: state.isRunning,
      cameraCount: state.availableCameras,
      elapsedSeconds: _debugStopwatch.elapsed.inSeconds,
      invalidDetections: _invalidDetectionCount,
      lastSuccessfulCode: _lastCode,
      lastInvalidCode: _lastInvalidCode,
      errorCode: state.error?.errorCode.name ?? '',
      errorMessage: state.error?.errorDetails?.message ?? '',
      status: _buildStatus(state),
      engine: 'mobile_scanner',
    );
  }

  Future<void> _copyDebugCode() async {
    final debugCode = buildMacOsScannerDebugCode(
      _buildDebugMetrics(_controller.value),
    );
    await Clipboard.setData(ClipboardData(text: debugCode));
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('调试码已复制到剪贴板')));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 1100,
        height: 760,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    '桌面 ISBN 扫描',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _copyDebugCode,
                    icon: const Icon(Icons.copy_all),
                    tooltip: '复制调试码',
                  ),
                  IconButton(
                    onPressed: _closeDialog,
                    icon: const Icon(Icons.close),
                    tooltip: '关闭',
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final frameWidth = math.min(
                    constraints.maxWidth * 0.82,
                    920.0,
                  );
                  final frameHeight = math.min(
                    constraints.maxHeight * 0.24,
                    190.0,
                  );
                  final scanWindow = Rect.fromCenter(
                    center: constraints.biggest.center(Offset.zero),
                    width: frameWidth,
                    height: frameHeight,
                  );

                  return ValueListenableBuilder<MobileScannerState>(
                    valueListenable: _controller,
                    builder: (context, state, _) {
                      final error = state.error;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          MobileScanner(
                            controller: _controller,
                            scanWindow: scanWindow,
                            onDetect: _handleBarcode,
                            errorBuilder: (context, mobileError) {
                              final text = mobileError.errorDetails?.message
                                  ?.trim();
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Text(
                                    text == null || text.isEmpty
                                        ? mobileError.errorCode.message
                                        : text,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              );
                            },
                            overlayBuilder: error == null
                                ? (context, overlayConstraints) =>
                                      DesktopScannerFrameOverlay(
                                        scanWindow: scanWindow,
                                      )
                                : null,
                          ),
                          if (_lastCode.isNotEmpty)
                            Positioned(
                              top: 16,
                              left: 16,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.62),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    '最近识别: $_lastCode',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            ValueListenableBuilder<MobileScannerState>(
              valueListenable: _controller,
              builder: (context, state, _) {
                final availableCameras = state.availableCameras;
                final metrics = _buildDebugMetrics(state);
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ScanWaveIndicator(),
                      const SizedBox(height: 8),
                      Text(
                        '调试状态: ${_buildStatus(state)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 14,
                        runSpacing: 6,
                        children: [
                          Text('平台: ${Theme.of(context).platform.name}'),
                          const Text('引擎: mobile_scanner'),
                          Text(
                            '权限: ${switch (_permissionState(state)) {
                              'granted' => '已允许',
                              'denied' => '已拒绝',
                              _ => '待确认',
                            }}',
                          ),
                          Text('运行中: ${state.isRunning ? '是' : '否'}'),
                          Text('初始化: ${state.isInitialized ? '是' : '否'}'),
                          Text('启动中: ${state.isStarting ? '是' : '否'}'),
                          Text(
                            '摄像头数: ${availableCameras == null ? '未知' : availableCameras.toString()}',
                          ),
                          Text('无效识别: $_invalidDetectionCount'),
                          Text('运行时长: ${_debugStopwatch.elapsed.inSeconds}s'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '诊断建议: ${buildMacOsScannerDiagnosis(metrics)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
