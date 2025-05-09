import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/features/book/data/datasources/local/book_local_datasource.dart';
import 'package:bookstore_management_system/features/book/data/models/book_model.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/book/domain/entities/book.dart';
import 'package:bookstore_management_system/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class BookRepositoryImpl implements BookRepository {
  final BookLocalDataSource bookLocalDataSource;

  const BookRepositoryImpl(this.bookLocalDataSource);

  @override
  Future<Either<Failure, Book>> addBook(BookModel bookModel) async {
    try {
      final book = await bookLocalDataSource.addBook(bookModel);
      return Right(book);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getAllBooks() async {
    try {
      final books = await bookLocalDataSource.getAllBooks();
      return Right(books);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateBook(BookModel bookModel) async {
    try {
      await bookLocalDataSource.updateBook(bookModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBook(int id) async {
    try {
      await bookLocalDataSource.deleteBook(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Book>> searchBookByISBN(String isbn) async {
    try {
      final book = await bookLocalDataSource.searchBookByISBN(isbn);
      return Right(book);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Book>> searchBookByTitle(String title) async {
    try {
      final book = await bookLocalDataSource.searchBookByTitle(title);
      return Right(book);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
