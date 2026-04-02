import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:bookstore_management_system/features/product/utils/isbn_scanner_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:webview_windows/webview_windows.dart';

class DesktopIsbnScannerDialog extends StatelessWidget {
  const DesktopIsbnScannerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return const _MacOsDesktopIsbnScannerDialog();
    }
    if (Platform.isWindows) {
      return const _WindowsDesktopIsbnScannerDialog();
    }
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('当前平台暂不支持桌面摄像头扫码'),
      ),
    );
  }
}

class _MacOsDesktopIsbnScannerDialog extends StatefulWidget {
  const _MacOsDesktopIsbnScannerDialog();

  @override
  State<_MacOsDesktopIsbnScannerDialog> createState() =>
      _MacOsDesktopIsbnScannerDialogState();
}

class _MacOsDesktopIsbnScannerDialogState
    extends State<_MacOsDesktopIsbnScannerDialog> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 300,
    facing: CameraFacing.front,
    // Let Vision detect all supported symbologies first, then filter to ISBN in Dart.
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
      if (!mounted || _hasCompleted) return;
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
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (_hasCompleted) return;

    for (final barcode in capture.barcodes) {
      final rawValue = barcode.rawValue?.trim();
      if (rawValue == null || rawValue.isEmpty) {
        continue;
      }

      final normalized = normalizeIsbn(rawValue);
      if (!isLikelyIsbn(normalized)) {
        if (mounted) {
          setState(() {
            _lastInvalidCode = rawValue;
            _invalidDetectionCount += 1;
            _statusText = '已识别到条码，但不是有效 ISBN：$rawValue';
          });
        }
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
      if (!mounted) return;
      Navigator.of(context).pop(normalized);
      return;
    }
  }

  String _buildMacStatus(MobileScannerState state) {
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

  MacOsScannerDebugMetrics _buildMacDebugMetrics(MobileScannerState state) {
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
      status: _buildMacStatus(state),
      engine: 'mobile_scanner',
    );
  }

  Future<void> _copyDebugCode() async {
    final debugCode = buildMacOsScannerDebugCode(
      _buildMacDebugMetrics(_controller.value),
    );
    await Clipboard.setData(ClipboardData(text: debugCode));
    if (!mounted) return;
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
                              final text =
                                  mobileError.errorDetails?.message?.trim();
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
                            overlayBuilder:
                                error == null
                                    ? (context, overlayConstraints) =>
                                        _DesktopScannerFrameOverlay(
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
                final metrics = _buildMacDebugMetrics(state);
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
                      const _ScanWaveIndicator(),
                      const SizedBox(height: 8),
                      Text(
                        '调试状态: ${_buildMacStatus(state)}',
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
                          Text('平台: ${Platform.operatingSystem}'),
                          Text('引擎: mobile_scanner'),
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

class _WindowsDesktopIsbnScannerDialog extends StatefulWidget {
  const _WindowsDesktopIsbnScannerDialog();

  @override
  State<_WindowsDesktopIsbnScannerDialog> createState() =>
      _WindowsDesktopIsbnScannerDialogState();
}

class _WindowsDesktopIsbnScannerDialogState
    extends State<_WindowsDesktopIsbnScannerDialog> {
  final WebviewController _controller = WebviewController();
  StreamSubscription<dynamic>? _webMessageSub;
  HttpServer? _assetServer;
  String _pageUrl = '';
  WebviewPermissionDecision _permissionDecision =
      WebviewPermissionDecision.none;
  bool _hasAskedPermission = false;
  bool _isReady = false;
  String? _errorText;
  String _statusText = '初始化扫描器...';
  ScannerDebugMetrics _metrics = const ScannerDebugMetrics();

  @override
  void initState() {
    super.initState();
    _initScannerPage();
  }

  @override
  void dispose() {
    _webMessageSub?.cancel();
    _assetServer?.close(force: true);
    super.dispose();
  }

  Future<void> _initScannerPage() async {
    try {
      _pageUrl = await _startLocalScannerAssetServer();
      await _controller.initialize();
      await _controller.loadUrl(_pageUrl);

      _webMessageSub = _controller.webMessage.listen((event) {
        final methodName = event['methodName'] as String?;
        final data = event['data'];

        if (!mounted) return;
        if (methodName == 'successCallback') {
          final result = data?.toString() ?? '';
          if (result.isNotEmpty) {
            Navigator.of(context).pop(result);
          }
          return;
        }

        if (methodName == 'errorCallback') {
          final message = data?.toString() ?? '未知错误';
          setState(() {
            _errorText = message;
            _metrics = _metrics.copyWith(startupError: message);
          });
          return;
        }

        if (methodName == 'statusCallback') {
          setState(() => _statusText = data?.toString() ?? _statusText);
          return;
        }

        if (methodName == 'metricsCallback' && data is Map) {
          setState(() {
            _metrics = _metrics.copyWith(
              cameraCount: _toInt(data['cameraCount'], _metrics.cameraCount),
              cameraLabel:
                  data['cameraLabel']?.toString() ?? _metrics.cameraLabel,
              decodeErrorCount: _toInt(
                data['decodeErrors'],
                _metrics.decodeErrorCount,
              ),
              elapsedSeconds: _toInt(
                data['elapsedSeconds'],
                _metrics.elapsedSeconds,
              ),
              requestedWidth: _toInt(
                data['requestedWidth'],
                _metrics.requestedWidth,
              ),
              requestedHeight: _toInt(
                data['requestedHeight'],
                _metrics.requestedHeight,
              ),
              cameraFound: _toInt(data['cameraCount'], 0) > 0,
              pageUrl: data['pageUrl']?.toString() ?? _metrics.pageUrl,
              secureContext: data['secureContext'] == true,
              engine: data['engine']?.toString() ?? _metrics.engine,
              lastDecodeError:
                  data['lastDecodeError']?.toString() ??
                  _metrics.lastDecodeError,
            );
          });
        }
      });

      if (!mounted) return;
      setState(() => _isReady = true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isReady = true;
        _errorText = '初始化桌面扫描器失败: $e';
      });
    }
  }

  Future<String> _startLocalScannerAssetServer() async {
    final server = await HttpServer.bind('localhost', 0);
    _assetServer = server;
    final baseUrl = 'http://localhost:${server.port}';
    _statusText = '本地扫描服务已启动：$baseUrl';

    server.listen((request) async {
      try {
        final normalizedPath = request.uri.path.replaceFirst(
          RegExp(r'^/+'),
          '',
        );
        switch (normalizedPath) {
          case '':
          case 'isbn_scanner.html':
            final html = await rootBundle.loadString(
              'assets/scanner/isbn_scanner.html',
            );
            request.response.headers.contentType = ContentType.html;
            request.response.write(html);
            break;
          case 'html5-qrcode.min.js':
            final data = await rootBundle.load(
              'assets/scanner/html5-qrcode.min.js',
            );
            request.response.headers.contentType = ContentType(
              'application',
              'javascript',
              charset: 'utf-8',
            );
            request.response.add(_byteDataToBytes(data));
            break;
          default:
            request.response.statusCode = HttpStatus.notFound;
            request.response.write('Not found');
        }
      } catch (e) {
        request.response.statusCode = HttpStatus.internalServerError;
        request.response.write('Asset server error: $e');
      } finally {
        await request.response.close();
      }
    });

    return '$baseUrl/isbn_scanner.html';
  }

  List<int> _byteDataToBytes(ByteData data) {
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _closeDialog() async {
    try {
      await _controller.postWebMessage(jsonEncode({'event': 'close'}));
    } catch (_) {}
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
    BuildContext context,
    WebviewPermissionKind permissionKind,
  ) async {
    if (_hasAskedPermission) {
      return _permissionDecision == WebviewPermissionDecision.none
          ? WebviewPermissionDecision.deny
          : _permissionDecision;
    }
    _hasAskedPermission = true;

    final decision = await showDialog<WebviewPermissionDecision>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('请求摄像头权限'),
            content: Text('扫描 ISBN 需要 ${permissionKind.name} 权限，是否允许？'),
            actions: [
              TextButton(
                onPressed:
                    () => Navigator.of(ctx).pop(WebviewPermissionDecision.deny),
                child: const Text('拒绝'),
              ),
              FilledButton(
                onPressed:
                    () =>
                        Navigator.of(ctx).pop(WebviewPermissionDecision.allow),
                child: const Text('允许'),
              ),
            ],
          ),
    );
    final finalDecision = decision ?? WebviewPermissionDecision.deny;
    _permissionDecision = finalDecision;
    if (!mounted) return finalDecision;
    setState(() {
      _metrics = _metrics.copyWith(
        permissionGranted: finalDecision == WebviewPermissionDecision.allow,
      );
      _statusText =
          finalDecision == WebviewPermissionDecision.allow
              ? '摄像头权限已授予，准备开始扫描...'
              : '摄像头权限被拒绝';
    });
    return finalDecision;
  }

  int _toInt(dynamic value, int fallback) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }

  String _buildDebugCode() {
    final suggestion = buildScannerDiagnosis(_metrics);
    return [
      'ISBN_SCANNER_DEBUG_V1',
      'time=${DateTime.now().toIso8601String()}',
      'platform=${Platform.operatingSystem}',
      'status=$_statusText',
      'error=${_errorText ?? ''}',
      'pageUrl=${_metrics.pageUrl.isEmpty ? _pageUrl : _metrics.pageUrl}',
      'secureContext=${_metrics.secureContext}',
      'engine=${_metrics.engine}',
      'cameraLabel=${_metrics.cameraLabel}',
      'cameraCount=${_metrics.cameraCount}',
      'permissionGranted=${_metrics.permissionGranted}',
      'decodeErrors=${_metrics.decodeErrorCount}',
      'elapsedSeconds=${_metrics.elapsedSeconds}',
      'requestedResolution=${_metrics.requestedWidth}x${_metrics.requestedHeight}',
      'lastDecodeError=${_metrics.lastDecodeError}',
      'startupError=${_metrics.startupError}',
      'diagnosis=$suggestion',
    ].join('\n');
  }

  Future<void> _copyDebugCode() async {
    final debugCode = _buildDebugCode();
    await Clipboard.setData(ClipboardData(text: debugCode));
    if (!mounted) return;
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
                    onPressed: _closeDialog,
                    icon: const Icon(Icons.close),
                    tooltip: '关闭',
                  ),
                  IconButton(
                    onPressed: _copyDebugCode,
                    icon: const Icon(Icons.copy_all),
                    tooltip: '复制调试码',
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child:
                  !_isReady
                      ? const Center(child: CircularProgressIndicator())
                      : _errorText != null
                      ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            _errorText!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      )
                      : Webview(
                        _controller,
                        permissionRequested:
                            (url, permissionKind, isUserInitiated) =>
                                _onPermissionRequested(context, permissionKind),
                      ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ScanWaveIndicator(),
                  const SizedBox(height: 8),
                  Text(
                    '调试状态: $_statusText',
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
                      Text('摄像头: ${_metrics.cameraLabel}'),
                      Text('设备数: ${_metrics.cameraCount}'),
                      Text('权限: ${_metrics.permissionGranted ? '已允许' : '未允许'}'),
                      Text('解码失败: ${_metrics.decodeErrorCount}'),
                      Text('运行时长: ${_metrics.elapsedSeconds}s'),
                      Text(
                        '请求分辨率: ${_metrics.requestedWidth}x${_metrics.requestedHeight}',
                      ),
                      Text('安全上下文: ${_metrics.secureContext ? '是' : '否'}'),
                      Text('扫描引擎: ${_metrics.engine}'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '诊断建议: ${buildScannerDiagnosis(_metrics)}',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanWaveIndicator extends StatelessWidget {
  const _ScanWaveIndicator();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: const LinearProgressIndicator(minHeight: 6),
    );
  }
}

class _DesktopScannerFrameOverlay extends StatelessWidget {
  const _DesktopScannerFrameOverlay({required this.scanWindow});

  final Rect scanWindow;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned.fromRect(
            rect: scanWindow,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.82),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Positioned(
                    left: 14,
                    right: 14,
                    top: 14,
                    child: _DesktopScannerFrameBeam(),
                  ),
                  _DesktopScannerCorner(alignment: Alignment.topLeft),
                  _DesktopScannerCorner(alignment: Alignment.topRight),
                  _DesktopScannerCorner(alignment: Alignment.bottomLeft),
                  _DesktopScannerCorner(alignment: Alignment.bottomRight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopScannerFrameBeam extends StatelessWidget {
  const _DesktopScannerFrameBeam();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: const LinearProgressIndicator(minHeight: 5),
    );
  }
}

class _DesktopScannerCorner extends StatelessWidget {
  const _DesktopScannerCorner({required this.alignment});

  final Alignment alignment;

  BorderRadius _radius() {
    if (alignment == Alignment.topLeft) {
      return const BorderRadius.only(topLeft: Radius.circular(20));
    }
    if (alignment == Alignment.topRight) {
      return const BorderRadius.only(topRight: Radius.circular(20));
    }
    if (alignment == Alignment.bottomLeft) {
      return const BorderRadius.only(bottomLeft: Radius.circular(20));
    }
    return const BorderRadius.only(bottomRight: Radius.circular(20));
  }

  Border _border() {
    const side = BorderSide(color: Color(0xFF34D399), width: 5);
    if (alignment == Alignment.topLeft) {
      return const Border(left: side, top: side);
    }
    if (alignment == Alignment.topRight) {
      return const Border(right: side, top: side);
    }
    if (alignment == Alignment.bottomLeft) {
      return const Border(left: side, bottom: side);
    }
    return const Border(right: side, bottom: side);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(border: _border(), borderRadius: _radius()),
      ),
    );
  }
}
