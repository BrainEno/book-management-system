import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/book/domain/entities/book.dart';
import 'package:bookstore_management_system/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchBookUsecase implements UseCase<Book, String> {
  final BookRepository bookRepository;

  SearchBookUsecase(this.bookRepository);

  @override
  Future<Either<Failure, Book>> call(String isbn) async {
    return await bookRepository.searchBookByISBN(isbn);
  }
}
