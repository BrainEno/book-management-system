import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase implements UseCase<AppUser, LoginUsecaseParams> {
  final AuthRepository _authRepository;
  const LoginUsecase(this._authRepository);
  @override
  Future<Either<Failure, AppUser>> call(LoginUsecaseParams params) {
    return _authRepository.loginWithUsernamePassword(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginUsecaseParams {
  final String username;
  final String password;

  LoginUsecaseParams({required this.username, required this.password});
}
