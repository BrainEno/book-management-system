import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/desktop_isbn_scanner_shared_widgets.dart';
import 'package:bookstore_management_system/features/product/utils/isbn_scanner_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_windows/webview_windows.dart';

class WindowsDesktopIsbnScannerDialog extends StatefulWidget {
  const WindowsDesktopIsbnScannerDialog({super.key});

  @override
  State<WindowsDesktopIsbnScannerDialog> createState() =>
      _WindowsDesktopIsbnScannerDialogState();
}

class _WindowsDesktopIsbnScannerDialogState
    extends State<WindowsDesktopIsbnScannerDialog> {
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

        if (!mounted) {
          return;
        }
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

      if (!mounted) {
        return;
      }
      setState(() => _isReady = true);
    } catch (e) {
      if (!mounted) {
        return;
      }
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
    if (!mounted) {
      return;
    }
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
      builder: (ctx) => AlertDialog(
        title: const Text('请求摄像头权限'),
        content: Text('扫描 ISBN 需要 ${permissionKind.name} 权限，是否允许？'),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(ctx).pop(WebviewPermissionDecision.deny),
            child: const Text('拒绝'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(ctx).pop(WebviewPermissionDecision.allow),
            child: const Text('允许'),
          ),
        ],
      ),
    );
    final finalDecision = decision ?? WebviewPermissionDecision.deny;
    _permissionDecision = finalDecision;
    if (!mounted) {
      return finalDecision;
    }

    setState(() {
      _metrics = _metrics.copyWith(
        permissionGranted: finalDecision == WebviewPermissionDecision.allow,
      );
      _statusText = finalDecision == WebviewPermissionDecision.allow
          ? '摄像头权限已授予，准备开始扫描...'
          : '摄像头权限被拒绝';
    });
    return finalDecision;
  }

  int _toInt(dynamic value, int fallback) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value) ?? fallback;
    }
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
              child: !_isReady
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
                  const ScanWaveIndicator(),
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
