import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/core/di/core_registrations.dart';
import 'package:bookstore_management_system/core/di/environment_config.dart';
import 'package:bookstore_management_system/core/di/feature_registrations.dart';
import 'package:bookstore_management_system/core/di/persistence_registrations.dart';

export 'package:bookstore_management_system/core/di/service_locator.dart';

Future<void> initDependencies({
  bool isMultiWindow = false,
  String? windowId,
  String? hostWindowId,
}) async {
  registerCoreDependencies(
    isMultiWindow: isMultiWindow,
    windowId: windowId,
    hostWindowId: hostWindowId,
  );
  await configureAppEnvironment();
  await registerPersistenceDependencies(isMultiWindow: isMultiWindow);
  registerFeatureDependencies();

  if (!isMultiWindow) {
    await seedDefaultAdminUser(AppSecrets.defaultPWD ?? 'admin123');
  }
}
