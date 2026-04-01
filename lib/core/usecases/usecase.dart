// Add usecase.dart for base usecase contract
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
