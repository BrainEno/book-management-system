import 'dart:io';

import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> configureAppEnvironment() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (error) {
    AppLogger.logger.i('Error loading .env file: $error');
  }

  final dbName = Platform.environment['DB_NAME'];
  final defaultPassword = Platform.environment['DEFAULT_PWD'];

  if (dbName != null && defaultPassword != null) {
    AppSecrets.dbName = dbName;
    AppSecrets.defaultPWD = defaultPassword;
    AppLogger.logger.i('Using GitHub Secrets for credentials.');
    return;
  }

  AppLogger.logger.i('Using .env file for credentials.');
}
