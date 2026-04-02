import 'dart:async';

import 'package:bonsoir/bonsoir.dart';
import 'package:flutter/foundation.dart';

@immutable
class MobileDiscoveryDebugState {
  final String platform;
  final String serviceType;
  final String status;
  final String desktopUrl;
  final String rawIp;
  final int port;
  final bool initialized;
  final bool starting;
  final bool discovering;
  final bool timedOut;
  final int elapsedSeconds;
  final int foundCount;
  final int resolvedCount;
  final int lostCount;
  final String lastEvent;
  final String lastError;

  const MobileDiscoveryDebugState({
    this.platform = 'unknown',
    this.serviceType = '',
    this.status = 'Ready',
    this.desktopUrl = '',
    this.rawIp = '',
    this.port = 0,
    this.initialized = false,
    this.starting = false,
    this.discovering = false,
    this.timedOut = false,
    this.elapsedSeconds = 0,
    this.foundCount = 0,
    this.resolvedCount = 0,
    this.lostCount = 0,
    this.lastEvent = '',
    this.lastError = '',
  });

  MobileDiscoveryDebugState copyWith({
    String? platform,
    String? serviceType,
    String? status,
    String? desktopUrl,
    String? rawIp,
    int? port,
    bool? initialized,
    bool? starting,
    bool? discovering,
    bool? timedOut,
    int? elapsedSeconds,
    int? foundCount,
    int? resolvedCount,
    int? lostCount,
    String? lastEvent,
    String? lastError,
  }) {
    return MobileDiscoveryDebugState(
      platform: platform ?? this.platform,
      serviceType: serviceType ?? this.serviceType,
      status: status ?? this.status,
      desktopUrl: desktopUrl ?? this.desktopUrl,
      rawIp: rawIp ?? this.rawIp,
      port: port ?? this.port,
      initialized: initialized ?? this.initialized,
      starting: starting ?? this.starting,
      discovering: discovering ?? this.discovering,
      timedOut: timedOut ?? this.timedOut,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      foundCount: foundCount ?? this.foundCount,
      resolvedCount: resolvedCount ?? this.resolvedCount,
      lostCount: lostCount ?? this.lostCount,
      lastEvent: lastEvent ?? this.lastEvent,
      lastError: lastError ?? this.lastError,
    );
  }
}

String? buildDiscoveredDesktopUrl({
  required String? rawIp,
  required int port,
  required bool useAndroidEmulatorLoopback,
}) {
  if (rawIp == null || rawIp.isEmpty || port <= 0) {
    return null;
  }

  final normalizedIp =
      useAndroidEmulatorLoopback && rawIp == '127.0.0.1' ? '10.0.2.2' : rawIp;
  return 'http://$normalizedIp:$port';
}

String buildMobileDiscoveryDiagnosis(MobileDiscoveryDebugState state) {
  if (state.serviceType.isEmpty) {
    return 'SERVICE_TYPE 未配置，移动端无法发现桌面端广播。';
  }

  if (state.desktopUrl.isNotEmpty) {
    return '已发现桌面设备，移动端可以进入扫码页并发送 ISBN。';
  }

  if (state.lastError.isNotEmpty) {
    return '设备发现流程报错：${state.lastError}';
  }

  if (!state.initialized && state.elapsedSeconds >= 3) {
    return 'Bonjour 发现器尚未完成初始化，请检查插件初始化或本地网络环境。';
  }

  if (state.foundCount > 0 && state.resolvedCount == 0) {
    return '已经发现服务，但还没有解析出可连接地址，可能是服务解析阶段失败。';
  }

  if (state.resolvedCount > 0 && state.desktopUrl.isEmpty) {
    return '服务已经解析，但广播里的 ip 或 port 无效，请检查桌面端广播属性。';
  }

  if (state.timedOut || state.elapsedSeconds >= 15) {
    if (state.platform == 'ios') {
      return 'iOS 长时间未收到可用服务，更像是本地网络权限未放行、两端不在同一局域网，或桌面端未正常广播。';
    }
    return '长时间未发现可用服务，请确认桌面端已开启广播并与手机位于同一局域网。';
  }

  return '正在等待 Bonjour 发现结果。';
}

String buildMobileDiscoveryDebugCode(MobileDiscoveryDebugState state) {
  return [
    'ISBN_MOBILE_DISCOVERY_DEBUG_V1',
    'platform=${state.platform}',
    'serviceType=${state.serviceType}',
    'initialized=${state.initialized}',
    'starting=${state.starting}',
    'discovering=${state.discovering}',
    'timedOut=${state.timedOut}',
    'elapsedSeconds=${state.elapsedSeconds}',
    'foundCount=${state.foundCount}',
    'resolvedCount=${state.resolvedCount}',
    'lostCount=${state.lostCount}',
    'desktopUrl=${state.desktopUrl}',
    'rawIp=${state.rawIp}',
    'port=${state.port}',
    'lastEvent=${state.lastEvent}',
    'lastError=${state.lastError}',
    'status=${state.status}',
    'diagnosis=${buildMobileDiscoveryDiagnosis(state)}',
  ].join('\n');
}

abstract class MobileDiscoverySession {
  Stream<BonsoirDiscoveryEvent> get eventStream;
  ServiceResolver get serviceResolver;

  Future<void> initialize();
  Future<void> start();
  Future<void> stop();
}

typedef MobileDiscoverySessionFactory =
    MobileDiscoverySession Function(String type);

class BonsoirMobileDiscoverySession implements MobileDiscoverySession {
  BonsoirMobileDiscoverySession(String type)
    : _discovery = BonsoirDiscovery(type: type);

  final BonsoirDiscovery _discovery;

  @override
  Stream<BonsoirDiscoveryEvent> get eventStream => _discovery.eventStream!;

  @override
  ServiceResolver get serviceResolver => _discovery.serviceResolver;

  @override
  Future<void> initialize() => _discovery.initialize();

  @override
  Future<void> start() => _discovery.start();

  @override
  Future<void> stop() => _discovery.stop();
}

class MobileDiscoveryController extends ChangeNotifier {
  MobileDiscoveryController({
    required this.serviceType,
    required this.platformLabel,
    required MobileDiscoverySessionFactory sessionFactory,
    this.timeout = const Duration(seconds: 60),
    this.elapsedTick = const Duration(seconds: 1),
    this.useAndroidEmulatorLoopback = false,
  }) : _sessionFactory = sessionFactory;

  final String serviceType;
  final String platformLabel;
  final Duration timeout;
  final Duration elapsedTick;
  final bool useAndroidEmulatorLoopback;
  final MobileDiscoverySessionFactory _sessionFactory;

  MobileDiscoveryDebugState _debugState = const MobileDiscoveryDebugState();
  MobileDiscoverySession? _session;
  StreamSubscription<BonsoirDiscoveryEvent>? _eventSubscription;
  Timer? _elapsedTimer;
  Timer? _timeoutTimer;
  DateTime? _startedAt;

  MobileDiscoveryDebugState get debugState => _debugState;
  String? get desktopUrl =>
      _debugState.desktopUrl.isEmpty ? null : _debugState.desktopUrl;

  Future<void> startDiscovery() async {
    await _disposeActiveDiscovery();

    final trimmedServiceType = serviceType.trim();
    if (trimmedServiceType.isEmpty) {
      _debugState = MobileDiscoveryDebugState(
        platform: platformLabel,
        serviceType: '',
        status: '缺少服务发现配置',
        lastError: 'SERVICE_TYPE 未配置',
      );
      notifyListeners();
      return;
    }

    _startedAt = DateTime.now();
    _debugState = MobileDiscoveryDebugState(
      platform: platformLabel,
      serviceType: trimmedServiceType,
      status: '正在搜索可用设备...',
      starting: true,
      lastEvent: 'initializing',
    );
    notifyListeners();

    final session = _sessionFactory(trimmedServiceType);
    _session = session;

    try {
      await session.initialize();
      if (_session != session) {
        return;
      }

      _debugState = _debugState.copyWith(
        initialized: true,
        lastEvent: 'initialized',
      );
      notifyListeners();

      _eventSubscription = session.eventStream.listen(
        _handleEvent,
        onError: _handleDiscoveryError,
      );

      await session.start();
      if (_session != session) {
        return;
      }

      _debugState = _debugState.copyWith(
        starting: false,
        discovering: true,
        lastEvent: 'started',
      );
      notifyListeners();
      _startTimers();
    } catch (error) {
      _handleDiscoveryError(error);
    }
  }

  Future<void> stopDiscovery() async {
    await _disposeActiveDiscovery();
    if (_debugState.desktopUrl.isEmpty) {
      _debugState = _debugState.copyWith(
        starting: false,
        discovering: false,
        lastEvent: 'stopped',
      );
      notifyListeners();
    }
  }

  Future<void> refresh() => startDiscovery();

  Future<void> _disposeActiveDiscovery() async {
    _timeoutTimer?.cancel();
    _elapsedTimer?.cancel();
    _timeoutTimer = null;
    _elapsedTimer = null;

    await _eventSubscription?.cancel();
    _eventSubscription = null;

    final session = _session;
    _session = null;
    if (session != null) {
      await session.stop();
    }
  }

  void _startTimers() {
    if (elapsedTick > Duration.zero) {
      _elapsedTimer = Timer.periodic(elapsedTick, (_) => _syncElapsed());
    }

    if (timeout > Duration.zero) {
      _timeoutTimer = Timer(timeout, () async {
        if (_debugState.desktopUrl.isNotEmpty) {
          return;
        }

        _syncElapsed();
        _debugState = _debugState.copyWith(
          timedOut: true,
          discovering: false,
          status: '暂未发现可用设备',
          lastEvent: 'timeout',
        );
        notifyListeners();
        await _disposeActiveDiscovery();
      });
    }
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

  Future<void> _handleEvent(BonsoirDiscoveryEvent event) async {
    switch (event) {
      case BonsoirDiscoveryStartedEvent():
        _debugState = _debugState.copyWith(lastEvent: 'discovery_started');
        notifyListeners();
        return;
      case BonsoirDiscoveryServiceFoundEvent():
        _debugState = _debugState.copyWith(
          foundCount: _debugState.foundCount + 1,
          lastEvent: 'service_found',
        );
        notifyListeners();

        try {
          await event.service.resolve(_session!.serviceResolver);
        } catch (error) {
          _handleDiscoveryError(error);
        }
        return;
      case BonsoirDiscoveryServiceResolvedEvent():
        final rawIp =
            event.service.attributes['ip'] ?? event.service.host ?? '';
        final url = buildDiscoveredDesktopUrl(
          rawIp: rawIp,
          port: event.service.port,
          useAndroidEmulatorLoopback: useAndroidEmulatorLoopback,
        );

        _debugState = _debugState.copyWith(
          resolvedCount: _debugState.resolvedCount + 1,
          rawIp: rawIp,
          port: event.service.port,
          lastEvent: 'service_resolved',
        );

        if (url == null) {
          _debugState = _debugState.copyWith(
            status: '发现服务但地址无效',
            lastError:
                'Invalid service data: IP=$rawIp, Port=${event.service.port}',
          );
          notifyListeners();
          return;
        }

        _debugState = _debugState.copyWith(
          desktopUrl: url,
          status: '已连接设备: $url',
          discovering: false,
        );
        notifyListeners();
        await _disposeActiveDiscovery();
        return;
      case BonsoirDiscoveryServiceLostEvent():
        _debugState = _debugState.copyWith(
          lostCount: _debugState.lostCount + 1,
          lastEvent: 'service_lost',
          status: _debugState.desktopUrl.isEmpty ? '设备已断开' : _debugState.status,
        );
        notifyListeners();
        return;
      case BonsoirDiscoveryServiceResolveFailedEvent():
        _debugState = _debugState.copyWith(
          lastEvent: 'resolve_failed',
          status: '发现服务但解析失败',
          lastError: 'Service resolve failed',
        );
        notifyListeners();
        return;
      case BonsoirDiscoveryStoppedEvent():
        _debugState = _debugState.copyWith(
          discovering: false,
          starting: false,
          lastEvent: 'discovery_stopped',
        );
        notifyListeners();
        return;
      case BonsoirDiscoveryUnknownEvent():
        _debugState = _debugState.copyWith(lastEvent: event.id ?? 'unknown');
        notifyListeners();
        return;
      case BonsoirDiscoveryServiceUpdatedEvent():
        _debugState = _debugState.copyWith(lastEvent: 'service_updated');
        notifyListeners();
        return;
    }
  }

  void _handleDiscoveryError(Object error) {
    _syncElapsed();
    _debugState = _debugState.copyWith(
      starting: false,
      discovering: false,
      lastEvent: 'error',
      lastError: error.toString(),
      status: '设备发现失败，请重试',
    );
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_disposeActiveDiscovery());
    super.dispose();
  }
}
