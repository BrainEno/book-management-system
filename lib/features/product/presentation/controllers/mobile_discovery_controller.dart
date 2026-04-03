import 'dart:async';

import 'package:bonsoir/bonsoir.dart';
import 'package:bookstore_management_system/features/product/presentation/controllers/mobile_discovery_debug_state.dart';
import 'package:flutter/foundation.dart';

export 'mobile_discovery_debug_state.dart';

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
