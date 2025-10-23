import 'package:bookstore_management_system/core/database/database.dart';
import 'package:drift/drift.dart';

part 'product_dao.g.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get isbn => text()();
  TextColumn get category => text()();
  RealColumn get price => real()();
  TextColumn get publisher => text()();
  TextColumn get productId => text()();
  RealColumn get internalPricing => real()();
  TextColumn get selfEncoding => text()();
  RealColumn get purchasePrice => real()();
  IntColumn get publicationYear => integer()();
  RealColumn get retailDiscount => real()();
  RealColumn get wholesaleDiscount => real()();
  RealColumn get wholesalePrice => real()();
  RealColumn get memberDiscount => real()();
  TextColumn get purchaseSaleMode => text()();
  TextColumn get bookmark => text()();
  TextColumn get packaging => text()();
  TextColumn get properity => text()();
  TextColumn get statisticalClass => text()();
  TextColumn get operator => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// DAO for Products table
@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  // Get all products
  Future<List<Product>> getAllProducts() => select(products).get();

  // Insert a new product
  Future<int> insertProduct(ProductsCompanion product) =>
      into(products).insert(product);

  // Update an existing product
  Future<void> updateProduct(Product product) =>
      update(products).replace(product);

  // Delete a product by ID
  Future<void> deleteProduct(int id) =>
      (delete(products)..where((t) => t.id.equals(id))).go();

  // Search a product by isbn
  Future<Product> searchByISBN(String isbn) {
    return (select(products)..where((b) => b.isbn.equals(isbn))).getSingle();
  }

  // Search a product by title
  Future<Product> searchByTitle(String title) {
    return (select(products)..where((b) => b.title.equals(title))).getSingle();
  }
}
