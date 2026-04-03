import 'package:bookstore_management_system/app/bookstore_app.dart';
import 'package:bookstore_management_system/app/bookstore_scope.dart';
import 'package:bookstore_management_system/app/bootstrap/app_startup.dart';
import 'package:bookstore_management_system/core/init_dependencies.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestStartupPermissions();
  final isMultiWindow = isSubWindowLaunch(args);
  await initDependencies(isMultiWindow: isMultiWindow);

  final subWindowPage = resolveSubWindowPage(args);
  if (subWindowPage != null) {
    runApp(BookstoreScope(child: BookstoreSubWindowApp(page: subWindowPage)));
    return;
  }

  await prepareDesktopWindow();
  runApp(const BookstoreScope(child: BookstoreApp()));
}
