import 'package:bookstore_management_system/features/book/data/models/book_model.dart';

abstract interface class BookLocalDataSource {
  Future<BookModel> addBook(BookModel book);
  Future<void> deleteBook(int id);
  Future<BookModel> searchBookByISBN(String isbn);
  Future<BookModel> searchBookByTitle(String title);
  Future<void> updateBook(BookModel bookModel);
  Future<List<BookModel>> getAllBooks();
}
