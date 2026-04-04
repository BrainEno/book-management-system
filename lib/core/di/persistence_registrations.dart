import 'dart:io';
import 'dart:math';

import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> registerPersistenceDependencies({
  required bool isMultiWindow,
}) async {
  await _registerHiveBoxes(isMultiWindow: isMultiWindow);
  await _registerDatabase();
}

Future<void> _registerHiveBoxes({required bool isMultiWindow}) async {
  if (!isMultiWindow) {
    await Hive.initFlutter();

    final encryptionKey = await _getOrCreateEncryptionKey();
    final secureStorageBox = await Hive.openBox<String>(
      'secure_storage',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    sl.registerSingleton<Box<String>>(secureStorageBox);
    return;
  }

  final tempDir = await getTemporaryDirectory();
  final subWindowPath =
      '${tempDir.path}/sub_window_${DateTime.now().millisecondsSinceEpoch}';
  await Directory(subWindowPath).create(recursive: true);
  Hive.init(subWindowPath);

  final secureStorageBox = await Hive.openBox<String>('secure_storage_dummy');

  sl.registerSingleton<Box<String>>(secureStorageBox);

  AppLogger.logger.i('Initialized Hive for multi-window at $subWindowPath');
}

Future<void> _registerDatabase() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final dbDir = Directory(appDocDir.path);

  if (!await dbDir.exists()) {
    await dbDir.create(recursive: true);
    AppLogger.logger.i('Database directory created at: ${dbDir.path}');
  } else {
    AppLogger.logger.i('Database directory already exists at: ${dbDir.path}');
  }

  final database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);
  await database.customSelect('SELECT 1').get();
}

Future<List<int>> _getOrCreateEncryptionKey() async {
  final envKey = dotenv.env['ENCRYPTION_KEY'];
  if (envKey != null) {
    final key = _hexToList(envKey);
    if (key != null && key.length == 32) {
      AppLogger.logger.i('Using encryption key from .env');
      return key;
    }

    AppLogger.logger.i('Invalid encryption key in .env, checking local file');
  }

  final appDocDir = await getApplicationDocumentsDirectory();
  final keyFile = File('${appDocDir.path}/encryption_key.txt');
  if (await keyFile.exists()) {
    try {
      final storedHex = await keyFile.readAsString();
      final key = _hexToList(storedHex);
      if (key != null && key.length == 32) {
        AppLogger.logger.i('Using encryption key from local file');
        return key;
      }

      AppLogger.logger.i(
        'Invalid encryption key in local file, generating a new one',
      );
    } catch (error) {
      AppLogger.logger.i('Error reading encryption key file: $error');
    }
  }

  final key = _generateSecureKey();
  final hexKey = _listToHex(key);
  try {
    await keyFile.writeAsString(hexKey);
    AppLogger.logger.i('Generated and stored new encryption key');
  } catch (error) {
    AppLogger.logger.i('Error writing encryption key file: $error');
  }

  return key;
}

List<int> _generateSecureKey() {
  final random = Random.secure();
  return List<int>.generate(32, (_) => random.nextInt(256));
}

String _listToHex(List<int> list) {
  return list.map((value) => value.toRadixString(16).padLeft(2, '0')).join('');
}

List<int>? _hexToList(String hex) {
  if (hex.length.isOdd) {
    return null;
  }

  try {
    return List<int>.generate(
      hex.length ~/ 2,
      (index) => int.parse(hex.substring(index * 2, index * 2 + 2), radix: 16),
    );
  } catch (_) {
    return null;
  }
}
