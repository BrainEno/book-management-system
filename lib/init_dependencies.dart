import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/core/database/database.dart';
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
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final sl = GetIt.instance;
late AppDatabase database;
late Box<String> secureStorageBox; // Hive box for secure storage

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

  // Initialize Hive
  await Hive.initFlutter();
  secureStorageBox = await Hive.openBox<String>(
    'secure_storage',
    encryptionCipher: HiveAesCipher(_generateEncryptionKey()),
  );
  sl.registerSingleton<Box<String>>(secureStorageBox);

  database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);

  // Initialize the database
  await _initAuth();

  try {
    final authDataSource = sl<AuthLocalDataSource>();
    await authDataSource.createUser(
      username: 'admin',
      password: 'admin123',
      role: 'admin',
    );
  } on AuthException catch (e) {
    print("Error creating user: ${e.message}");
  } catch (e) {
    print("Error initializing database: $e");
  }
}

// Generate a 32-byte key for Hive encryption (you should store this securely in production)
List<int> _generateEncryptionKey() {
  // In a real app, use a secure key generation method and store it securely
  return List<int>.generate(32, (i) => i % 256); // Dummy key for demonstration
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
