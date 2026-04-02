import 'dart:io';

import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/features/product/presentation/controllers/mobile_discovery_controller.dart';
import 'package:flutter/material.dart';

import 'scanner_screen.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  late final MobileDiscoveryController _discoveryController;
  bool _debugMode = false;

  @override
  void initState() {
    super.initState();
    _discoveryController = MobileDiscoveryController(
      serviceType: AppSecrets.serviceType ?? '',
      platformLabel: Platform.operatingSystem,
      sessionFactory: (type) => BonsoirMobileDiscoverySession(type),
      useAndroidEmulatorLoopback: Platform.isAndroid,
    )..startDiscovery();
  }

  @override
  void dispose() {
    _discoveryController.dispose();
    super.dispose();
  }

  void _openScanner() {
    final desktopUrl = _discoveryController.desktopUrl;
    if (desktopUrl == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('暂无可用设备，请先重新识别设备')));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ScannerScreen(desktopUrl: desktopUrl, debugMode: _debugMode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _discoveryController,
      builder: (context, _) {
        final state = _discoveryController.debugState;
        final diagnosis = buildMobileDiscoveryDiagnosis(state);
        final debugCode = buildMobileDiscoveryDebugCode(state);

        return Scaffold(
          appBar: AppBar(title: const Text('ISBN扫描器')),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      state.status,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      diagnosis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _openScanner,
                      child: const Text('扫描条形码'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _discoveryController.refresh,
                      child: const Text('重新识别设备'),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('调试模式'),
                      subtitle: const Text('显示 Bonjour 发现和移动端扫码的关键状态'),
                      value: _debugMode,
                      onChanged: (value) {
                        setState(() => _debugMode = value);
                      },
                    ),
                    if (_debugMode) ...[
                      const SizedBox(height: 12),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '移动端设备发现调试信息',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 12),
                              SelectableText(
                                debugCode,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
