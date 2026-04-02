import 'dart:async';

import 'package:bonsoir/bonsoir.dart';
import 'package:bookstore_management_system/features/product/presentation/controllers/mobile_discovery_controller.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeResolver with ServiceResolver {
  final List<BonsoirService> resolvedServices = <BonsoirService>[];

  @override
  Future<void> resolveService(BonsoirService service) async {
    resolvedServices.add(service);
  }
}

class _FakeDiscoverySession implements MobileDiscoverySession {
  _FakeDiscoverySession(this.calls)
    : _controller = StreamController<BonsoirDiscoveryEvent>.broadcast(
        onListen: () => calls.add('listen'),
      );

  final List<String> calls;
  final StreamController<BonsoirDiscoveryEvent> _controller;
  final _FakeResolver _resolver = _FakeResolver();

  @override
  Stream<BonsoirDiscoveryEvent> get eventStream => _controller.stream;

  @override
  ServiceResolver get serviceResolver => _resolver;

  @override
  Future<void> initialize() async {
    calls.add('initialize');
  }

  @override
  Future<void> start() async {
    calls.add('start');
  }

  @override
  Future<void> stop() async {
    calls.add('stop');
    await _controller.close();
  }

  void emit(BonsoirDiscoveryEvent event) {
    _controller.add(event);
  }
}

void main() {
  Future<void> flushEvents() async {
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
  }

  group('MobileDiscoveryController', () {
    test('initializes and listens before starting discovery', () async {
      final calls = <String>[];
      late _FakeDiscoverySession session;
      final controller = MobileDiscoveryController(
        serviceType: '_bookstore._tcp',
        platformLabel: 'ios',
        sessionFactory: (type) {
          calls.add('factory:$type');
          session = _FakeDiscoverySession(calls);
          return session;
        },
        timeout: Duration.zero,
        elapsedTick: Duration.zero,
      );

      await controller.startDiscovery();

      expect(
        calls,
        containsAllInOrder(<String>[
          'factory:_bookstore._tcp',
          'initialize',
          'listen',
          'start',
        ]),
      );
      expect(controller.debugState.initialized, isTrue);
      expect(controller.debugState.discovering, isTrue);

      await controller.stopDiscovery();
      expect(session._resolver.resolvedServices, isEmpty);
    });

    test('updates desktop url when a service is resolved', () async {
      late _FakeDiscoverySession session;
      final controller = MobileDiscoveryController(
        serviceType: '_bookstore._tcp',
        platformLabel: 'ios',
        sessionFactory: (_) {
          session = _FakeDiscoverySession(<String>[]);
          return session;
        },
        timeout: Duration.zero,
        elapsedTick: Duration.zero,
      );

      await controller.startDiscovery();
      session.emit(
        BonsoirDiscoveryServiceResolvedEvent(
          service: BonsoirService.ignoreNorms(
            name: 'Bookstore Desktop',
            type: '_bookstore._tcp',
            port: 8080,
            attributes: {'ip': '192.168.1.8'},
          ),
        ),
      );
      await flushEvents();

      expect(controller.desktopUrl, 'http://192.168.1.8:8080');
      expect(controller.debugState.status, '已连接设备: http://192.168.1.8:8080');
    });

    test('reports configuration error when service type is missing', () async {
      final controller = MobileDiscoveryController(
        serviceType: '',
        platformLabel: 'ios',
        sessionFactory: (_) => _FakeDiscoverySession(<String>[]),
        timeout: Duration.zero,
        elapsedTick: Duration.zero,
      );

      await controller.startDiscovery();

      expect(controller.debugState.status, '缺少服务发现配置');
      expect(controller.debugState.lastError, 'SERVICE_TYPE 未配置');
      expect(
        buildMobileDiscoveryDiagnosis(controller.debugState),
        contains('SERVICE_TYPE 未配置'),
      );
    });

    test('converts localhost to android emulator loopback when requested', () {
      expect(
        buildDiscoveredDesktopUrl(
          rawIp: '127.0.0.1',
          port: 8080,
          useAndroidEmulatorLoopback: true,
        ),
        'http://10.0.2.2:8080',
      );
    });
  });
}
