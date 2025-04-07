import 'package:bcrypt/bcrypt.dart';
import 'package:bookstore_management_system/core/common/models/app_user_model.dart';
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/auth/core/error/auth_exceptions.dart';
import 'package:drift/drift.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:hive/hive.dart';
import 'package:sqlite3/sqlite3.dart';

class UsernameAlreadyExistsException extends AuthException {
  UsernameAlreadyExistsException(super.message);
}

class AuthDatabaseException extends AuthException {
  AuthDatabaseException(super.message);
}

abstract interface class AuthLocalDataSource {
  Future<AppUserModel> createUser({
    required String username,
    required String password,
    required String role,
    String? email,
    String? phone,
    String? name,
  });

  Future<AppUserModel> loginWithUsernamePassword({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<AppUserModel?> currentUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AppDatabase database;
  final Box<String> secureStorageBox;

  static const _sessionUserIdKey = 'current_user_id';
  // Encryption setup
  static final _key = encrypt.Key.fromLength(
    32,
  ); // Should be securely generated/stored in production
  static final _iv = encrypt.IV.fromLength(16);
  final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  AuthLocalDataSourceImpl(this.database, this.secureStorageBox);

  String _encryptData(String data) {
    return _encrypter.encrypt(data, iv: _iv).base64;
  }

  String _decryptData(String encryptedData) {
    return _encrypter.decrypt64(encryptedData, iv: _iv);
  }

  @override
  Future<AppUserModel> createUser({
    required String username,
    required String password,
    required String role,
    String? email,
    String? phone,
    String? name,
  }) async {
    try {
      final userDao = database.userDao;
      final existingUser = await userDao.getUserByUsername(username);
      if (existingUser != null) {
        throw UsernameAlreadyExistsException(
          "Account already exists with this username",
        );
      }

      final salt = BCrypt.gensalt();
      final hashedPassword = BCrypt.hashpw(password, salt);

      final insertedId = await userDao.insertUser(
        UsersCompanion(
          username: Value(username),
          password: Value(hashedPassword),
          role: Value(role),
          salt: Value(salt),
          status: const Value(1),
          email: Value(email),
          phone: Value(phone),
          name: Value(name),
        ),
      );

      final user = await userDao.getUserById(insertedId);
      if (user == null) {
        throw AuthDatabaseException("Failed to retrieve created user account.");
      }
      return AppUserModel.fromJson(user.toJson());
    } on UsernameAlreadyExistsException {
      rethrow;
    } on SqliteException catch (e) {
      throw AuthDatabaseException(
        "Database error during user creation: ${e.message}",
      );
    } catch (e) {
      throw AuthDatabaseException(
        "An unexpected error occurred during user creation: $e",
      );
    }
  }

  @override
  Future<AppUserModel> loginWithUsernamePassword({
    required String username,
    required String password,
  }) async {
    try {
      final userDao = database.userDao;
      final existingUser = await userDao.getUserByUsername(username);
      if (existingUser == null) {
        throw UserNotFoundException("Invalid username");
      }

      if (existingUser.status != 1) {
        throw UserNotFoundException("Account is inactive or suspended");
      }

      final user = await userDao.loginWithUsernameAndPassword(
        username,
        BCrypt.hashpw(password, existingUser.salt),
      );

      if (user == null) {
        throw UserNotFoundException("Password is incorrect");
      } else {
        print(user.toString());
      }

      // Store encrypted user ID in Hive
      await secureStorageBox.put(
        _sessionUserIdKey,
        _encryptData(user.id.toString()),
      );

      return AppUserModel.fromJson(user.toJson());
    } on AuthException {
      rethrow;
    } on SqliteException catch (e) {
      throw AuthDatabaseException("Database error during login: ${e.message}");
    } catch (e) {
      throw AuthException("An unexpected error occurred during login: $e");
    }
  }

  @override
  Future<AppUserModel?> currentUser() async {
    try {
      final encryptedUserId = secureStorageBox.get(_sessionUserIdKey);
      if (encryptedUserId == null || encryptedUserId.isEmpty) {
        return null;
      }

      final userIdString = _decryptData(encryptedUserId);
      final userId = int.tryParse(userIdString);
      if (userId == null) {
        await logout();
        return null;
      }

      final user = await database.userDao.getUserById(userId);
      if (user == null) {
        await logout();
        return null;
      }

      return AppUserModel.fromJson(user.toJson());
    } catch (e) {
      print("Error fetching current user: $e");
      await logout();
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await secureStorageBox.delete(_sessionUserIdKey);
    } catch (e) {
      print("Error during logout (secure storage): $e");
      throw AuthException("An error occurred while logging out: $e");
    }
  }
}
