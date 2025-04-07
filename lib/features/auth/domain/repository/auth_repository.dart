import 'package:bookstore_management_system/core/common/entities/app_user.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AppUser>> createAccount({
    required String username,
    required String password,
    required String role,
    String? phone,
    String? email,
    String? name,
  });

  Future<Either<Failure, AppUser>> loginWithUsernamePassword({
    required String username,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, AppUser>> currentUser();
}
