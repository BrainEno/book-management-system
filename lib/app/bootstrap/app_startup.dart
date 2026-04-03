import 'dart:convert';
import 'dart:io';

import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:window_manager/window_manager.dart';

bool isSubWindowLaunch(String windowArguments) {
  return windowArguments.isNotEmpty;
}

String? resolveSubWindowTitle(String windowArguments) {
  if (windowArguments.isEmpty) {
    return null;
  }

  try {
    final arguments = jsonDecode(windowArguments);
    if (arguments is Map) {
      return arguments['title'] as String?;
    }
  } catch (_) {
    return null;
  }

  return null;
}

Future<void> requestStartupPermissions() async {
  if (!(Platform.isIOS || Platform.isAndroid)) {
    return;
  }

  final cameraStatus = await Permission.camera.request();
  if (cameraStatus.isGranted && kDebugMode) {
    AppLogger.logger.i('Camera permission granted');
  }

  final photoStatus = await Permission.photos.request();
  if (photoStatus.isGranted && kDebugMode) {
    AppLogger.logger.i('Photo library permission granted');
  }

  final nearbyStatus = await Permission.nearbyWifiDevices.request();
  if (nearbyStatus.isGranted) {
    AppLogger.logger.i('Nearby WiFi devices permission granted');
  }
}

Future<void> prepareDesktopWindow() async {
  if (kIsWeb || !(Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    return;
  }

  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    size: Size(1280, 720),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

Future<void> prepareSubWindowWindow({String? title}) async {
  if (kIsWeb || !(Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    return;
  }

  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    size: Size(1240, 900),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    if (title != null && title.isNotEmpty) {
      await windowManager.setTitle(title);
    }
    await windowManager.show();
    await windowManager.focus();
  });
}

Widget? resolveSubWindowPage(String windowArguments) {
  if (!isSubWindowLaunch(windowArguments)) {
    return null;
  }

  try {
    final arguments = _decodeSubWindowArguments(windowArguments);
    final pageKey = arguments['page'] as String? ?? '';
    final destination =
        findAppWindowDestination(pageKey) ??
        findFloatingWindowDestination(pageKey);
    if (destination == null) {
      return Center(child: Text("Error: Unknown page key '$pageKey'"));
    }

    final payload = AppWindowPayload(
      initialProducts: _parseInitialProducts(arguments['state']),
      initialProduct: _parseInitialProduct(arguments['state']),
    );

    return Builder(builder: (context) => destination.builder(context, payload));
  } catch (error, stackTrace) {
    AppLogger.logger.e(
      'Failed to resolve sub-window page',
      error: error,
      stackTrace: stackTrace,
    );
    return Center(child: Text('Error: Failed to parse sub-window arguments'));
  }
}

Map<String, dynamic> _decodeSubWindowArguments(String windowArguments) {
  if (windowArguments.isEmpty) {
    return const {};
  }

  final decoded = jsonDecode(windowArguments);
  if (decoded is Map<String, dynamic>) {
    return decoded;
  }
  if (decoded is Map) {
    return Map<String, dynamic>.from(decoded);
  }

  return const {};
}

List<ProductModel>? _parseInitialProducts(dynamic initialStateJson) {
  if (initialStateJson is! String || initialStateJson.isEmpty) {
    return null;
  }

  final decodedState = jsonDecode(initialStateJson);
  if (decodedState is! Map) {
    return null;
  }

  final rawProducts = decodedState['products'];
  if (rawProducts is! List) {
    return null;
  }

  final products = <ProductModel>[];
  for (final item in rawProducts) {
    if (item is Map) {
      products.add(ProductModel.fromJson(Map<String, dynamic>.from(item)));
    }
  }

  return products.isEmpty ? null : products;
}

ProductModel? _parseInitialProduct(dynamic initialStateJson) {
  if (initialStateJson is! String || initialStateJson.isEmpty) {
    return null;
  }

  final decodedState = jsonDecode(initialStateJson);
  if (decodedState is! Map) {
    return null;
  }

  final rawProduct = decodedState['product'];
  if (rawProduct is! Map) {
    return null;
  }

  return ProductModel.fromJson(Map<String, dynamic>.from(rawProduct));
}
