import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/database/sqlite_type_converters.dart';
import 'package:drift/drift.dart';

part 'product_dao.g.dart';

class Products extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (price >= 0)',
    'CHECK (internal_pricing >= 0)',
    'CHECK (purchase_price >= 0)',
    'CHECK (publication_year BETWEEN 0 AND 9999)',
    'CHECK (retail_discount BETWEEN 0 AND 10000)',
    'CHECK (wholesale_discount BETWEEN 0 AND 10000)',
    'CHECK (wholesale_price >= 0)',
    'CHECK (member_discount BETWEEN 0 AND 10000)',
  ];

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get author => text().withLength(min: 1, max: 255)();
  TextColumn get isbn => text().withLength(min: 1, max: 32)();
  TextColumn get category => text().withLength(min: 1, max: 128)();
  GeneratedColumnWithTypeConverter<double, int> get price =>
      integer().map(moneyAsCentsConverter)()
          as GeneratedColumnWithTypeConverter<double, int>;
  TextColumn get publisher => text().withLength(min: 1, max: 255)();
  TextColumn get productId => text().withLength(min: 1, max: 64).unique()();
  GeneratedColumnWithTypeConverter<double, int> get internalPricing =>
      integer().map(moneyAsCentsConverter)()
          as GeneratedColumnWithTypeConverter<double, int>;
  TextColumn get selfEncoding => text().withLength(min: 1, max: 64).unique()();
  GeneratedColumnWithTypeConverter<double, int> get purchasePrice =>
      integer().map(moneyAsCentsConverter)()
          as GeneratedColumnWithTypeConverter<double, int>;
  IntColumn get publicationYear => integer()();
  GeneratedColumnWithTypeConverter<double, int> get retailDiscount =>
      integer()
              .withDefault(const Constant(10000))
              .map(discountAsBasisPointsConverter)()
          as GeneratedColumnWithTypeConverter<double, int>;
  GeneratedColumnWithTypeConverter<double, int> get wholesaleDiscount =>
      integer()
              .withDefault(const Constant(10000))
              .map(discountAsBasisPointsConverter)()
          as GeneratedColumnWithTypeConverter<double, int>;
  GeneratedColumnWithTypeConverter<double, int> get wholesalePrice =>
      integer().map(moneyAsCentsConverter)()
          as GeneratedColumnWithTypeConverter<double, int>;
  GeneratedColumnWithTypeConverter<double, int> get memberDiscount =>
      integer()
              .withDefault(const Constant(10000))
              .map(discountAsBasisPointsConverter)()
          as GeneratedColumnWithTypeConverter<double, int>;
  TextColumn get purchaseSaleMode => text().withLength(min: 1, max: 32)();
  TextColumn get bookmark => text().withLength(min: 1, max: 64)();
  TextColumn get packaging => text().withLength(min: 1, max: 32)();
  TextColumn get properity => text().withLength(min: 1, max: 64)();
  TextColumn get statisticalClass => text().withLength(min: 1, max: 64)();
  TextColumn get operator => text().withLength(min: 1, max: 64)();
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
