import 'dart:io';

import 'package:bonsoir/bonsoir.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:flutter/widgets.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

class ProductEditorIsbnReceiverService {
  final _logger = AppLogger.logger;

  HttpServer? _server;
  BonsoirBroadcast? _broadcast;

  Future<void> start({required ValueChanged<String> onIsbnReceived}) async {
    await stop();

    final router = shelf_router.Router()
      ..post('/isbn', (Request req) async {
        final isbn = await req.readAsString();
        _logger.i('Received ISBN via HTTP: $isbn');
        onIsbnReceived(isbn);
        return Response.ok('OK');
      });

    _server = await io.serve(
      logRequests().addHandler(router.call),
      InternetAddress.anyIPv4,
      AppSecrets.servicePort,
    );

    final port = _server!.port;
    final ipv4 = await _resolveIpv4Address();

    _logger.i('HTTP server listening on http://$ipv4:$port');

    final service = BonsoirService(
      name: 'Bookstore Desktop',
      type: AppSecrets.serviceType!,
      port: port,
      attributes: {'ip': ipv4},
    );

    _broadcast = BonsoirBroadcast(service: service);
    await _broadcast!.initialize();
    await _broadcast!.start();

    _logger.i(
      'Advertised Bonsoir service ${AppSecrets.serviceType} on port $port with IP $ipv4',
    );
  }

  Future<String> _resolveIpv4Address() async {
    final interfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
      includeLoopback: false,
    );

    for (final interface in interfaces) {
      for (final address in interface.addresses) {
        if (!address.isLoopback) {
          return address.address;
        }
      }
    }

    return InternetAddress.loopbackIPv4.address;
  }

  Future<void> stop() async {
    await _broadcast?.stop();
    await _server?.close();
    _broadcast = null;
    _server = null;
  }
}
