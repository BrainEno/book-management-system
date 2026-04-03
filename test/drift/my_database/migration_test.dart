// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart' hide isNull;
import 'package:drift_dev/api/migrations_native.dart';
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;
import 'generated/schema_v4.dart' as v4;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    const versions = GeneratedHelper.versions;
    final latestVersion = versions.last;

    for (final fromVersion in versions.where(
      (version) => version < latestVersion,
    )) {
      test('from $fromVersion to $latestVersion', () async {
        final schema = await verifier.schemaAt(fromVersion);
        final db = AppDatabase(schema.newConnection());
        await verifier.migrateAndValidate(db, latestVersion);
        await db.close();
      });
    }
  });

  test('migration from v1 to v4 migrates books into products', () async {
    final createdAt = DateTime.utc(2025, 1, 2, 3, 4, 5);
    final updatedAt = DateTime.utc(2025, 1, 2, 6, 7, 8);
    final oldBooksData = <v1.BooksData>[
      v1.BooksData(
        id: 1,
        title: 'Migration Test Book',
        author: 'Author A',
        isbn: '9787300000001',
        category: 'History',
        price: 45.5,
        publisher: 'Test Publisher',
        productId: 'BOOK-001',
        internalPricing: '19.8',
        selfEncoding: 'SELF-001',
        purchasePrice: 15.2,
        publicationYear: 2024,
        retailDiscount: 88,
        wholesaleDiscount: 72,
        wholesalePrice: 30,
        memberDiscount: 90,
        purchaseSaleMode: 'Retail',
        bookmark: 'Yes',
        packaging: 'Box',
        properity: 'Normal',
        statisticalClass: 'A1',
        createdAt: createdAt,
        updatedAt: updatedAt,
      ),
    ];
    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 4,
      createOld: v1.DatabaseAtV1.new,
      createNew: v4.DatabaseAtV4.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.books, oldBooksData);
      },
      validateItems: (newDb) async {
        final products = await newDb.select(newDb.products).get();
        expect(products, hasLength(1));

        final migratedProduct = products.single;
        expect(migratedProduct.id, 1);
        expect(migratedProduct.title, 'Migration Test Book');
        expect(migratedProduct.author, 'Author A');
        expect(migratedProduct.isbn, '9787300000001');
        expect(migratedProduct.category, 'History');
        expect(migratedProduct.price, 4550);
        expect(migratedProduct.publisher, 'Test Publisher');
        expect(migratedProduct.productId, 'BOOK-001');
        expect(migratedProduct.internalPricing, 1980);
        expect(migratedProduct.selfEncoding, 'SELF-001');
        expect(migratedProduct.purchasePrice, 1520);
        expect(migratedProduct.publicationYear, 2024);
        expect(migratedProduct.retailDiscount, 8800);
        expect(migratedProduct.wholesaleDiscount, 7200);
        expect(migratedProduct.wholesalePrice, 3000);
        expect(migratedProduct.memberDiscount, 9000);
        expect(migratedProduct.purchaseSaleMode, 'Retail');
        expect(migratedProduct.bookmark, 'Yes');
        expect(migratedProduct.packaging, 'Box');
        expect(migratedProduct.properity, 'Normal');
        expect(migratedProduct.statisticalClass, 'A1');
        expect(migratedProduct.operator, '');
        expect(
          migratedProduct.createdAt,
          createdAt.millisecondsSinceEpoch ~/ 1000,
        );
        expect(
          migratedProduct.updatedAt,
          updatedAt.millisecondsSinceEpoch ~/ 1000,
        );

        final rawStorage = await newDb.customSelect('''
          SELECT
            typeof(price) AS price_type,
            price,
            typeof(retail_discount) AS retail_discount_type,
            retail_discount
          FROM products
          WHERE id = 1
          ''').getSingle();

        expect(rawStorage.read<String>('price_type'), 'integer');
        expect(rawStorage.read<int>('price'), 4550);
        expect(rawStorage.read<String>('retail_discount_type'), 'integer');
        expect(rawStorage.read<int>('retail_discount'), 8800);
      },
    );
  });

  test('migration from v2 to v4 preserves book data and operator', () async {
    final createdAt = DateTime.utc(2025, 2, 2, 3, 4, 5);
    final updatedAt = DateTime.utc(2025, 2, 2, 6, 7, 8);
    final oldBooksData = <v2.BooksData>[
      v2.BooksData(
        id: 2,
        title: 'Existing Operator Book',
        author: 'Author B',
        isbn: '9787300000002',
        category: 'Tech',
        price: 52.0,
        publisher: 'Second Publisher',
        productId: 'BOOK-002',
        internalPricing: 22.5,
        selfEncoding: 'SELF-002',
        purchasePrice: 16.6,
        publicationYear: 2023,
        retailDiscount: 85.5,
        wholesaleDiscount: 74.5,
        wholesalePrice: 33.5,
        memberDiscount: 92.0,
        purchaseSaleMode: 'Wholesale',
        bookmark: 'No',
        packaging: 'Bag',
        properity: 'Special',
        statisticalClass: 'B2',
        operator: 'beck',
        createdAt: createdAt,
        updatedAt: updatedAt,
      ),
    ];
    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 4,
      createOld: v2.DatabaseAtV2.new,
      createNew: v4.DatabaseAtV4.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.books, oldBooksData);
      },
      validateItems: (newDb) async {
        final products = await newDb.select(newDb.products).get();
        expect(products, hasLength(1));

        final migratedProduct = products.single;
        expect(migratedProduct.id, 2);
        expect(migratedProduct.title, 'Existing Operator Book');
        expect(migratedProduct.author, 'Author B');
        expect(migratedProduct.isbn, '9787300000002');
        expect(migratedProduct.category, 'Tech');
        expect(migratedProduct.price, 5200);
        expect(migratedProduct.publisher, 'Second Publisher');
        expect(migratedProduct.productId, 'BOOK-002');
        expect(migratedProduct.internalPricing, 2250);
        expect(migratedProduct.selfEncoding, 'SELF-002');
        expect(migratedProduct.purchasePrice, 1660);
        expect(migratedProduct.publicationYear, 2023);
        expect(migratedProduct.retailDiscount, 8550);
        expect(migratedProduct.wholesaleDiscount, 7450);
        expect(migratedProduct.wholesalePrice, 3350);
        expect(migratedProduct.memberDiscount, 9200);
        expect(migratedProduct.purchaseSaleMode, 'Wholesale');
        expect(migratedProduct.bookmark, 'No');
        expect(migratedProduct.packaging, 'Bag');
        expect(migratedProduct.properity, 'Special');
        expect(migratedProduct.statisticalClass, 'B2');
        expect(migratedProduct.operator, 'beck');
        expect(
          migratedProduct.createdAt,
          createdAt.millisecondsSinceEpoch ~/ 1000,
        );
        expect(
          migratedProduct.updatedAt,
          updatedAt.millisecondsSinceEpoch ~/ 1000,
        );

        final rawStorage = await newDb.customSelect('''
          SELECT
            price,
            internal_pricing,
            wholesale_discount,
            member_discount
          FROM products
          WHERE id = 2
          ''').getSingle();

        expect(rawStorage.read<int>('price'), 5200);
        expect(rawStorage.read<int>('internal_pricing'), 2250);
        expect(rawStorage.read<int>('wholesale_discount'), 7450);
        expect(rawStorage.read<int>('member_discount'), 9200);
      },
    );
  });

  test(
    'migration from v3 to v4 converts product storage and normalizes user blanks',
    () async {
      final createdAt = DateTime.utc(2025, 3, 2, 3, 4, 5);
      final updatedAt = DateTime.utc(2025, 3, 2, 6, 7, 8);
      final oldProducts = <v3.ProductsData>[
        v3.ProductsData(
          id: 3,
          title: 'Storage Upgrade Book',
          author: 'Author C',
          isbn: '9787300000003',
          category: 'Novel',
          price: 28.75,
          publisher: 'Third Publisher',
          productId: 'BOOK-003',
          internalPricing: 15.4,
          selfEncoding: 'SELF-003',
          purchasePrice: 12.35,
          publicationYear: 2022,
          retailDiscount: 87.5,
          wholesaleDiscount: 73.25,
          wholesalePrice: 24.2,
          memberDiscount: 91.0,
          purchaseSaleMode: 'Retail',
          bookmark: 'A-01',
          packaging: 'Simple',
          properity: 'Standard',
          statisticalClass: 'C3',
          operator: 'operator-c',
          createdAt: createdAt,
          updatedAt: updatedAt,
        ),
      ];
      final oldUsers = <v3.UsersData>[
        v3.UsersData(
          id: 7,
          username: 'owner',
          password: 'hashed-password',
          email: '   ',
          phone: '',
          name: '  店长  ',
          createdAt: createdAt,
          updatedAt: updatedAt,
          role: 'admin',
          salt: 'salt-value',
          status: 2,
        ),
      ];

      await verifier.testWithDataIntegrity(
        oldVersion: 3,
        newVersion: 4,
        createOld: v3.DatabaseAtV3.new,
        createNew: v4.DatabaseAtV4.new,
        openTestedDatabase: AppDatabase.new,
        createItems: (batch, oldDb) {
          batch
            ..insertAll(oldDb.users, oldUsers)
            ..insertAll(oldDb.products, oldProducts);
        },
        validateItems: (newDb) async {
          final migratedProduct = await newDb
              .select(newDb.products)
              .getSingle();
          final migratedUser = await newDb.select(newDb.users).getSingle();

          expect(migratedProduct.price, 2875);
          expect(migratedProduct.internalPricing, 1540);
          expect(migratedProduct.purchasePrice, 1235);
          expect(migratedProduct.retailDiscount, 8750);
          expect(migratedProduct.wholesaleDiscount, 7325);
          expect(migratedProduct.wholesalePrice, 2420);
          expect(migratedProduct.memberDiscount, 9100);

          expect(migratedUser.email, isNull);
          expect(migratedUser.phone, isNull);
          expect(migratedUser.name, '店长');
          expect(migratedUser.status, 2);

          final rawStorage = await newDb.customSelect('''
            SELECT
              typeof(price) AS price_type,
              price,
              typeof(wholesale_discount) AS wholesale_discount_type,
              wholesale_discount
            FROM products
            WHERE id = 3
            ''').getSingle();

          expect(rawStorage.read<String>('price_type'), 'integer');
          expect(rawStorage.read<int>('price'), 2875);
          expect(rawStorage.read<String>('wholesale_discount_type'), 'integer');
          expect(rawStorage.read<int>('wholesale_discount'), 7325);
        },
      );
    },
  );
}
