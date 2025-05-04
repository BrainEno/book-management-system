// ignore_for_file: avoid_print

import 'dart:math';

import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/theme/theme_bloc.dart';
import 'package:bookstore_management_system/features/auth/core/error/auth_exceptions.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/user_dao.dart';
import 'package:bookstore_management_system/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookstore_management_system/features/auth/domain/repository/auth_repository.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/usecases/login_usecase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/web.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final sl = GetIt.instance;
late AppDatabase database;
late Box<String> secureStorageBox; // Hive box for secure storage

Future<void> initDependencies() async {
  //Register Logger as a singleton
  sl.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(
        methodCount: 1, // Number of method calls to display
        errorMethodCount: 8, // Stack trace depth for errors
        lineLength: 120, // Width of log output
        colors: true, // Enable colorful logs
        printEmojis: true, // Add emojis to log messages
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    ),
  );

  // Load from .env (for local development)
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    AppLogger.logger.i("Error loading .env file: $e");
  }

  // Override with GitHub Secrets (for CI/CD)
  final dbName = Platform.environment['DB_NAME'];
  final defaultPWD = Platform.environment["DEFAULT_PWD"];

  if (dbName != null && defaultPWD != null) {
    AppSecrets.dbName = dbName;
    AppSecrets.defaultPWD = defaultPWD;
    AppLogger.logger.i("Using GitHub Secrets for credentials.");
  } else {
    AppLogger.logger.i("Using .env file for credentials.");
  }

  Directory appDocDir = await getApplicationDocumentsDirectory();
  Directory dbDir = Directory(appDocDir.path);

  if (!await dbDir.exists()) {
    await dbDir.create(recursive: true);
    AppLogger.logger.i("Database directory created at: ${dbDir.path}");
  } else {
    AppLogger.logger.i("Database directory already exists at: ${dbDir.path}");
  }

  // Initialize Hive
  await Hive.initFlutter();
  List<int> encryptionKey = await _getOrCreateEncryptionKey();
  secureStorageBox = await Hive.openBox<String>(
    'secure_storage',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );

  sl.registerSingleton<Box<String>>(secureStorageBox);
  sl.registerLazySingleton(() => ThemeBloc());

  database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);

  await _initAuth();

  try {
    final authDataSource = sl<AuthLocalDataSource>();

    await authDataSource.createUser(
      username: 'admin',
      password: AppSecrets.defaultPWD ?? 'admin123',
      role: 'admin',
    );
  } on AuthException catch (e) {
    AppLogger.logger.i("WARN: Creating user: ${e.message}");
  } catch (e) {
    AppLogger.logger.e("Error: initializing database: $e");
  }
}

Future<void> _initAuth() async {
  // DAOs
  sl
    ..registerFactory(() => UserDao(sl()))
    // DataSources
    ..registerFactory<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<AppDatabase>(), sl<Box<String>>()),
    )
    // Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthLocalDataSource>()),
    )
    // Usecases
    ..registerFactory(() => LoginUsecase(sl()))
    // Blocs
    ..registerLazySingleton(() => AuthBloc(sl()));
}

// Securely retrieve or create the encryption key
Future<List<int>> _getOrCreateEncryptionKey() async {
  // Check .env for "ENCRYPTION_KEY"
  String? envKey = dotenv.env['ENCRYPTION_KEY'];
  if (envKey != null) {
    List<int>? key = _hexToList(envKey);
    if (key != null && key.length == 32) {
      AppLogger.logger.i("Using encryption key from .env");
      return key;
    } else {
      AppLogger.logger.i("Invalid encryption key in .env, checking local file");
    }
  }

  // Check local file
  Directory appDocDir = await getApplicationDocumentsDirectory();
  File keyFile = File('${appDocDir.path}/encryption_key.txt');
  if (await keyFile.exists()) {
    try {
      String storedHex = await keyFile.readAsString();
      List<int>? key = _hexToList(storedHex);
      if (key != null && key.length == 32) {
        AppLogger.logger.i("Using encryption key from local file");
        return key;
      } else {
        AppLogger.logger.i(
          "Invalid encryption key in local file, generating a new one",
        );
      }
    } catch (e) {
      AppLogger.logger.i("Error reading encryption key file: $e");
    }
  }

  // Generate a new secure key
  List<int> key = _generateSecureKey();
  String hexKey = _listToHex(key);
  try {
    await keyFile.writeAsString(hexKey);
    AppLogger.logger.i("Generated and stored new encryption key");
  } catch (e) {
    AppLogger.logger.i("Error writing encryption key file: $e");
  }
  return key;
}

// Generate a 32-byte cryptographically secure key
List<int> _generateSecureKey() {
  final random = Random.secure();
  return List<int>.generate(32, (i) => random.nextInt(256));
}

// Convert List<int> to hex string
String _listToHex(List<int> list) {
  return list.map((e) => e.toRadixString(16).padLeft(2, '0')).join('');
}

// Convert hex string to List<int>
List<int>? _hexToList(String hex) {
  if (hex.length % 2 != 0) return null; // Must be even length for valid hex
  try {
    return List<int>.generate(
      hex.length ~/ 2,
      (i) => int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16),
    );
  } catch (e) {
    return null; // Return null if hex string is invalid
  }
}
