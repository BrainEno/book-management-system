// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bookstore_management_system/core/constants/secrets/app_secrets.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

// Define the database with tables and DAOs
@DriftDatabase(tables: [Books, Users], daos: [BookDao, UserDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal(QueryExecutor e) : super(e);

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

// Books table definition
class Books extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get isbn => text()();
  TextColumn get category => text()();
  RealColumn get price => real()();
}

// Users table definition
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get password => text()();
  TextColumn get role => text()();
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

// DAO for Users table
@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  // Get all users
  Future<List<User>> getAllUsers() => select(users).get();

  // Insert a new user
  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);

  // Find user by username (useful for login)
  Future<User?> findUserByUsername(String username) =>
      (select(users)
        ..where((u) => u.username.equals(username))).getSingleOrNull();
}
