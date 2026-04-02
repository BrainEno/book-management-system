import 'dart:async';

import 'package:bookstore_management_system/features/product/utils/isbn_scanner_utils.dart';
import 'package:bookstore_management_system/features/product/utils/isbn_sender.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@immutable
class MobileIsbnScannerDebugState {
  final String desktopUrl;
  final String status;
  final bool initialized;
  final bool starting;
  final bool running;
  final String permissionState;
  final int? cameraCount;
  final int elapsedSeconds;
  final int detectionCount;
  final int invalidDetectionCount;
  final int sentCount;
  final int sendFailureCount;
  final String lastDisplayedCode;
  final String lastSuccessfulIsbn;
  final String lastInvalidCode;
  final String lastBarcodeFormat;
  final String lastSendResult;
  final bool cooldownActive;
  final int cooldownRemainingSeconds;
  final String errorCode;
  final String errorMessage;

  const MobileIsbnScannerDebugState({
    this.desktopUrl = '',
    this.status = '请将 ISBN 条码对准取景框中部。',
    this.initialized = false,
    this.starting = false,
    this.running = false,
    this.permissionState = 'unknown',
    this.cameraCount,
    this.elapsedSeconds = 0,
    this.detectionCount = 0,
    this.invalidDetectionCount = 0,
    this.sentCount = 0,
    this.sendFailureCount = 0,
    this.lastDisplayedCode = '',
    this.lastSuccessfulIsbn = '',
    this.lastInvalidCode = '',
    this.lastBarcodeFormat = '',
    this.lastSendResult = '',
    this.cooldownActive = false,
    this.cooldownRemainingSeconds = 0,
    this.errorCode = '',
    this.errorMessage = '',
  });

  MobileIsbnScannerDebugState copyWith({
    String? desktopUrl,
    String? status,
    bool? initialized,
    bool? starting,
    bool? running,
    String? permissionState,
    int? cameraCount,
    bool clearCameraCount = false,
    int? elapsedSeconds,
    int? detectionCount,
    int? invalidDetectionCount,
    int? sentCount,
    int? sendFailureCount,
    String? lastDisplayedCode,
    String? lastSuccessfulIsbn,
    String? lastInvalidCode,
    String? lastBarcodeFormat,
    String? lastSendResult,
    bool? cooldownActive,
    int? cooldownRemainingSeconds,
    String? errorCode,
    String? errorMessage,
  }) {
    return MobileIsbnScannerDebugState(
      desktopUrl: desktopUrl ?? this.desktopUrl,
      status: status ?? this.status,
      initialized: initialized ?? this.initialized,
      starting: starting ?? this.starting,
      running: running ?? this.running,
      permissionState: permissionState ?? this.permissionState,
      cameraCount: clearCameraCount ? null : cameraCount ?? this.cameraCount,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      detectionCount: detectionCount ?? this.detectionCount,
      invalidDetectionCount:
          invalidDetectionCount ?? this.invalidDetectionCount,
      sentCount: sentCount ?? this.sentCount,
      sendFailureCount: sendFailureCount ?? this.sendFailureCount,
      lastDisplayedCode: lastDisplayedCode ?? this.lastDisplayedCode,
      lastSuccessfulIsbn: lastSuccessfulIsbn ?? this.lastSuccessfulIsbn,
      lastInvalidCode: lastInvalidCode ?? this.lastInvalidCode,
      lastBarcodeFormat: lastBarcodeFormat ?? this.lastBarcodeFormat,
      lastSendResult: lastSendResult ?? this.lastSendResult,
      cooldownActive: cooldownActive ?? this.cooldownActive,
      cooldownRemainingSeconds:
          cooldownRemainingSeconds ?? this.cooldownRemainingSeconds,
      errorCode: errorCode ?? this.errorCode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

String buildMobileIsbnScannerDiagnosis(MobileIsbnScannerDebugState state) {
  if (state.cooldownActive) {
    return 'ISBN 已发送成功，扫描器正在短暂停用，避免同一本书被连续重复识别。';
  }

  if (state.permissionState == 'denied') {
    return '相机权限被拒绝，请在 iOS 设置中允许相机权限后重新打开扫描页。';
  }

  if (state.errorMessage.isNotEmpty) {
    return '移动端扫描器报错：${state.errorMessage}';
  }

  if (state.running &&
      state.elapsedSeconds >= 12 &&
      state.invalidDetectionCount > 0 &&
      state.lastSuccessfulIsbn.isEmpty) {
    return '摄像头已工作，但当前识别到的条码不像 ISBN，请确认对准的是图书背面的 EAN-13 条码。';
  }

  if (state.running &&
      state.elapsedSeconds >= 15 &&
      state.detectionCount == 0 &&
      state.lastSuccessfulIsbn.isEmpty) {
    return '摄像头正在运行但没有识别结果，请让条码占据扫描框中部，并保持 20-35cm 距离。';
  }

  if (state.sendFailureCount > 0 && state.lastSuccessfulIsbn.isEmpty) {
    return '条码已识别，但向桌面端发送失败，请检查手机和桌面端网络连通性。';
  }

  return '移动端扫描器运行中，请保持条码稳定 1-2 秒。';
}

String buildMobileIsbnScannerDebugCode(MobileIsbnScannerDebugState state) {
  return [
    'ISBN_MOBILE_SCANNER_DEBUG_V1',
    'desktopUrl=${state.desktopUrl}',
    'permissionState=${state.permissionState}',
    'initialized=${state.initialized}',
    'starting=${state.starting}',
    'running=${state.running}',
    'cameraCount=${state.cameraCount?.toString() ?? 'unknown'}',
    'elapsedSeconds=${state.elapsedSeconds}',
    'detectionCount=${state.detectionCount}',
    'invalidDetectionCount=${state.invalidDetectionCount}',
    'sentCount=${state.sentCount}',
    'sendFailureCount=${state.sendFailureCount}',
    'lastDisplayedCode=${state.lastDisplayedCode}',
    'lastSuccessfulIsbn=${state.lastSuccessfulIsbn}',
    'lastInvalidCode=${state.lastInvalidCode}',
    'lastBarcodeFormat=${state.lastBarcodeFormat}',
    'lastSendResult=${state.lastSendResult}',
    'cooldownActive=${state.cooldownActive}',
    'cooldownRemainingSeconds=${state.cooldownRemainingSeconds}',
    'errorCode=${state.errorCode}',
    'errorMessage=${state.errorMessage}',
    'status=${state.status}',
    'diagnosis=${buildMobileIsbnScannerDiagnosis(state)}',
  ].join('\n');
}

class MobileIsbnScannerController extends ChangeNotifier {
  MobileIsbnScannerController({
    required this.desktopUrl,
    IsbnSender? sender,
    this.elapsedTick = const Duration(seconds: 1),
    this.duplicateStatusSuppressDuration = const Duration(seconds: 5),
    DateTime Function()? now,
  }) : _sender = sender ?? IsbnSender(),
       _now = now ?? DateTime.now,
       _debugState = MobileIsbnScannerDebugState(desktopUrl: desktopUrl);

  final String desktopUrl;
  final IsbnSender _sender;
  final Duration elapsedTick;
  final Duration duplicateStatusSuppressDuration;
  final DateTime Function() _now;

  MobileIsbnScannerDebugState _debugState;
  MobileIsbnScannerDebugState get debugState => _debugState;

  String? _previousIsbn;
  Timer? _elapsedTimer;
  Timer? _cooldownTimer;
  DateTime? _startedAt;
  DateTime? _duplicateStatusSuppressedUntil;

  void startSession() {
    _startedAt ??= DateTime.now();
    if (elapsedTick > Duration.zero && _elapsedTimer == null) {
      _elapsedTimer = Timer.periodic(elapsedTick, (_) => _syncElapsed());
    }
  }

  void stopSession() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
  }

  void beginSuccessCooldown(Duration duration) {
    _cooldownTimer?.cancel();

    final remainingSeconds = duration.inSeconds;
    _debugState = _debugState.copyWith(
      cooldownActive: remainingSeconds > 0,
      cooldownRemainingSeconds: remainingSeconds,
      status:
          remainingSeconds > 0
              ? 'ISBN 已发送到桌面端，请移开当前图书，$remainingSeconds 秒后可继续扫描。'
              : 'ISBN 已发送到桌面端，请扫描下一本图书。',
    );
    notifyListeners();

    if (remainingSeconds <= 0) {
      return;
    }

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final secondsLeft = remainingSeconds - timer.tick;
      if (secondsLeft <= 0) {
        timer.cancel();
        _debugState = _debugState.copyWith(
          cooldownActive: false,
          cooldownRemainingSeconds: 0,
          status: '请将下一本图书的 ISBN 条码对准取景框中部。',
        );
        notifyListeners();
        return;
      }

      _debugState = _debugState.copyWith(
        cooldownActive: true,
        cooldownRemainingSeconds: secondsLeft,
        status: 'ISBN 已发送到桌面端，请移开当前图书，$secondsLeft 秒后可继续扫描。',
      );
      notifyListeners();
    });
  }

  void endSuccessCooldown() {
    _cooldownTimer?.cancel();
    _cooldownTimer = null;
    if (!_debugState.cooldownActive &&
        _debugState.cooldownRemainingSeconds == 0) {
      return;
    }
    _debugState = _debugState.copyWith(
      cooldownActive: false,
      cooldownRemainingSeconds: 0,
    );
    notifyListeners();
  }

  void updateScannerState(MobileScannerState state) {
    final errorCode = state.error?.errorCode.name ?? '';
    final errorMessage = state.error?.errorDetails?.message ?? '';

    _debugState = _debugState.copyWith(
      initialized: state.isInitialized,
      starting: state.isStarting,
      running: state.isRunning,
      permissionState: state.hasCameraPermission ? 'granted' : 'denied',
      cameraCount: state.availableCameras,
      clearCameraCount: state.availableCameras == null,
      errorCode: errorCode,
      errorMessage: errorMessage,
      status: _deriveStatus(state, errorMessage),
    );
    notifyListeners();
  }

  Future<bool> handleCapture(BarcodeCapture capture) async {
    for (final barcode in capture.barcodes) {
      final rawValue = barcode.rawValue;
      if (rawValue == null || rawValue.trim().isEmpty) {
        continue;
      }

      final normalized = normalizeIsbn(rawValue);
      final visibleCode = normalized.isEmpty ? rawValue.trim() : normalized;
      _debugState = _debugState.copyWith(
        detectionCount: _debugState.detectionCount + 1,
        lastDisplayedCode: visibleCode,
        lastBarcodeFormat: barcode.format.name,
      );
      notifyListeners();

      if (!isLikelyIsbn(normalized)) {
        _debugState = _debugState.copyWith(
          invalidDetectionCount: _debugState.invalidDetectionCount + 1,
          lastInvalidCode: visibleCode,
          status: '检测到非 ISBN 条码，已忽略',
        );
        notifyListeners();
        return false;
      }

      if (normalized == _previousIsbn) {
        if (_shouldSuppressDuplicateStatus(normalized)) {
          return false;
        }
        _debugState = _debugState.copyWith(status: '重复 ISBN，已忽略');
        notifyListeners();
        return false;
      }

      _previousIsbn = normalized;
      final success = await _sender.sendIsbn(normalized, desktopUrl);
      _debugState = _debugState.copyWith(
        lastSuccessfulIsbn:
            success ? normalized : _debugState.lastSuccessfulIsbn,
        sentCount: success ? _debugState.sentCount + 1 : _debugState.sentCount,
        sendFailureCount:
            success
                ? _debugState.sendFailureCount
                : _debugState.sendFailureCount + 1,
        lastSendResult: success ? 'success' : 'failure',
        status: success ? 'ISBN 已发送到桌面端' : 'ISBN 发送失败，请检查网络连接',
      );
      if (success) {
        _duplicateStatusSuppressedUntil = _now().add(
          duplicateStatusSuppressDuration,
        );
      }
      notifyListeners();
      return success;
    }

    return false;
  }

  void _syncElapsed() {
    final startedAt = _startedAt;
    if (startedAt == null) {
      return;
    }

    _debugState = _debugState.copyWith(
      elapsedSeconds: DateTime.now().difference(startedAt).inSeconds,
    );
    notifyListeners();
  }

  String _deriveStatus(MobileScannerState state, String errorMessage) {
    if (_debugState.cooldownActive) {
      final secondsLeft = _debugState.cooldownRemainingSeconds;
      return secondsLeft > 0
          ? 'ISBN 已发送到桌面端，请移开当前图书，$secondsLeft 秒后可继续扫描。'
          : '请将下一本图书的 ISBN 条码对准取景框中部。';
    }
    if (errorMessage.isNotEmpty) {
      return '扫描器异常，请查看调试信息';
    }
    if (state.isStarting) {
      return '摄像头启动中...';
    }
    if (!state.isInitialized) {
      return '正在初始化摄像头...';
    }
    if (!state.hasCameraPermission) {
      return '缺少相机权限';
    }
    if (state.isRunning) {
      return '摄像头已就绪，请将 ISBN 条码对准取景框中部。';
    }
    return '扫描器已初始化，但摄像头尚未运行。';
  }

  bool _shouldSuppressDuplicateStatus(String normalized) {
    final suppressedUntil = _duplicateStatusSuppressedUntil;
    if (suppressedUntil == null) {
      return false;
    }
    if (_debugState.lastSuccessfulIsbn != normalized) {
      return false;
    }
    return _now().isBefore(suppressedUntil);
  }

  @override
  void dispose() {
    stopSession();
    _cooldownTimer?.cancel();
    super.dispose();
  }
}
