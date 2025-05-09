import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/book/data/datasources/local/book_local_datasource.dart';
import 'package:bookstore_management_system/features/book/data/models/book_model.dart';
import 'package:drift/drift.dart';

class BookLocalDataSourceImpl implements BookLocalDataSource {
  final AppDatabase database;

  BookLocalDataSourceImpl(this.database);

  @override
  Future<BookModel> addBook(BookModel bookModel) async {
    final bookDao = database.bookDao;
    final BooksCompanion newBook = BooksCompanion(
      id: Value(bookModel.id),
      title: Value(bookModel.title),
      author: Value(bookModel.author),
      isbn: Value(bookModel.isbn),
      category: Value(bookModel.category),
      price: Value(bookModel.price),
      publisher: Value(bookModel.publisher),
      bookId: Value(bookModel.bookId),
      internalPricing: Value(bookModel.internalPricing),
      selfEncoding: Value(bookModel.selfEncoding),
      purchasePrice: Value(bookModel.purchasePrice),
      publicationYear: Value(bookModel.publicationYear),
      retailDiscount: Value(bookModel.retailDiscount),
      wholesaleDiscount: Value(bookModel.wholesaleDiscount),
      wholesalePrice: Value(bookModel.wholesalePrice),
      memberDiscount: Value(bookModel.memberDiscount),
      purchaseSaleMode: Value(bookModel.purchaseSaleMode),
      bookmark: Value(bookModel.bookmark),
      packaging: Value(bookModel.packaging),
      properity: Value(bookModel.properity),
      statisticalClass: Value(bookModel.statisticalClass),
      operator: Value(bookModel.operator),
      createdAt: Value(bookModel.createdAt ?? DateTime.now()),
      updatedAt: Value(bookModel.updatedAt ?? DateTime.now()),
    );
    await bookDao.insertBook(newBook);
    return bookModel;
  }

  @override
  Future<List<BookModel>> getAllBooks() async {
    final bookDao = database.bookDao;
    final books = await bookDao.getAllBooks();
    return books.map((book) => BookModel.fromJson(book.toJson())).toList();
  }

  @override
  Future<void> updateBook(BookModel bookModel) async {
    final bookDao = database.bookDao;
    final book = Book(
      id: bookModel.id,
      title: bookModel.title,
      author: bookModel.author,
      isbn: bookModel.isbn,
      category: bookModel.category,
      price: bookModel.price,
      publisher: bookModel.publisher,
      bookId: bookModel.bookId,
      internalPricing: bookModel.internalPricing,
      selfEncoding: bookModel.selfEncoding,
      purchasePrice: bookModel.purchasePrice,
      publicationYear: bookModel.publicationYear,
      retailDiscount: bookModel.retailDiscount,
      wholesaleDiscount: bookModel.wholesaleDiscount,
      wholesalePrice: bookModel.wholesalePrice,
      memberDiscount: bookModel.memberDiscount,
      purchaseSaleMode: bookModel.purchaseSaleMode,
      bookmark: bookModel.bookmark,
      packaging: bookModel.packaging,
      properity: bookModel.properity,
      statisticalClass: bookModel.statisticalClass,
      operator: bookModel.operator,
      createdAt: bookModel.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await bookDao.updateBook(book);
  }

  @override
  Future<void> deleteBook(int id) async {
    final bookDao = database.bookDao;
    await bookDao.deleteBook(id);
  }

  @override
  Future<BookModel> searchBookByISBN(String isbn) async {
    final bookDao = database.bookDao;
    final book = await bookDao.searchBookByISBN(isbn);
    return BookModel.fromJson(book.toJson());
  }

  @override
  Future<BookModel> searchBookByTitle(String title) async {
    final bookDao = database.bookDao;
    final book = await bookDao.searchBookByTitle(title);
    return BookModel.fromJson(book.toJson());
  }
}
