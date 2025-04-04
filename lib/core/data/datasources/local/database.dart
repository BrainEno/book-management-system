import 'dart:io';

import 'package:bookstore_management_system/core/constants/secrets/app_secrets.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Books, Inventories, Sales, Users],
  daos: [BookDao, UserDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite, in the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppSecrets.dbName));
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}

class Books extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get isbn => text()();
  RealColumn get price => real()();
}

class Inventories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().references(Books, #id)();
  IntColumn get quantity => integer()();
  DateTimeColumn get lastUpdated => dateTime()();
}

class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().references(Books, #id)();
  IntColumn get quantity => integer()();
  RealColumn get price => real()();
  DateTimeColumn get saleDate => dateTime()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get password => text()();
  TextColumn get role => text()();
}

@DriftAccessor()
class BookDao extends DatabaseAccessor<AppDatabase> with _$BookDaoMixin {
  BookDao(super.db);
  @override
  $BooksTable get books => attachedDatabase.books;
}

@DriftAccessor()
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);
  @override
  $UsersTable get users => attachedDatabase.users;
}

mixin _$BookDaoMixin on DatabaseAccessor<AppDatabase> {
  $BooksTable get books => attachedDatabase.books;
}

mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
}
