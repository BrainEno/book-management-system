import 'dart:convert';
import 'dart:io';

import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/window/sub_window_launch_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:window_manager/window_manager.dart';

bool isSubWindowLaunch(String windowArguments) {
  return windowArguments.isNotEmpty;
}

String? resolveSubWindowTitle(String windowArguments) {
  try {
    return resolveSubWindowLaunchData(windowArguments)?.title;
  } catch (_) {
    return null;
  }
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

Future<void> prepareSubWindowWindow({
  required SubWindowLaunchData launchData,
}) async {
  if (kIsWeb || !(Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    return;
  }

  try {
    await windowManager.ensureInitialized();
    final windowBounds = launchData.bounds?.toRect();
    final windowOptions = WindowOptions(
      size: Size(
        windowBounds?.width ?? 1240,
        windowBounds?.height ?? 900,
      ),
      center: windowBounds == null,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: launchData.title,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      if (windowBounds != null) {
        await windowManager.setBounds(windowBounds);
      }
      if (launchData.title.isNotEmpty) {
        await windowManager.setTitle(launchData.title);
      }
      await windowManager.show();
      await windowManager.focus();
    });
  } catch (error, stackTrace) {
    AppLogger.logger.w(
      'Sub-window window_manager initialization failed, falling back to default window behavior.',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

Widget? resolveSubWindowPage(String windowArguments) {
  if (!isSubWindowLaunch(windowArguments)) {
    return null;
  }

  try {
    final launchData = resolveSubWindowLaunchData(windowArguments);
    if (launchData == null) {
      return const Center(child: Text('Error: Invalid sub-window arguments'));
    }

    final pageKey = launchData.page;
    final destination =
        findAppWindowDestination(pageKey) ??
        findFloatingWindowDestination(pageKey);
    if (destination == null) {
      return Center(child: Text("Error: Unknown page key '$pageKey'"));
    }

    final payload = AppWindowPayload.fromJson(launchData.state);

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

SubWindowLaunchData? resolveSubWindowLaunchData(String windowArguments) {
  if (windowArguments.isEmpty) {
    return null;
  }

  try {
    final decoded = jsonDecode(windowArguments);
    if (decoded is Map<String, dynamic>) {
      return SubWindowLaunchData.fromJson(decoded);
    }
    if (decoded is Map) {
      return SubWindowLaunchData.fromJson(Map<String, dynamic>.from(decoded));
    }
  } catch (_) {
    return null;
  }

  return null;
}
