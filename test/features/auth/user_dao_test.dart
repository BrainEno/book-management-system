import 'package:bookstore_management_system/core/database/database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('users default to active status when none is provided', () async {
    final id = await database.userDao.insertUser(
      UsersCompanion.insert(
        username: 'alice',
        password: 'hashed-password',
        role: 'admin',
        salt: 'salt-value',
      ),
    );

    final user = await database.userDao.getUserById(id);

    expect(user, isNotNull);
    expect(user!.status, 1);
  });

  test('users reject invalid lifecycle status values', () async {
    expect(
      () => database.userDao.insertUser(
        UsersCompanion.insert(
          username: 'bob',
          password: 'hashed-password',
          role: 'admin',
          salt: 'salt-value',
          status: Value(9),
        ),
      ),
      throwsA(isA<SqliteException>()),
    );
  });
}
