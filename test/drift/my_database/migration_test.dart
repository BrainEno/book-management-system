import 'dart:io';

import 'package:bookstore_management_system/core/database/database.dart';
import 'package:drift/drift.dart' show Value, Variable;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

void main() {
  late AppDatabase database;

  tearDown(() async {
    await database.close();
  });

  test('fresh database creates the recommended support tables', () async {
    database = AppDatabase(NativeDatabase.memory());

    final tableRows = await database.customSelect('''
      SELECT name
      FROM sqlite_master
      WHERE type = 'table'
      ORDER BY name
      ''').get();
    final tableNames = tableRows.map((row) => row.read<String>('name')).toSet();

    expect(
      tableNames,
      containsAll([
        'users',
        'products',
        'product_categories',
        'publishers',
        'purchase_sale_modes',
        'suppliers',
        'customers',
        'warehouses',
        'stock_balances',
        'stock_movements',
        'purchase_orders',
        'purchase_order_items',
        'sales_orders',
        'sales_order_items',
      ]),
    );

    final userId = await database
        .into(database.users)
        .insert(
          UsersCompanion.insert(
            username: 'admin',
            password: 'hashed-password',
            role: 'admin',
            salt: 'salt-value',
          ),
        );

    final categoryId = await database
        .into(database.productCategories)
        .insert(ProductCategoriesCompanion.insert(code: 'BOOK', name: 'Books'));

    final publisherId = await database
        .into(database.publishers)
        .insert(
          PublishersCompanion.insert(
            code: const Value('PUB-001'),
            name: 'Test Publisher',
          ),
        );

    final saleModeRows = await database.customSelect('''
      SELECT id, code, name
      FROM purchase_sale_modes
      ORDER BY id
      ''').get();
    expect(saleModeRows, isNotEmpty);
    expect(
      saleModeRows.map((row) => row.read<String>('code')).toSet(),
      contains('retail'),
    );
    final retailSaleModeId = saleModeRows
        .firstWhere((row) => row.read<String>('code') == 'retail')
        .read<int>('id');

    final supplierId = await database
        .into(database.suppliers)
        .insert(
          SuppliersCompanion.insert(code: 'SUP-001', name: 'Main Supplier'),
        );

    final customerId = await database
        .into(database.customers)
        .insert(
          CustomersCompanion.insert(code: 'CUST-001', name: 'Walk-in Customer'),
        );

    final warehouseId = await database
        .into(database.warehouses)
        .insert(
          WarehousesCompanion.insert(
            code: 'WH-001',
            name: 'Main Warehouse',
            managerUserId: Value(userId),
          ),
        );

    final productId = await database
        .into(database.products)
        .insert(
          ProductsCompanion.insert(
            title: 'Support Table Sample',
            author: 'Library Team',
            price: 39.5,
            productId: 'SKU-001',
            selfEncoding: 'CODE-001',
            category: Value('BOOK'),
            categoryId: Value(categoryId),
            publisher: Value('Test Publisher'),
            publisherId: Value(publisherId),
            purchaseSaleMode: const Value('普通零售'),
            purchaseSaleModeId: Value(retailSaleModeId),
            stockUnit: const Value('册'),
            createdBy: Value(userId),
            updatedBy: Value(userId),
            publicationYear: const Value(2026),
            retailDiscount: const Value(100.0),
            wholesaleDiscount: const Value(98.0),
            memberDiscount: const Value(95.0),
          ),
        );

    final stockBalanceId = await database
        .into(database.stockBalances)
        .insert(
          StockBalancesCompanion.insert(
            warehouseId: warehouseId,
            productId: productId,
          ),
        );

    final movementId = await database
        .into(database.stockMovements)
        .insert(
          StockMovementsCompanion.insert(
            movementNo: 'MV-001',
            movementType: 'purchase_in',
            warehouseId: warehouseId,
            productId: productId,
            qtyDelta: 12,
            occurredAt: DateTime.utc(2026, 4, 3, 8, 30),
            operatorUserId: Value(userId),
          ),
        );

    final purchaseOrderId = await database
        .into(database.purchaseOrders)
        .insert(
          PurchaseOrdersCompanion.insert(
            orderNo: 'PO-001',
            supplierId: supplierId,
            warehouseId: warehouseId,
            orderedAt: DateTime.utc(2026, 4, 3, 9, 0),
            createdBy: Value(userId),
            approvedBy: Value(userId),
          ),
        );

    final purchaseItemId = await database
        .into(database.purchaseOrderItems)
        .insert(
          PurchaseOrderItemsCompanion.insert(
            purchaseOrderId: purchaseOrderId,
            lineNo: 1,
            productId: productId,
            qty: 12,
            unitPriceCent: 3550,
            lineAmountCent: 42600,
          ),
        );

    final salesOrderId = await database
        .into(database.salesOrders)
        .insert(
          SalesOrdersCompanion.insert(
            orderNo: 'SO-001',
            customerId: Value(customerId),
            warehouseId: warehouseId,
            soldAt: DateTime.utc(2026, 4, 3, 10, 0),
            createdBy: Value(userId),
          ),
        );

    final salesItemId = await database
        .into(database.salesOrderItems)
        .insert(
          SalesOrderItemsCompanion.insert(
            salesOrderId: salesOrderId,
            lineNo: 1,
            productId: productId,
            qty: 2,
            unitPriceCent: 3950,
            lineAmountCent: 7900,
            costPriceCent: const Value(3550),
          ),
        );

    final customerDefaults = await database
        .customSelect(
          '''
      SELECT customer_type, status
      FROM customers
      WHERE id = ?
      ''',
          variables: [Variable.withInt(customerId)],
        )
        .getSingle();
    expect(customerDefaults.read<String>('customer_type'), 'retail');
    expect(customerDefaults.read<int>('status'), 1);

    final warehouseForeignKeys = await database
        .customSelect("PRAGMA foreign_key_list('warehouses')")
        .get();
    expect(
      warehouseForeignKeys.map((row) => row.read<String>('table')).toSet(),
      contains('users'),
    );

    final stockBalanceDefaults = await database
        .customSelect(
          '''
      SELECT on_hand_qty, reserved_qty, safety_stock_qty
      FROM stock_balances
      WHERE id = ?
      ''',
          variables: [Variable.withInt(stockBalanceId)],
        )
        .getSingle();
    expect(stockBalanceDefaults.read<int>('on_hand_qty'), 0);
    expect(stockBalanceDefaults.read<int>('reserved_qty'), 0);
    expect(stockBalanceDefaults.read<int>('safety_stock_qty'), 0);

    final salesOrderDefaults = await database
        .customSelect(
          '''
      SELECT sales_channel, status
      FROM sales_orders
      WHERE id = ?
      ''',
          variables: [Variable.withInt(salesOrderId)],
        )
        .getSingle();
    expect(salesOrderDefaults.read<String>('sales_channel'), 'store');
    expect(salesOrderDefaults.read<int>('status'), 0);

    final movementRow = await database
        .customSelect(
          '''
      SELECT movement_type, qty_delta
      FROM stock_movements
      WHERE id = ?
      ''',
          variables: [Variable.withInt(movementId)],
        )
        .getSingle();
    expect(movementRow.read<String>('movement_type'), 'purchase_in');
    expect(movementRow.read<int>('qty_delta'), 12);

    final purchaseItemRow = await database
        .customSelect(
          '''
      SELECT qty, line_amount_cent
      FROM purchase_order_items
      WHERE id = ?
      ''',
          variables: [Variable.withInt(purchaseItemId)],
        )
        .getSingle();
    expect(purchaseItemRow.read<int>('qty'), 12);
    expect(purchaseItemRow.read<int>('line_amount_cent'), 42600);

    final salesItemRow = await database
        .customSelect(
          '''
      SELECT qty, line_amount_cent
      FROM sales_order_items
      WHERE id = ?
      ''',
          variables: [Variable.withInt(salesItemId)],
        )
        .getSingle();
    expect(salesItemRow.read<int>('qty'), 2);
    expect(salesItemRow.read<int>('line_amount_cent'), 7900);

    final productRow = await database
        .customSelect(
          '''
      SELECT title, author, typeof(price) AS price_type, price
      FROM products
      WHERE id = ?
      ''',
          variables: [Variable.withInt(productId)],
        )
        .getSingle();
    expect(productRow.read<String>('title'), 'Support Table Sample');
    expect(productRow.read<String>('author'), 'Library Team');
    expect(productRow.read<String>('price_type'), 'integer');
    expect(productRow.read<int>('price'), 3950);

    final productFoundationRow = await database
        .customSelect(
          '''
      SELECT
        status,
        stock_unit,
        category_id,
        publisher_id,
        purchase_sale_mode_id
      FROM products
      WHERE id = ?
      ''',
          variables: [Variable.withInt(productId)],
        )
        .getSingle();
    expect(productFoundationRow.read<int>('status'), 1);
    expect(productFoundationRow.read<String>('stock_unit'), '册');
    expect(productFoundationRow.read<int>('category_id'), categoryId);
    expect(productFoundationRow.read<int>('publisher_id'), publisherId);
    expect(
      productFoundationRow.read<int>('purchase_sale_mode_id'),
      retailSaleModeId,
    );

    final purchaseFoundationRow = await database
        .customSelect(
          '''
      SELECT posted_by, posted_at
      FROM purchase_orders
      WHERE id = ?
      ''',
          variables: [Variable.withInt(purchaseOrderId)],
        )
        .getSingle();
    expect(purchaseFoundationRow.data['posted_by'], isNull);
    expect(purchaseFoundationRow.data['posted_at'], isNull);
  });

  test(
    'legacy v5 databases upgrade to v6 without losing product data',
    () async {
      final tempDir = await Directory.systemTemp.createTemp('bookstore_v5_');

      final dbFile = File(p.join(tempDir.path, 'legacy_v5.sqlite'));
      final rawDb = sqlite3.open(dbFile.path);
      rawDb.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        email TEXT,
        phone TEXT,
        name TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        role TEXT NOT NULL,
        salt TEXT NOT NULL,
        status INTEGER NOT NULL DEFAULT 1
      );
    ''');
      rawDb.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        isbn TEXT UNIQUE,
        category TEXT,
        price INTEGER NOT NULL,
        publisher TEXT,
        product_id TEXT NOT NULL UNIQUE,
        internal_pricing INTEGER,
        self_encoding TEXT NOT NULL UNIQUE,
        purchase_price INTEGER,
        publication_year INTEGER,
        retail_discount INTEGER,
        wholesale_discount INTEGER,
        wholesale_price INTEGER,
        member_discount INTEGER,
        purchase_sale_mode TEXT,
        bookmark TEXT,
        packaging TEXT,
        properity TEXT,
        statistical_class TEXT,
        created_by INTEGER,
        updated_by INTEGER,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY(created_by) REFERENCES users(id),
        FOREIGN KEY(updated_by) REFERENCES users(id)
      );
    ''');
      rawDb.execute('PRAGMA user_version = 5');
      rawDb.execute('''
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
      ) VALUES (
        1,
        'legacy-admin',
        'hashed-password',
        'admin@example.com',
        '010-00000000',
        'Legacy Admin',
        1712100000,
        1712103600,
        'admin',
        'salt-value',
        1
      );
    ''');
      rawDb.execute('''
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
      ) VALUES (
        10,
        'Legacy Product',
        'Legacy Author',
        '9787300000999',
        'History',
        4250,
        'Legacy Press',
        'SKU-LEG-001',
        1980,
        'LEG-001',
        1600,
        2024,
        8750,
        8200,
        3900,
        9300,
        'Retail',
        'A-01',
        'Box',
        'Normal',
        'A1',
        1,
        1,
        1712100000,
        1712103600
      );
    ''');
      rawDb.close();

      database = AppDatabase(NativeDatabase.createInBackground(dbFile));

      final tableRows = await database.customSelect('''
      SELECT name
      FROM sqlite_master
      WHERE type = 'table'
      ORDER BY name
      ''').get();
      final tableNames = tableRows
          .map((row) => row.read<String>('name'))
          .toSet();

      expect(
        tableNames,
        containsAll([
          'product_categories',
          'warehouses',
          'purchase_sale_modes',
        ]),
      );

      final productRow = await database.customSelect('''
      SELECT title, author, price, created_by, updated_by
      FROM products
      WHERE id = 10
      ''').getSingle();
      expect(productRow.read<String>('title'), 'Legacy Product');
      expect(productRow.read<String>('author'), 'Legacy Author');
      expect(productRow.read<int>('price'), 4250);
      expect(productRow.read<int>('created_by'), 1);
      expect(productRow.read<int>('updated_by'), 1);

      final userRow = await database.customSelect('''
      SELECT username, status
      FROM users
      WHERE id = 1
      ''').getSingle();
      expect(userRow.read<String>('username'), 'legacy-admin');
      expect(userRow.read<int>('status'), 1);

      final publisherRow = await database.customSelect('''
      SELECT COUNT(*) AS count
      FROM publishers
      ''').getSingle();
      expect(publisherRow.read<int>('count'), 0);

      final supportTables = await database.customSelect('''
      SELECT name
      FROM sqlite_master
      WHERE type = 'table'
        AND name IN (
          'product_categories',
          'publishers',
          'purchase_sale_modes',
          'suppliers',
          'customers',
          'warehouses',
          'stock_balances',
          'stock_movements',
          'purchase_orders',
          'purchase_order_items',
          'sales_orders',
          'sales_order_items'
        )
      ''').get();
      expect(supportTables, hasLength(12));

      final saleModeCount = await database.customSelect('''
      SELECT COUNT(*) AS count
      FROM purchase_sale_modes
      ''').getSingle();
      expect(saleModeCount.read<int>('count'), greaterThanOrEqualTo(5));

      final productFoundationColumns = await database
          .customSelect("PRAGMA table_info('products')")
          .get();
      final productColumnNames = productFoundationColumns
          .map((row) => row.read<String>('name'))
          .toSet();
      expect(
        productColumnNames,
        containsAll([
          'category_id',
          'publisher_id',
          'purchase_sale_mode_id',
          'status',
          'stock_unit',
          'min_stock_alert_qty',
          'max_stock_alert_qty',
        ]),
      );
    },
  );
}
