// ignore_for_file: avoid_print
import 'dart:io';

import 'package:bookstore_management_system/core/common/secrets/app_secrets.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/user_dao.dart';
import 'package:bookstore_management_system/features/book/data/datasources/local/book_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

// Define the database with tables and DAOs
@DriftDatabase(tables: [Books, Users], daos: [BookDao, UserDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal(super.e);

  static AppDatabase? _instance;

  factory AppDatabase() {
    return _instance ??= AppDatabase._internal(_openConnection());
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll(); // Creates all tables defined in @DriftDatabase
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Add migration logic here for schema changes in future versions
    },
    beforeOpen: (details) async {
      if (details.wasCreated) {
        // Optionally insert default data here
      }
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

// Lazily open the database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppSecrets.dbName));
    print('Database file path: ${file.path}');

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
