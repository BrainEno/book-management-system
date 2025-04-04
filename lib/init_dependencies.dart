// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bookstore_management_system/core/constants/secrets/app_secrets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Load from .env (for local development)
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  // Override with GitHub Secrets (for CI/CD)
  final dbPath = Platform.environment['DB_PATH'];
  final dbName = Platform.environment['DB_NAME'];

  if (dbPath != null && dbName != null) {
    AppSecrets.dbPath = dbPath;
    AppSecrets.dbName = dbName;

    print("Using GitHub Secrets for Supabase credentials.");
  } else {
    print("Using .env file for Supabase credentials.");
  }

  Directory appDocDir = await getApplicationDocumentsDirectory();

  Directory dbDir = Directory('${appDocDir.path}/$dbName');

  if (!await dbDir.exists()) {
    await dbDir.create(recursive: true);
    print("Database directory created at: ${dbDir.path}");
  } else {
    print("Database directory already exists at: ${dbDir.path}");
  }
}
