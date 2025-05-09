import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteBookUsecase implements UseCase<void, int> {
  final BookRepository bookRepository;

  DeleteBookUsecase(this.bookRepository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await bookRepository.deleteBook(id);
  }
}
