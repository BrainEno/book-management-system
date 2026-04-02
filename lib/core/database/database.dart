// ignore_for_file: avoid_print
import 'dart:io';

import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/user_dao.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

// Define the database with tables and DAOs
@DriftDatabase(tables: [Products, Users], daos: [ProductDao, UserDao])
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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll(); // Creates all tables defined in @DriftDatabase
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        await _migrateLegacyBooksTable(m);
      }
      await _ensureRequiredTables(m);
    },
    beforeOpen: (details) async {
      await _ensureRequiredTables(migrator);
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Migrator get migrator => Migrator(this);

  Future<bool> _tableExists(String tableName) async {
    final result =
        await customSelect(
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

  Future<void> _ensureRequiredTables(Migrator m) async {
    if (!await _tableExists(users.actualTableName)) {
      await m.createTable(users);
    }

    if (!await _tableExists(products.actualTableName)) {
      await _migrateLegacyBooksTable(m);
    }
  }

  Future<void> _migrateLegacyBooksTable(Migrator m) async {
    if (await _tableExists(products.actualTableName)) {
      return;
    }

    final hasLegacyBooksTable = await _tableExists('books');
    if (!hasLegacyBooksTable) {
      await m.createTable(products);
      return;
    }

    final hasOperatorColumn = await _columnExists('books', 'operator');
    final operatorSelect = hasOperatorColumn ? 'operator' : "''";

    await m.createTable(products);
    await customStatement('''
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
        operator,
        created_at,
        updated_at
      )
      SELECT
        id,
        title,
        author,
        isbn,
        category,
        CAST(price AS REAL),
        publisher,
        book_id,
        CAST(internal_pricing AS REAL),
        self_encoding,
        CAST(purchase_price AS REAL),
        CAST(publication_year AS INTEGER),
        CAST(retail_discount AS REAL),
        CAST(wholesale_discount AS REAL),
        CAST(wholesale_price AS REAL),
        CAST(member_discount AS REAL),
        purchase_sale_mode,
        bookmark,
        packaging,
        properity,
        statistical_class,
        $operatorSelect,
        created_at,
        updated_at
      FROM books
    ''');
    await customStatement('DROP TABLE books');
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
