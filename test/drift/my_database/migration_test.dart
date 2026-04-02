// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;

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

  test('migration from v1 to v3 migrates books into products', () async {
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
      newVersion: 3,
      createOld: v1.DatabaseAtV1.new,
      createNew: v3.DatabaseAtV3.new,
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
        expect(migratedProduct.price, 45.5);
        expect(migratedProduct.publisher, 'Test Publisher');
        expect(migratedProduct.productId, 'BOOK-001');
        expect(migratedProduct.internalPricing, 19.8);
        expect(migratedProduct.selfEncoding, 'SELF-001');
        expect(migratedProduct.purchasePrice, 15.2);
        expect(migratedProduct.publicationYear, 2024);
        expect(migratedProduct.retailDiscount, 88.0);
        expect(migratedProduct.wholesaleDiscount, 72.0);
        expect(migratedProduct.wholesalePrice, 30.0);
        expect(migratedProduct.memberDiscount, 90.0);
        expect(migratedProduct.purchaseSaleMode, 'Retail');
        expect(migratedProduct.bookmark, 'Yes');
        expect(migratedProduct.packaging, 'Box');
        expect(migratedProduct.properity, 'Normal');
        expect(migratedProduct.statisticalClass, 'A1');
        expect(migratedProduct.operator, '');
        expect(migratedProduct.createdAt.isAtSameMomentAs(createdAt), isTrue);
        expect(migratedProduct.updatedAt.isAtSameMomentAs(updatedAt), isTrue);
      },
    );
  });

  test('migration from v2 to v3 preserves book data and operator', () async {
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
      newVersion: 3,
      createOld: v2.DatabaseAtV2.new,
      createNew: v3.DatabaseAtV3.new,
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
        expect(migratedProduct.price, 52.0);
        expect(migratedProduct.publisher, 'Second Publisher');
        expect(migratedProduct.productId, 'BOOK-002');
        expect(migratedProduct.internalPricing, 22.5);
        expect(migratedProduct.selfEncoding, 'SELF-002');
        expect(migratedProduct.purchasePrice, 16.6);
        expect(migratedProduct.publicationYear, 2023);
        expect(migratedProduct.retailDiscount, 85.5);
        expect(migratedProduct.wholesaleDiscount, 74.5);
        expect(migratedProduct.wholesalePrice, 33.5);
        expect(migratedProduct.memberDiscount, 92.0);
        expect(migratedProduct.purchaseSaleMode, 'Wholesale');
        expect(migratedProduct.bookmark, 'No');
        expect(migratedProduct.packaging, 'Bag');
        expect(migratedProduct.properity, 'Special');
        expect(migratedProduct.statisticalClass, 'B2');
        expect(migratedProduct.operator, 'beck');
        expect(migratedProduct.createdAt.isAtSameMomentAs(createdAt), isTrue);
        expect(migratedProduct.updatedAt.isAtSameMomentAs(updatedAt), isTrue);
      },
    );
  });
}
