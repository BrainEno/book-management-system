import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/book/data/models/book_model.dart';
import 'package:bookstore_management_system/features/book/domain/entities/book.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BookRepository {
  Future<Either<Failure, Book>> addBook(BookModel book);
  Future<Either<Failure, List<Book>>> getAllBooks();
  Future<Either<Failure, void>> updateBook(BookModel bookModel);
  Future<Either<Failure, void>> deleteBook(int id);
  Future<Either<Failure, Book>> searchBookByISBN(String isbn);
  Future<Either<Failure, Book>> searchBookByTitle(String title);
}
