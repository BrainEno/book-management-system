// ignore_for_file: avoid_print
import 'dart:io';

import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/core/database/bookstore_codes.dart';
import 'package:bookstore_management_system/core/database/bookstore_tables.dart';
import 'package:bookstore_management_system/core/database/sqlite_type_converters.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/user_dao.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

// Define the database with tables and DAOs
@DriftDatabase(
  tables: [
    Products,
    Users,
    ProductCategories,
    Publishers,
    PurchaseSaleModes,
    Suppliers,
    Customers,
    Warehouses,
    StockBalances,
    StockMovements,
    PurchaseOrders,
    PurchaseOrderItems,
    SalesOrders,
    SalesOrderItems,
  ],
  daos: [ProductDao, UserDao],
)
class AppDatabase extends _$AppDatabase {
  // ignore: use_super_parameters
  AppDatabase._internal(QueryExecutor e) : super(e);

  static AppDatabase? _instance;

  factory AppDatabase([QueryExecutor? executor]) {
    if (executor != null) {
      return AppDatabase._internal(executor);
    }
    _instance ??= AppDatabase._internal(_openConnection());

    return _instance!;
  }

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 4) {
        await _migrateUsersTableToV4(m);
      }

      if (from < 3) {
        await _migrateLegacyBooksTableToV5(m);
      } else if (from < 5) {
        await _migrateProductsTableToV5(m);
      }

      if (from < 6) {
        await _migrateSupportTablesToV6(m);
      }

      if (from < 7) {
        await _migrateInventoryFoundationToV7(m);
      }

      await _ensureRequiredTables(m);
    },
    beforeOpen: (details) async {
      await _ensureRequiredTables(migrator);
      await _seedPurchaseSaleModes();
      await _backfillProductReferenceIds();
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Migrator get migrator => Migrator(this);

  Future<bool> _tableExists(String tableName) async {
    final result = await customSelect(
      '''
      SELECT name
      FROM sqlite_master
      WHERE type = 'table' AND name = ?
      ''',
      variables: [Variable.withString(tableName)],
    ).get();
    return result.isNotEmpty;
  }

  Future<bool> _columnExists(String tableName, String columnName) async {
    final result = await customSelect('PRAGMA table_info($tableName)').get();
    return result.any((row) => row.read<String>('name') == columnName);
  }

  Future<String?> _columnDeclaredType(
    String tableName,
    String columnName,
  ) async {
    final result = await customSelect('PRAGMA table_info($tableName)').get();
    for (final row in result) {
      if (row.read<String>('name') == columnName) {
        return row.data['type']?.toString().toUpperCase();
      }
    }
    return null;
  }

  bool _isIntegerColumnType(String? declaredType) {
    if (declaredType == null) {
      return false;
    }
    return declaredType.contains('INT');
  }

  Future<void> _addColumnIfMissing(
    String tableName,
    String columnName,
    String sqlDefinition,
  ) async {
    if (await _columnExists(tableName, columnName)) {
      return;
    }
    await customStatement(
      'ALTER TABLE $tableName ADD COLUMN $columnName $sqlDefinition',
    );
  }

  String _normalizeRequiredTextSql(String columnName) {
    return "TRIM(COALESCE($columnName, ''))";
  }

  String _normalizeOptionalTextSql(
    String columnName, {
    bool treatUnspecifiedAsNull = true,
  }) {
    final trimmed = "NULLIF(TRIM(COALESCE($columnName, '')), '')";
    if (!treatUnspecifiedAsNull) {
      return trimmed;
    }
    return "CASE WHEN $trimmed = '不区分' THEN NULL ELSE $trimmed END";
  }

  String _scaledNumberSql(String columnName, {required bool alreadyInteger}) {
    if (alreadyInteger) {
      return 'CAST($columnName AS INTEGER)';
    }
    return 'CAST(ROUND(CAST($columnName AS REAL) * 100.0) AS INTEGER)';
  }

  String _userLookupSql(String usernameExpression) {
    return '''
CASE
  WHEN $usernameExpression IS NULL THEN NULL
  ELSE (
    SELECT id
    FROM users
    WHERE username = $usernameExpression
    LIMIT 1
  )
END
''';
  }

  Future<void> _ensureRequiredTables(Migrator m) async {
    await _createTableIfMissing(m, users);
    await _createTableIfMissing(m, productCategories);
    await _createTableIfMissing(m, publishers);
    await _createTableIfMissing(m, purchaseSaleModes);
    await _createTableIfMissing(m, suppliers);
    await _createTableIfMissing(m, customers);
    await _createTableIfMissing(m, warehouses);
    await _createTableIfMissing(m, products);
    await _createTableIfMissing(m, stockBalances);
    await _createTableIfMissing(m, stockMovements);
    await _createTableIfMissing(m, purchaseOrders);
    await _createTableIfMissing(m, purchaseOrderItems);
    await _createTableIfMissing(m, salesOrders);
    await _createTableIfMissing(m, salesOrderItems);
  }

  Future<void> _createTableIfMissing(Migrator m, TableInfo table) async {
    if (!await _tableExists(table.actualTableName)) {
      await m.createTable(table);
    }
  }

  Future<void> _migrateLegacyBooksTableToV5(Migrator m) async {
    if (await _tableExists(products.actualTableName)) {
      return;
    }

    final hasLegacyBooksTable = await _tableExists('books');
    if (!hasLegacyBooksTable) {
      await m.createTable(products);
      return;
    }

    final hasOperatorColumn = await _columnExists('books', 'operator');
    final operatorSelect = hasOperatorColumn
        ? _normalizeOptionalTextSql('operator', treatUnspecifiedAsNull: false)
        : 'NULL';

    await m.createTable(products);
    await customStatement('''
      WITH normalized AS (
        SELECT
          id,
          ${_normalizeRequiredTextSql('title')} AS normalized_title,
          ${_normalizeRequiredTextSql('author')} AS normalized_author,
          ${_normalizeOptionalTextSql('isbn', treatUnspecifiedAsNull: false)} AS normalized_isbn,
          ROW_NUMBER() OVER (
            PARTITION BY ${_normalizeOptionalTextSql('isbn', treatUnspecifiedAsNull: false)}
            ORDER BY id
          ) AS isbn_rank,
          ${_normalizeOptionalTextSql('category')} AS normalized_category,
          CAST(ROUND(CAST(price AS REAL) * 100.0) AS INTEGER) AS normalized_price,
          ${_normalizeOptionalTextSql('publisher')} AS normalized_publisher,
          ${_normalizeRequiredTextSql('book_id')} AS normalized_product_id,
          ${_normalizeOptionalTextSql('self_encoding', treatUnspecifiedAsNull: false)} AS normalized_self_encoding,
          CAST(ROUND(CAST(internal_pricing AS REAL) * 100.0) AS INTEGER) AS normalized_internal_pricing,
          CAST(ROUND(CAST(purchase_price AS REAL) * 100.0) AS INTEGER) AS normalized_purchase_price,
          CASE
            WHEN CAST(publication_year AS INTEGER) <= 0 THEN NULL
            ELSE CAST(publication_year AS INTEGER)
          END AS normalized_publication_year,
          CAST(ROUND(CAST(retail_discount AS REAL) * 100.0) AS INTEGER) AS normalized_retail_discount,
          CAST(ROUND(CAST(wholesale_discount AS REAL) * 100.0) AS INTEGER) AS normalized_wholesale_discount,
          CAST(ROUND(CAST(wholesale_price AS REAL) * 100.0) AS INTEGER) AS normalized_wholesale_price,
          CAST(ROUND(CAST(member_discount AS REAL) * 100.0) AS INTEGER) AS normalized_member_discount,
          ${_normalizeOptionalTextSql('purchase_sale_mode')} AS normalized_purchase_sale_mode,
          ${_normalizeOptionalTextSql('bookmark')} AS normalized_bookmark,
          ${_normalizeOptionalTextSql('packaging')} AS normalized_packaging,
          ${_normalizeOptionalTextSql('properity')} AS normalized_properity,
          ${_normalizeOptionalTextSql('statistical_class')} AS normalized_statistical_class,
          $operatorSelect AS operator_username,
          created_at,
          updated_at
        FROM books
      )
      INSERT INTO products (
        id,
        title,
        author,
        isbn,
        category,
        price,
        publisher,
        product_id,
        internal_pricing,
        self_encoding,
        purchase_price,
        publication_year,
        retail_discount,
        wholesale_discount,
        wholesale_price,
        member_discount,
        purchase_sale_mode,
        bookmark,
        packaging,
        properity,
        statistical_class,
        created_by,
        updated_by,
        created_at,
        updated_at
      )
      SELECT
        id,
        normalized_title,
        normalized_author,
        CASE
          WHEN normalized_isbn IS NULL THEN NULL
          WHEN isbn_rank = 1 THEN normalized_isbn
          ELSE NULL
        END,
        normalized_category,
        normalized_price,
        normalized_publisher,
        normalized_product_id,
        normalized_internal_pricing,
        COALESCE(
          normalized_self_encoding,
          CASE
            WHEN normalized_isbn IS NOT NULL THEN normalized_isbn
            ELSE normalized_product_id
          END
        ),
        normalized_purchase_price,
        normalized_publication_year,
        normalized_retail_discount,
        normalized_wholesale_discount,
        normalized_wholesale_price,
        normalized_member_discount,
        normalized_purchase_sale_mode,
        normalized_bookmark,
        normalized_packaging,
        normalized_properity,
        normalized_statistical_class,
        ${_userLookupSql('operator_username')},
        ${_userLookupSql('operator_username')},
        created_at,
        updated_at
      FROM normalized
    ''');
    await customStatement('DROP TABLE books');
  }

  Future<void> _migrateProductsTableToV5(Migrator m) async {
    if (!await _tableExists(products.actualTableName)) {
      await m.createTable(products);
      return;
    }

    final hasCreatedByColumn = await _columnExists('products', 'created_by');
    final hasUpdatedByColumn = await _columnExists('products', 'updated_by');
    final hasOperatorColumn = await _columnExists('products', 'operator');

    if (hasCreatedByColumn && hasUpdatedByColumn && !hasOperatorColumn) {
      return;
    }

    final priceIsInteger = _isIntegerColumnType(
      await _columnDeclaredType('products', 'price'),
    );
    final internalPricingIsInteger = _isIntegerColumnType(
      await _columnDeclaredType('products', 'internal_pricing'),
    );
    final purchasePriceIsInteger = _isIntegerColumnType(
      await _columnDeclaredType('products', 'purchase_price'),
    );
    final retailDiscountIsInteger = _isIntegerColumnType(
      await _columnDeclaredType('products', 'retail_discount'),
    );
    final wholesaleDiscountIsInteger = _isIntegerColumnType(
      await _columnDeclaredType('products', 'wholesale_discount'),
    );
    final wholesalePriceIsInteger = _isIntegerColumnType(
      await _columnDeclaredType('products', 'wholesale_price'),
    );
    final memberDiscountIsInteger = _isIntegerColumnType(
      await _columnDeclaredType('products', 'member_discount'),
    );

    await customStatement(
      'ALTER TABLE products RENAME TO products_pre_v5_backup',
    );
    await m.createTable(products);
    await customStatement('''
      WITH normalized AS (
        SELECT
          id,
          ${_normalizeRequiredTextSql('title')} AS normalized_title,
          ${_normalizeRequiredTextSql('author')} AS normalized_author,
          ${_normalizeOptionalTextSql('isbn', treatUnspecifiedAsNull: false)} AS normalized_isbn,
          ROW_NUMBER() OVER (
            PARTITION BY ${_normalizeOptionalTextSql('isbn', treatUnspecifiedAsNull: false)}
            ORDER BY id
          ) AS isbn_rank,
          ${_normalizeOptionalTextSql('category')} AS normalized_category,
          ${_scaledNumberSql('price', alreadyInteger: priceIsInteger)} AS normalized_price,
          ${_normalizeOptionalTextSql('publisher')} AS normalized_publisher,
          ${_normalizeRequiredTextSql('product_id')} AS normalized_product_id,
          ${_normalizeOptionalTextSql('self_encoding', treatUnspecifiedAsNull: false)} AS normalized_self_encoding,
          ${_scaledNumberSql('internal_pricing', alreadyInteger: internalPricingIsInteger)} AS normalized_internal_pricing,
          ${_scaledNumberSql('purchase_price', alreadyInteger: purchasePriceIsInteger)} AS normalized_purchase_price,
          CASE
            WHEN CAST(publication_year AS INTEGER) <= 0 THEN NULL
            ELSE CAST(publication_year AS INTEGER)
          END AS normalized_publication_year,
          ${_scaledNumberSql('retail_discount', alreadyInteger: retailDiscountIsInteger)} AS normalized_retail_discount,
          ${_scaledNumberSql('wholesale_discount', alreadyInteger: wholesaleDiscountIsInteger)} AS normalized_wholesale_discount,
          ${_scaledNumberSql('wholesale_price', alreadyInteger: wholesalePriceIsInteger)} AS normalized_wholesale_price,
          ${_scaledNumberSql('member_discount', alreadyInteger: memberDiscountIsInteger)} AS normalized_member_discount,
          ${_normalizeOptionalTextSql('purchase_sale_mode')} AS normalized_purchase_sale_mode,
          ${_normalizeOptionalTextSql('bookmark')} AS normalized_bookmark,
          ${_normalizeOptionalTextSql('packaging')} AS normalized_packaging,
          ${_normalizeOptionalTextSql('properity')} AS normalized_properity,
          ${_normalizeOptionalTextSql('statistical_class')} AS normalized_statistical_class,
          ${hasOperatorColumn ? _normalizeOptionalTextSql('operator', treatUnspecifiedAsNull: false) : 'NULL'} AS operator_username,
          created_at,
          updated_at
        FROM products_pre_v5_backup
      )
      INSERT INTO products (
        id,
        title,
        author,
        isbn,
        category,
        price,
        publisher,
        product_id,
        internal_pricing,
        self_encoding,
        purchase_price,
        publication_year,
        retail_discount,
        wholesale_discount,
        wholesale_price,
        member_discount,
        purchase_sale_mode,
        bookmark,
        packaging,
        properity,
        statistical_class,
        created_by,
        updated_by,
        created_at,
        updated_at
      )
      SELECT
        id,
        normalized_title,
        normalized_author,
        CASE
          WHEN normalized_isbn IS NULL THEN NULL
          WHEN isbn_rank = 1 THEN normalized_isbn
          ELSE NULL
        END,
        normalized_category,
        normalized_price,
        normalized_publisher,
        normalized_product_id,
        normalized_internal_pricing,
        COALESCE(
          normalized_self_encoding,
          CASE
            WHEN normalized_isbn IS NOT NULL THEN normalized_isbn
            ELSE normalized_product_id
          END
        ),
        normalized_purchase_price,
        normalized_publication_year,
        normalized_retail_discount,
        normalized_wholesale_discount,
        normalized_wholesale_price,
        normalized_member_discount,
        normalized_purchase_sale_mode,
        normalized_bookmark,
        normalized_packaging,
        normalized_properity,
        normalized_statistical_class,
        ${_userLookupSql('operator_username')},
        ${_userLookupSql('operator_username')},
        created_at,
        updated_at
      FROM normalized
    ''');
    await customStatement('DROP TABLE products_pre_v5_backup');
  }

  Future<void> _migrateSupportTablesToV6(Migrator m) async {
    await _ensureRequiredTables(m);
  }

  Future<void> _migrateInventoryFoundationToV7(Migrator m) async {
    await _createTableIfMissing(m, purchaseSaleModes);

    if (await _tableExists(stockMovements.actualTableName)) {
      await _recreateStockMovementsForV7(m);
    } else {
      await _createTableIfMissing(m, stockMovements);
    }

    if (await _tableExists(products.actualTableName)) {
      await _addColumnIfMissing(
        products.actualTableName,
        'category_id',
        'INTEGER NULL REFERENCES product_categories(id) ON DELETE SET NULL ON UPDATE CASCADE',
      );
      await _addColumnIfMissing(
        products.actualTableName,
        'publisher_id',
        'INTEGER NULL REFERENCES publishers(id) ON DELETE SET NULL ON UPDATE CASCADE',
      );
      await _addColumnIfMissing(
        products.actualTableName,
        'purchase_sale_mode_id',
        'INTEGER NULL REFERENCES purchase_sale_modes(id) ON DELETE SET NULL ON UPDATE CASCADE',
      );
      await _addColumnIfMissing(
        products.actualTableName,
        'status',
        'INTEGER NOT NULL DEFAULT 1 CHECK (status BETWEEN 0 AND 2)',
      );
      await _addColumnIfMissing(
        products.actualTableName,
        'stock_unit',
        "TEXT NOT NULL DEFAULT '册'",
      );
      await _addColumnIfMissing(
        products.actualTableName,
        'min_stock_alert_qty',
        'INTEGER NULL CHECK (min_stock_alert_qty >= 0)',
      );
      await _addColumnIfMissing(
        products.actualTableName,
        'max_stock_alert_qty',
        'INTEGER NULL CHECK (max_stock_alert_qty >= 0)',
      );
    }

    if (await _tableExists(purchaseOrders.actualTableName)) {
      await _addColumnIfMissing(
        purchaseOrders.actualTableName,
        'posted_by',
        'INTEGER NULL REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE',
      );
      await _addColumnIfMissing(
        purchaseOrders.actualTableName,
        'posted_at',
        'INTEGER NULL',
      );
    }

    if (await _tableExists(purchaseOrderItems.actualTableName)) {
      await _addColumnIfMissing(
        purchaseOrderItems.actualTableName,
        'shelf_code',
        'TEXT NULL',
      );
    }

    await _seedPurchaseSaleModes();
    await _backfillProductReferenceIds();
  }

  Future<void> _recreateStockMovementsForV7(Migrator m) async {
    await customStatement('''
      ALTER TABLE stock_movements
      RENAME TO stock_movements_v6_backup
    ''');
    await m.createTable(stockMovements);
    await customStatement('''
      INSERT INTO stock_movements (
        id,
        movement_no,
        movement_type,
        ref_type,
        ref_id,
        warehouse_id,
        product_id,
        qty_delta,
        unit_cost_cent,
        amount_cent,
        occurred_at,
        operator_user_id,
        note,
        created_at
      )
      SELECT
        id,
        movement_no,
        movement_type,
        ref_type,
        ref_id,
        warehouse_id,
        product_id,
        qty_delta,
        unit_cost_cent,
        amount_cent,
        occurred_at,
        operator_user_id,
        note,
        created_at
      FROM stock_movements_v6_backup
    ''');
    await customStatement('DROP TABLE stock_movements_v6_backup');
  }

  Future<void> _seedPurchaseSaleModes() async {
    if (!await _tableExists(purchaseSaleModes.actualTableName)) {
      return;
    }

    for (final seed in defaultPurchaseSaleModes) {
      final existing = await customSelect(
        '''
        SELECT id
        FROM purchase_sale_modes
        WHERE code = ?
        LIMIT 1
        ''',
        variables: [Variable.withString(seed.code)],
      ).getSingleOrNull();
      if (existing != null) {
        continue;
      }

      await into(purchaseSaleModes).insert(
        PurchaseSaleModesCompanion.insert(
          code: seed.code,
          name: seed.name,
          defaultDiscountBp: Value(seed.defaultDiscountBp),
          allowMemberDiscount: Value(seed.allowMemberDiscount),
          allowReturns: Value(seed.allowReturns),
          requiresApproval: Value(seed.requiresApproval),
          status: Value(seed.status),
        ),
      );
    }
  }

  Future<int?> _lookupReferenceIdByCodeOrName(
    String tableName,
    String value,
  ) async {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return null;
    }

    final row = await customSelect(
      '''
      SELECT id
      FROM $tableName
      WHERE code = ?
         OR name = ?
      ORDER BY CASE WHEN code = ? THEN 0 ELSE 1 END
      LIMIT 1
      ''',
      variables: [
        Variable.withString(normalized),
        Variable.withString(normalized),
        Variable.withString(normalized),
      ],
    ).getSingleOrNull();

    return row?.read<int>('id');
  }

  Future<void> _backfillProductReferenceIds() async {
    if (!await _tableExists(products.actualTableName)) {
      return;
    }

    final hasCategoryId = await _columnExists(
      products.actualTableName,
      'category_id',
    );
    final hasPublisherId = await _columnExists(
      products.actualTableName,
      'publisher_id',
    );
    final hasPurchaseSaleModeId = await _columnExists(
      products.actualTableName,
      'purchase_sale_mode_id',
    );
    final hasStatus = await _columnExists(products.actualTableName, 'status');
    final hasStockUnit = await _columnExists(
      products.actualTableName,
      'stock_unit',
    );

    final rows = await customSelect('''
      SELECT
        id,
        category,
        category_id,
        publisher,
        publisher_id,
        purchase_sale_mode,
        purchase_sale_mode_id,
        status,
        stock_unit
      FROM products
      ''').get();

    for (final row in rows) {
      final productIdValue = row.read<int>('id');
      final categoryValue = row.data['category']?.toString();
      final publisherValue = row.data['publisher']?.toString();
      final purchaseSaleModeValue = row.data['purchase_sale_mode']?.toString();
      final stockUnitValue = row.data['stock_unit']?.toString();
      final currentCategoryId = row.data['category_id'] as int?;
      final currentPublisherId = row.data['publisher_id'] as int?;
      final currentPurchaseSaleModeId =
          row.data['purchase_sale_mode_id'] as int?;
      final currentStatus = row.data['status'] as int?;

      final resolvedCategoryId =
          hasCategoryId &&
              currentCategoryId == null &&
              categoryValue != null &&
              categoryValue.trim().isNotEmpty
          ? await _lookupReferenceIdByCodeOrName(
              'product_categories',
              categoryValue,
            )
          : null;
      final resolvedPublisherId =
          hasPublisherId &&
              currentPublisherId == null &&
              publisherValue != null &&
              publisherValue.trim().isNotEmpty
          ? await _lookupReferenceIdByCodeOrName('publishers', publisherValue)
          : null;
      final resolvedPurchaseSaleModeId =
          hasPurchaseSaleModeId &&
              currentPurchaseSaleModeId == null &&
              purchaseSaleModeValue != null &&
              purchaseSaleModeValue.trim().isNotEmpty
          ? await _lookupReferenceIdByCodeOrName(
              'purchase_sale_modes',
              purchaseSaleModeValue,
            )
          : null;

      final companion = ProductsCompanion(
        categoryId: resolvedCategoryId == null
            ? const Value.absent()
            : Value(resolvedCategoryId),
        publisherId: resolvedPublisherId == null
            ? const Value.absent()
            : Value(resolvedPublisherId),
        purchaseSaleModeId: resolvedPurchaseSaleModeId == null
            ? const Value.absent()
            : Value(resolvedPurchaseSaleModeId),
        status: hasStatus && currentStatus == null
            ? const Value(ProductStatuses.active)
            : const Value.absent(),
        stockUnit:
            hasStockUnit &&
                (stockUnitValue == null || stockUnitValue.trim().isEmpty)
            ? const Value('册')
            : const Value.absent(),
      );

      if (companion.toColumns(false).isEmpty) {
        continue;
      }

      await (update(
        products,
      )..where((tbl) => tbl.id.equals(productIdValue))).write(companion);
    }
  }

  Future<void> _migrateUsersTableToV4(Migrator m) async {
    if (!await _tableExists(users.actualTableName)) {
      await m.createTable(users);
      return;
    }

    await customStatement('ALTER TABLE users RENAME TO users_v3_backup');
    await m.createTable(users);
    await customStatement('''
      INSERT INTO users (
        id,
        username,
        password,
        email,
        phone,
        name,
        created_at,
        updated_at,
        role,
        salt,
        status
      )
      SELECT
        id,
        TRIM(username),
        password,
        NULLIF(TRIM(COALESCE(email, '')), ''),
        NULLIF(TRIM(COALESCE(phone, '')), ''),
        NULLIF(TRIM(COALESCE(name, '')), ''),
        created_at,
        updated_at,
        TRIM(role),
        salt,
        status
      FROM users_v3_backup
    ''');
    await customStatement('DROP TABLE users_v3_backup');
  }
}

// Lazily open the database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppSecrets.dbName));
    AppLogger.logger.i('Database file path: ${file.path}');

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
