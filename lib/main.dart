import 'package:bookstore_management_system/app/bookstore_app.dart';
import 'package:bookstore_management_system/app/bookstore_scope.dart';
import 'package:bookstore_management_system/app/bootstrap/app_startup.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/init_dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:logger/logger.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestStartupPermissions();
  final windowController = await WindowController.fromCurrentEngine();
  final windowArguments = windowController.arguments;
  final isMultiWindow = isSubWindowLaunch(windowArguments);
  final launchData = resolveSubWindowLaunchData(windowArguments);
  await initDependencies(
    isMultiWindow: isMultiWindow,
    windowId: windowController.windowId,
    hostWindowId: launchData?.hostWindowId,
  );
  _installGlobalErrorHandlers();

  final subWindowPage = resolveSubWindowPage(windowArguments);
  if (subWindowPage != null) {
    if (launchData != null) {
      await prepareSubWindowWindow(launchData: launchData);
    }
    runApp(BookstoreScope(child: BookstoreSubWindowApp(page: subWindowPage)));
    return;
  }

  await prepareDesktopWindow();
  runApp(const BookstoreScope(child: BookstoreApp()));
}

void _installGlobalErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    _logUnhandledError(
      details.exception,
      details.stack ?? StackTrace.current,
      context: details.context?.toDescription(),
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    _logUnhandledError(error, stack, context: 'PlatformDispatcher.onError');
    return false;
  };
}

void _logUnhandledError(
  Object error,
  StackTrace stackTrace, {
  String? context,
}) {
  final loggerMessage = context == null
      ? 'Unhandled application error'
      : 'Unhandled application error ($context)';

  if (sl.isRegistered<Logger>()) {
    try {
      AppLogger.logger.e(loggerMessage, error: error, stackTrace: stackTrace);
      return;
    } catch (_) {
      // Fallback to debug printing below.
    }
  }

  debugPrint('$loggerMessage: $error');
  debugPrintStack(stackTrace: stackTrace);
}
