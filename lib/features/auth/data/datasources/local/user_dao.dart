import 'package:bookstore_management_system/core/database/database.dart';
import 'package:drift/drift.dart';

part 'user_dao.g.dart';

// Users table definition
class Users extends Table {
  @override
  List<String> get customConstraints => const [
    'CHECK (status BETWEEN 0 AND 3)',
  ];

  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 1, max: 64).unique()();
  TextColumn get password => text().withLength(min: 1, max: 255)();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get name => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get role => text().withLength(min: 1, max: 32)();
  TextColumn get salt => text()();
  // Status column to indicate if the user is active or inactive
  // 0 = inactive, 1 = active, 2 = suspended, 3 = deleted
  IntColumn get status => integer().withDefault(const Constant(1))();
}

// DAO for Users table
@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  // Get all users
  Future<List<User>> getAllUsers() => select(users).get();

  // Insert a new user
  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);

  Future<User?> getUserById(int id) {
    return (select(users)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<User?> getUserByUsername(String username) {
    return (select(
      users,
    )..where((t) => t.username.equals(username))).getSingleOrNull();
  }

  // Login with username and password
  Future<User?> loginWithUsernameAndPassword(
    String username,
    String password,
  ) =>
      (select(users)..where(
            (u) => u.username.equals(username) & u.password.equals(password),
          ))
          .getSingleOrNull();
}
