import 'package:bookstore_management_system/core/common/entities/app_user.dart';
import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/auth/core/error/auth_exceptions.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/auth_local_data_source.dart';

import 'package:bookstore_management_system/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  const AuthRepositoryImpl(this.authLocalDataSource);

  @override
  Future<Either<Failure, AppUser>> currentUser() async {
    try {
      final user = await authLocalDataSource.currentUser();
      if (user == null) {
        return Left(CacheFailure(message: 'No current Account'));
      }
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppUser>> loginWithUsernamePassword({
    required String username,
    required String password,
  }) async {
    try {
      final user = await authLocalDataSource.loginWithUsernamePassword(
        username: username,
        password: password,
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authLocalDataSource.logout();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppUser>> createAccount({
    required String username,
    required String password,
    required String role,
    String? phone,
    String? email,
    String? name,
  }) async {
    try {
      final account = await authLocalDataSource.createUser(
        username: username,
        password: password,
        role: role,
        phone: phone ?? '',
        name: name ?? '',
        email: email ?? '',
      );
      return Right(account);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
