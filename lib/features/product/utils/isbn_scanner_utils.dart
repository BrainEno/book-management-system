class ScannerDebugMetrics {
  final bool permissionGranted;
  final bool cameraFound;
  final int cameraCount;
  final String cameraLabel;
  final int decodeErrorCount;
  final int elapsedSeconds;
  final int requestedWidth;
  final int requestedHeight;
  final String lastDecodeError;
  final String startupError;
  final String pageUrl;
  final bool secureContext;
  final String engine;

  const ScannerDebugMetrics({
    this.permissionGranted = true,
    this.cameraFound = true,
    this.cameraCount = 0,
    this.cameraLabel = '未知',
    this.decodeErrorCount = 0,
    this.elapsedSeconds = 0,
    this.requestedWidth = 0,
    this.requestedHeight = 0,
    this.lastDecodeError = '',
    this.startupError = '',
    this.pageUrl = '',
    this.secureContext = false,
    this.engine = 'unknown',
  });

  ScannerDebugMetrics copyWith({
    bool? permissionGranted,
    bool? cameraFound,
    int? cameraCount,
    String? cameraLabel,
    int? decodeErrorCount,
    int? elapsedSeconds,
    int? requestedWidth,
    int? requestedHeight,
    String? lastDecodeError,
    String? startupError,
    String? pageUrl,
    bool? secureContext,
    String? engine,
  }) {
    return ScannerDebugMetrics(
      permissionGranted: permissionGranted ?? this.permissionGranted,
      cameraFound: cameraFound ?? this.cameraFound,
      cameraCount: cameraCount ?? this.cameraCount,
      cameraLabel: cameraLabel ?? this.cameraLabel,
      decodeErrorCount: decodeErrorCount ?? this.decodeErrorCount,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      requestedWidth: requestedWidth ?? this.requestedWidth,
      requestedHeight: requestedHeight ?? this.requestedHeight,
      lastDecodeError: lastDecodeError ?? this.lastDecodeError,
      startupError: startupError ?? this.startupError,
      pageUrl: pageUrl ?? this.pageUrl,
      secureContext: secureContext ?? this.secureContext,
      engine: engine ?? this.engine,
    );
  }
}

String normalizeIsbn(String raw) {
  return raw.replaceAll(RegExp(r'[^0-9Xx]'), '').toUpperCase();
}

bool isLikelyIsbn(String code) {
  return RegExp(r'^\d{13}$').hasMatch(code) ||
      RegExp(r'^\d{9}[\dX]$').hasMatch(code);
}

String buildScannerDiagnosis(ScannerDebugMetrics metrics) {
  if (!metrics.permissionGranted) {
    return '可能是权限问题：请在系统设置中允许应用访问摄像头，然后重启应用。';
  }

  if (metrics.startupError.isNotEmpty) {
    if (metrics.startupError.contains('BarcodeDetector')) {
      return '当前 WebView2 不支持 BarcodeDetector，需要自动切换到 ZXing 扫描引擎。';
    }
    return '扫描器启动异常：${metrics.startupError}';
  }

  if (!metrics.cameraFound || metrics.cameraCount == 0) {
    if (metrics.pageUrl.startsWith('file://') || !metrics.secureContext) {
      return '当前更像是页面上下文问题（非安全上下文）导致无法枚举摄像头，请改用 localhost 页面加载扫描器。';
    }
    return '未检测到可用摄像头：请确认摄像头未被其他程序占用。';
  }

  if (metrics.elapsedSeconds >= 12 && metrics.decodeErrorCount >= 60) {
    return '更可能是成像/对焦问题：请提高光照、拉远到约20-35cm、保持条码水平完整。';
  }

  if (metrics.elapsedSeconds >= 12 &&
      metrics.decodeErrorCount >= 30 &&
      metrics.requestedWidth > 0 &&
      metrics.requestedWidth < 1280) {
    return '可能是摄像头分辨率偏低，建议更换更高像素摄像头或切换后置摄像头。';
  }

  if (metrics.elapsedSeconds >= 15 && metrics.decodeErrorCount < 10) {
    return '摄像头流正常但未命中条码：请确认扫描的是 ISBN 条码（EAN/UPC）而非封面二维码。';
  }

  return '扫描中：请让条码占据取景框中部并保持稳定 1-2 秒。';
}
