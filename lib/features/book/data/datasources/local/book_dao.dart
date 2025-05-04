import 'package:bookstore_management_system/core/database/database.dart';
import 'package:drift/drift.dart';

part 'book_dao.g.dart';

class Books extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get isbn => text()();
  TextColumn get category => text()();
  RealColumn get price => real()();
  TextColumn get publisher => text()();
  TextColumn get bookId => text()();
  TextColumn get internalPricing => text()();
  TextColumn get selfEncoding => text()();
  RealColumn get purchasePrice => real()();
  IntColumn get publicationYear => integer()();
  IntColumn get retailDiscount => integer()();
  IntColumn get wholesaleDiscount => integer()();
  IntColumn get wholesalePrice => integer()();
  IntColumn get memberDiscount => integer()();
  TextColumn get purchaseSaleMode => text()();
  TextColumn get bookmark => text()();
  TextColumn get packaging => text()();
  TextColumn get properity => text()();
  TextColumn get statisticalClass => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// DAO for Books table
@DriftAccessor(tables: [Books])
class BookDao extends DatabaseAccessor<AppDatabase> with _$BookDaoMixin {
  BookDao(super.db);

  // Get all books
  Future<List<Book>> getAllBooks() => select(books).get();

  // Insert a new book
  Future<int> insertBook(BooksCompanion book) => into(books).insert(book);

  // Update an existing book
  Future<void> updateBook(Book book) => update(books).replace(book);

  // Delete a book by ID
  Future<void> deleteBook(int id) =>
      (delete(books)..where((t) => t.id.equals(id))).go();
}
