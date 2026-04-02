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

class MacOsScannerDebugMetrics {
  final String permissionState;
  final bool initialized;
  final bool starting;
  final bool running;
  final int? cameraCount;
  final int elapsedSeconds;
  final int invalidDetections;
  final String lastSuccessfulCode;
  final String lastInvalidCode;
  final String errorCode;
  final String errorMessage;
  final String status;
  final String engine;

  const MacOsScannerDebugMetrics({
    this.permissionState = 'unknown',
    this.initialized = false,
    this.starting = false,
    this.running = false,
    this.cameraCount,
    this.elapsedSeconds = 0,
    this.invalidDetections = 0,
    this.lastSuccessfulCode = '',
    this.lastInvalidCode = '',
    this.errorCode = '',
    this.errorMessage = '',
    this.status = '',
    this.engine = 'mobile_scanner',
  });

  MacOsScannerDebugMetrics copyWith({
    String? permissionState,
    bool? initialized,
    bool? starting,
    bool? running,
    int? cameraCount,
    bool clearCameraCount = false,
    int? elapsedSeconds,
    int? invalidDetections,
    String? lastSuccessfulCode,
    String? lastInvalidCode,
    String? errorCode,
    String? errorMessage,
    String? status,
    String? engine,
  }) {
    return MacOsScannerDebugMetrics(
      permissionState: permissionState ?? this.permissionState,
      initialized: initialized ?? this.initialized,
      starting: starting ?? this.starting,
      running: running ?? this.running,
      cameraCount: clearCameraCount ? null : cameraCount ?? this.cameraCount,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      invalidDetections: invalidDetections ?? this.invalidDetections,
      lastSuccessfulCode: lastSuccessfulCode ?? this.lastSuccessfulCode,
      lastInvalidCode: lastInvalidCode ?? this.lastInvalidCode,
      errorCode: errorCode ?? this.errorCode,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
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

String buildMacOsScannerDiagnosis(MacOsScannerDebugMetrics metrics) {
  if (metrics.permissionState == 'denied') {
    return '可能是权限问题：请在系统设置中允许应用访问摄像头，然后重启应用。';
  }

  if (metrics.errorMessage.isNotEmpty) {
    return '原生扫描器启动异常：${metrics.errorMessage}';
  }

  if (metrics.running &&
      metrics.elapsedSeconds >= 12 &&
      metrics.invalidDetections > 0 &&
      metrics.lastSuccessfulCode.isEmpty) {
    return '摄像头预览正常，但当前识别到的更像不是 ISBN 条码，请确认扫描的是图书背面的 EAN/UPC 条码。';
  }

  if (metrics.running &&
      metrics.elapsedSeconds >= 15 &&
      metrics.lastSuccessfulCode.isEmpty) {
    if (metrics.cameraCount == null) {
      return '当前插件没有返回摄像头数量；如果预览画面正常，问题更像是对焦、反光或条码类型不匹配。';
    }
    return '摄像头流正常但暂未识别到 ISBN：请让条码占据取景框中部、保持水平，并控制距离在 20-35cm。';
  }

  if (metrics.initialized && !metrics.running && !metrics.starting) {
    return '扫描器已初始化但摄像头未运行，请确认摄像头没有被其他应用占用。';
  }

  if (!metrics.initialized &&
      !metrics.starting &&
      metrics.elapsedSeconds >= 5) {
    return '扫描器尚未完成初始化，请确认 macOS 已授予摄像头权限，并检查是否存在沙箱限制。';
  }

  return '扫描中：请将 ISBN 条码完整放入取景框并保持稳定 1-2 秒。';
}

String buildMacOsScannerDebugCode(MacOsScannerDebugMetrics metrics) {
  final diagnosis = buildMacOsScannerDiagnosis(metrics);
  return [
    'ISBN_SCANNER_DEBUG_V2_MACOS',
    'permissionState=${metrics.permissionState}',
    'initialized=${metrics.initialized}',
    'starting=${metrics.starting}',
    'running=${metrics.running}',
    'cameraCount=${metrics.cameraCount?.toString() ?? 'unknown'}',
    'elapsedSeconds=${metrics.elapsedSeconds}',
    'invalidDetections=${metrics.invalidDetections}',
    'lastSuccessfulCode=${metrics.lastSuccessfulCode}',
    'lastInvalidCode=${metrics.lastInvalidCode}',
    'errorCode=${metrics.errorCode}',
    'errorMessage=${metrics.errorMessage}',
    'status=${metrics.status}',
    'engine=${metrics.engine}',
    'diagnosis=$diagnosis',
  ].join('\n');
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
