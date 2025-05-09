import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/book/data/models/book_model.dart';
import 'package:bookstore_management_system/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateBookUsecase implements UseCase<void, BookModel> {
  final BookRepository bookRepository;

  UpdateBookUsecase(this.bookRepository);

  @override
  Future<Either<Failure, void>> call(BookModel book) async {
    return await bookRepository.updateBook(book);
  }
}
