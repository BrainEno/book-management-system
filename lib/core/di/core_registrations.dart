import 'package:bookstore_management_system/app/bootstrap/app_runtime.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/theme/theme_bloc.dart';
import 'package:logger/logger.dart';

void registerCoreDependencies({
  required bool isMultiWindow,
  String? windowId,
  String? hostWindowId,
}) {
  sl.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    ),
  );

  sl.registerSingleton<AppRuntime>(
    AppRuntime(
      isSubWindow: isMultiWindow,
      windowId: windowId,
      hostWindowId: hostWindowId,
    ),
  );
  sl.registerLazySingleton(() => ThemeBloc());
}
