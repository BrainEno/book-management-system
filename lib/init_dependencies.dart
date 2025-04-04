// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bookstore_management_system/core/constants/secrets/app_secrets.dart';
import 'package:bookstore_management_system/core/data/datasources/local/database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import 'package:drift/drift.dart';

final serviceLocator = GetIt.instance;
late AppDatabase database;

Future<void> initDependencies() async {
  // Load from .env (for local development)
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  // Override with GitHub Secrets (for CI/CD)
  final dbName = Platform.environment['DB_NAME'];

  if (dbName != null) {
    AppSecrets.dbName = dbName;

    print("Using GitHub Secrets for credentials.");
  } else {
    print("Using .env file for credentials.");
    print("DB_NAME: ${AppSecrets.dbName}");
  }

  Directory appDocDir = await getApplicationDocumentsDirectory();

  Directory dbDir = Directory(appDocDir.path);

  if (!await dbDir.exists()) {
    await dbDir.create(recursive: true);
    print("Database directory created at: ${dbDir.path}");
  } else {
    print("Database directory already exists at: ${dbDir.path}");
  }

  database = AppDatabase();
  serviceLocator.registerSingleton<AppDatabase>(database);

  try {
    // Insert default admin user if not exists
    final userDao = database.userDao;
    final existingUsers = await userDao.getAllUsers();

    if (existingUsers.isEmpty) {
      await userDao.insertUser(
        UsersCompanion(
          username: const Value("admin"),
          password: const Value("admin123"),
          role: const Value('admin'),
        ),
      );
      print("Default admin user inserted.");
    } else {
      print("Admin user already exists.");
    }
  } catch (e) {
    print("Error inserting default admin:$e");
  }
}
