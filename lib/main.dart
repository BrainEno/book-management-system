import 'package:bookstore_management_system/app/bookstore_app.dart';
import 'package:bookstore_management_system/app/bookstore_scope.dart';
import 'package:bookstore_management_system/app/bootstrap/app_startup.dart';
import 'package:bookstore_management_system/core/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestStartupPermissions();
  final windowController = await WindowController.fromCurrentEngine();
  final windowArguments = windowController.arguments;
  final isMultiWindow = isSubWindowLaunch(windowArguments);
  await initDependencies(
    isMultiWindow: isMultiWindow,
    windowId: windowController.windowId,
  );

  final subWindowPage = resolveSubWindowPage(windowArguments);
  if (subWindowPage != null) {
    await prepareSubWindowWindow(title: resolveSubWindowTitle(windowArguments));
    runApp(BookstoreScope(child: BookstoreSubWindowApp(page: subWindowPage)));
    return;
  }

  await prepareDesktopWindow();
  runApp(const BookstoreScope(child: BookstoreApp()));
}
