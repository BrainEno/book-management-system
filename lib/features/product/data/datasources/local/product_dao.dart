import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/database/sqlite_type_converters.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/user_dao.dart'
    show Users;
import 'package:drift/drift.dart';

part 'product_dao.g.dart';

class ProductWithUsers {
  const ProductWithUsers({
    required this.product,
    this.createdByUsername,
    this.updatedByUsername,
  });

  final Product product;
  final String? createdByUsername;
  final String? updatedByUsername;
}

class Products extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (price >= 0)',
    'CHECK (internal_pricing IS NULL OR internal_pricing >= 0)',
    'CHECK (purchase_price IS NULL OR purchase_price >= 0)',
    'CHECK (publication_year IS NULL OR publication_year BETWEEN 0 AND 9999)',
    'CHECK (retail_discount IS NULL OR retail_discount BETWEEN 0 AND 10000)',
    'CHECK (wholesale_discount IS NULL OR wholesale_discount BETWEEN 0 AND 10000)',
    'CHECK (wholesale_price IS NULL OR wholesale_price >= 0)',
    'CHECK (member_discount IS NULL OR member_discount BETWEEN 0 AND 10000)',
  ];

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get author => text().withLength(min: 1, max: 255)();
  TextColumn get isbn =>
      text().withLength(min: 1, max: 32).nullable().unique()();
  TextColumn get category => text().withLength(min: 1, max: 128).nullable()();
  IntColumn get price => integer().map(moneyAsCentsConverter)();
  TextColumn get publisher => text().withLength(min: 1, max: 255).nullable()();
  TextColumn get productId => text().withLength(min: 1, max: 64).unique()();
  IntColumn get internalPricing =>
      integer().map(nullableMoneyAsCentsConverter).nullable()();
  TextColumn get selfEncoding => text().withLength(min: 1, max: 64).unique()();
  IntColumn get purchasePrice =>
      integer().map(nullableMoneyAsCentsConverter).nullable()();
  IntColumn get publicationYear => integer().nullable()();
  IntColumn get retailDiscount =>
      integer().map(nullableDiscountAsBasisPointsConverter).nullable()();
  IntColumn get wholesaleDiscount =>
      integer().map(nullableDiscountAsBasisPointsConverter).nullable()();
  IntColumn get wholesalePrice =>
      integer().map(nullableMoneyAsCentsConverter).nullable()();
  IntColumn get memberDiscount =>
      integer().map(nullableDiscountAsBasisPointsConverter).nullable()();
  TextColumn get purchaseSaleMode =>
      text().withLength(min: 1, max: 32).nullable()();
  TextColumn get bookmark => text().withLength(min: 1, max: 64).nullable()();
  TextColumn get packaging => text().withLength(min: 1, max: 32).nullable()();
  TextColumn get properity => text().withLength(min: 1, max: 64).nullable()();
  TextColumn get statisticalClass =>
      text().withLength(min: 1, max: 64).nullable()();
  @ReferenceName('createdProducts')
  IntColumn get createdBy => integer().nullable().references(
    Users,
    #id,
    onDelete: KeyAction.setNull,
    onUpdate: KeyAction.cascade,
  )();
  @ReferenceName('updatedProducts')
  IntColumn get updatedBy => integer().nullable().references(
    Users,
    #id,
    onDelete: KeyAction.setNull,
    onUpdate: KeyAction.cascade,
  )();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// DAO for Products table
@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  Future<List<ProductWithUsers>> getAllProducts() async {
    final creators = alias(db.users, 'product_creators');
    final updaters = alias(db.users, 'product_updaters');
    final query = select(products).join([
      leftOuterJoin(creators, creators.id.equalsExp(products.createdBy)),
      leftOuterJoin(updaters, updaters.id.equalsExp(products.updatedBy)),
    ]);
    query.orderBy([OrderingTerm(expression: products.id)]);

    final rows = await query.get();
    return rows
        .map(
          (row) => ProductWithUsers(
            product: row.readTable(products),
            createdByUsername: row.readTableOrNull(creators)?.username,
            updatedByUsername: row.readTableOrNull(updaters)?.username,
          ),
        )
        .toList(growable: false);
  }

  // Insert a new product
  Future<int> insertProduct(ProductsCompanion product) =>
      into(products).insert(product);

  // Update an existing product
  Future<int> updateProduct(int id, ProductsCompanion product) =>
      (update(products)..where((t) => t.id.equals(id))).write(product);

  // Delete a product by ID
  Future<void> deleteProduct(int id) =>
      (delete(products)..where((t) => t.id.equals(id))).go();

  // Search a product by isbn
  Future<ProductWithUsers?> searchByISBN(String isbn) async {
    final creators = alias(db.users, 'product_creators');
    final updaters = alias(db.users, 'product_updaters');
    final query = select(products).join([
      leftOuterJoin(creators, creators.id.equalsExp(products.createdBy)),
      leftOuterJoin(updaters, updaters.id.equalsExp(products.updatedBy)),
    ])..where(products.isbn.equals(isbn));

    final row = await query.getSingleOrNull();
    if (row == null) {
      return null;
    }

    return ProductWithUsers(
      product: row.readTable(products),
      createdByUsername: row.readTableOrNull(creators)?.username,
      updatedByUsername: row.readTableOrNull(updaters)?.username,
    );
  }

  // Search a product by title
  Future<ProductWithUsers?> searchByTitle(String title) async {
    final creators = alias(db.users, 'product_creators');
    final updaters = alias(db.users, 'product_updaters');
    final query = select(products).join([
      leftOuterJoin(creators, creators.id.equalsExp(products.createdBy)),
      leftOuterJoin(updaters, updaters.id.equalsExp(products.updatedBy)),
    ])..where(products.title.equals(title));

    final row = await query.getSingleOrNull();
    if (row == null) {
      return null;
    }

    return ProductWithUsers(
      product: row.readTable(products),
      createdByUsername: row.readTableOrNull(creators)?.username,
      updatedByUsername: row.readTableOrNull(updaters)?.username,
    );
  }
}
