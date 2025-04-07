// Add usecase.dart for base usecase contract
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
