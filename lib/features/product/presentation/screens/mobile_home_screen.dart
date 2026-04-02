import 'dart:io';
import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:flutter/material.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'scanner_screen.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  String _status = 'Ready';
  String? _desktopUrl;
  BonsoirDiscovery? _discovery;
  final _logger = AppLogger.logger;

  @override
  void initState() {
    super.initState();
    _discoverService();
  }

  @override
  void dispose() {
    _discovery?.stop();
    super.dispose();
  }

  Future<void> _discoverService() async {
    setState(() => _status = '正在搜索可用设备...');
    _discovery = BonsoirDiscovery(type: AppSecrets.serviceType!);
    await _discovery!.start();

    _discovery!.eventStream!.listen((event) async {
      if (event is BonsoirDiscoveryServiceFoundEvent) {
        final service = event.service;
        if (service != null) {
          await service.resolve(_discovery!.serviceResolver); // 触发解析以获取完整信息
          _logger.i('Service found, resolving: ${service.toJson()}');
        }
      } else if (event is BonsoirDiscoveryServiceResolvedEvent) {
        final service = event.service;
        if (service != null) {
          final rawIp = service.attributes['ip'];
          final ip =
              (rawIp == '127.0.0.1' && Platform.isAndroid) ? '10.0.2.2' : rawIp;
          final port = service.port; // 使用广播的实际端口，而非硬编码
          if (ip != null && ip.isNotEmpty && port > 0) {
            final url = 'http://$ip:$port';
            _logger.i('Discovered desktop at $url');
            if (mounted) {
              setState(() {
                _desktopUrl = url;
                _status = '已连接设备: $url';
              });
            }
            await _discovery?.stop();
          } else {
            _logger.w('Invalid service data: IP=$ip, Port=$port');
          }
        }
      } else if (event is BonsoirDiscoveryServiceLostEvent) {
        _logger.w('Service lost: ${event.service?.toJson()}');
        if (mounted && _desktopUrl != null) {
          setState(() => _status = '设备已断开');
        }
      }
    });

    // 超时处理
    Future.delayed(const Duration(seconds: 60), () async {
      if (_desktopUrl == null && mounted) {
        _logger.w('设备连接超时');
        setState(() => _status = '暂未发现可用设备');
        await _discovery?.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ISBN扫描器')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_desktopUrl != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ScannerScreen(desktopUrl: _desktopUrl!),
                    ),
                  );
                } else {
                  setState(() => _status = '暂无可用设备，请点击“重新识别设备”');
                }
              },
              child: const Text('扫描条形码'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _discoverService,
              child: const Text('重新识别设备'),
            ),
          ],
        ),
      ),
    );
  }
}
