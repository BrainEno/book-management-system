import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/book/data/models/book_model.dart';
import 'package:bookstore_management_system/features/book/domain/entities/book.dart';
import 'package:bookstore_management_system/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddBookUsecase implements UseCase<Book, BookModel> {
  final BookRepository bookRepository;

  AddBookUsecase(this.bookRepository);

  @override
  Future<Either<Failure, Book>> call(BookModel book) async {
    return await bookRepository.addBook(book);
  }
}
