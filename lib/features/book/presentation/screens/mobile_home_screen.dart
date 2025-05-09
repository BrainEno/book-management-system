import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:flutter/material.dart';
import 'package:bonsoir/bonsoir.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'scanner_screen.dart'; // Import the new ScannerPage

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
    setState(() => _status = 'Searching for service...');
    _discovery = BonsoirDiscovery(type: AppSecrets.serviceType!);
    if (_discovery == null) {
      _logger.w('BonsoirDiscovery not found');
    }
    await _discovery!.ready;
    await _discovery!.start();

    _discovery!.eventStream!.listen((event) async {
      if (event.type == BonsoirDiscoveryEventType.discoveryServiceFound) {
        final service = event.service;
        if (service != null) {
          final ip = service.attributes['ip'] ?? service.name;
          final port = AppSecrets.servicePort;

          if (ip.isNotEmpty && ip.isNotEmpty && port > 0) {
            final url = 'http://$ip:$port';
            _logger.i('Discovered desktop at $url');
            setState(() {
              _desktopUrl = url;
              _status = '已连接设备: $url';
            });
            await _discovery?.stop();
          } else {
            _logger.w('Invalid service data: IP=$ip, Port=$port');
          }
        } else if (event.type ==
            BonsoirDiscoveryEventType.discoveryServiceResolved) {
          _logger.i('Service resolved : ${event.service!.toJson()}');
        } else if (event.type ==
            BonsoirDiscoveryEventType.discoveryServiceLost) {
          _logger.w('Service lost : ${event.service!.toJson()}');
        }
      }
    });

    // Timeout if no service is found
    Future.delayed(const Duration(seconds: 15), () async {
      if (_desktopUrl == null) {
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
                  setState(() => _status = '暂无可用设备');
                }
              },
              child: const Text('扫描条形码'),
            ),
            SizedBox(height: 16),
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
