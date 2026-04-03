// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
    'salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    password,
    email,
    phone,
    name,
    createdAt,
    updatedAt,
    role,
    salt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('salt')) {
      context.handle(
        _saltMeta,
        salt.isAcceptableOrUnknown(data['salt']!, _saltMeta),
      );
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      salt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}salt'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String password;
  final String? email;
  final String? phone;
  final String? name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role;
  final String salt;
  final int status;
  const User({
    required this.id,
    required this.username,
    required this.password,
    this.email,
    this.phone,
    this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.salt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['role'] = Variable<String>(role);
    map['salt'] = Variable<String>(salt);
    map['status'] = Variable<int>(status);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      role: Value(role),
      salt: Value(salt),
      status: Value(status),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      name: serializer.fromJson<String?>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      role: serializer.fromJson<String>(json['role']),
      salt: serializer.fromJson<String>(json['salt']),
      status: serializer.fromJson<int>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'name': serializer.toJson<String?>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'role': serializer.toJson<String>(role),
      'salt': serializer.toJson<String>(salt),
      'status': serializer.toJson<int>(status),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? password,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> name = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? role,
    String? salt,
    int? status,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    password: password ?? this.password,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    name: name.present ? name.value : this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    role: role ?? this.role,
    salt: salt ?? this.salt,
    status: status ?? this.status,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      role: data.role.present ? data.role.value : this.role,
      salt: data.salt.present ? data.salt.value : this.salt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('role: $role, ')
          ..write('salt: $salt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    password,
    email,
    phone,
    name,
    createdAt,
    updatedAt,
    role,
    salt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.role == this.role &&
          other.salt == this.salt &&
          other.status == this.status);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> role;
  final Value<String> salt;
  final Value<int> status;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.role = const Value.absent(),
    this.salt = const Value.absent(),
    this.status = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String role,
    required String salt,
    this.status = const Value.absent(),
  }) : username = Value(username),
       password = Value(password),
       role = Value(role),
       salt = Value(salt);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? role,
    Expression<String>? salt,
    Expression<int>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (role != null) 'role': role,
      if (salt != null) 'salt': salt,
      if (status != null) 'status': status,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? password,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? role,
    Value<String>? salt,
    Value<int>? status,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      role: role ?? this.role,
      salt: salt ?? this.salt,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('role: $role, ')
          ..write('salt: $salt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isbnMeta = const VerificationMeta('isbn');
  @override
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
    'isbn',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<double, int> price =
      GeneratedColumn<int>(
        'price',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<double>($ProductsTable.$converterprice);
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<double?, int> internalPricing =
      GeneratedColumn<int>(
        'internal_pricing',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<double?>($ProductsTable.$converterinternalPricing);
  static const VerificationMeta _selfEncodingMeta = const VerificationMeta(
    'selfEncoding',
  );
  @override
  late final GeneratedColumn<String> selfEncoding = GeneratedColumn<String>(
    'self_encoding',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<double?, int> purchasePrice =
      GeneratedColumn<int>(
        'purchase_price',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<double?>($ProductsTable.$converterpurchasePrice);
  static const VerificationMeta _publicationYearMeta = const VerificationMeta(
    'publicationYear',
  );
  @override
  late final GeneratedColumn<int> publicationYear = GeneratedColumn<int>(
    'publication_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<double?, int> retailDiscount =
      GeneratedColumn<int>(
        'retail_discount',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<double?>($ProductsTable.$converterretailDiscount);
  @override
  late final GeneratedColumnWithTypeConverter<double?, int> wholesaleDiscount =
      GeneratedColumn<int>(
        'wholesale_discount',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<double?>($ProductsTable.$converterwholesaleDiscount);
  @override
  late final GeneratedColumnWithTypeConverter<double?, int> wholesalePrice =
      GeneratedColumn<int>(
        'wholesale_price',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<double?>($ProductsTable.$converterwholesalePrice);
  @override
  late final GeneratedColumnWithTypeConverter<double?, int> memberDiscount =
      GeneratedColumn<int>(
        'member_discount',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<double?>($ProductsTable.$convertermemberDiscount);
  static const VerificationMeta _purchaseSaleModeMeta = const VerificationMeta(
    'purchaseSaleMode',
  );
  @override
  late final GeneratedColumn<String> purchaseSaleMode = GeneratedColumn<String>(
    'purchase_sale_mode',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bookmarkMeta = const VerificationMeta(
    'bookmark',
  );
  @override
  late final GeneratedColumn<String> bookmark = GeneratedColumn<String>(
    'bookmark',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _packagingMeta = const VerificationMeta(
    'packaging',
  );
  @override
  late final GeneratedColumn<String> packaging = GeneratedColumn<String>(
    'packaging',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _properityMeta = const VerificationMeta(
    'properity',
  );
  @override
  late final GeneratedColumn<String> properity = GeneratedColumn<String>(
    'properity',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statisticalClassMeta = const VerificationMeta(
    'statisticalClass',
  );
  @override
  late final GeneratedColumn<String> statisticalClass = GeneratedColumn<String>(
    'statistical_class',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<int> createdBy = GeneratedColumn<int>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON UPDATE CASCADE ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<int> updatedBy = GeneratedColumn<int>(
    'updated_by',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON UPDATE CASCADE ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    author,
    isbn,
    category,
    price,
    publisher,
    productId,
    internalPricing,
    selfEncoding,
    purchasePrice,
    publicationYear,
    retailDiscount,
    wholesaleDiscount,
    wholesalePrice,
    memberDiscount,
    purchaseSaleMode,
    bookmark,
    packaging,
    properity,
    statisticalClass,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('isbn')) {
      context.handle(
        _isbnMeta,
        isbn.isAcceptableOrUnknown(data['isbn']!, _isbnMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('self_encoding')) {
      context.handle(
        _selfEncodingMeta,
        selfEncoding.isAcceptableOrUnknown(
          data['self_encoding']!,
          _selfEncodingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_selfEncodingMeta);
    }
    if (data.containsKey('publication_year')) {
      context.handle(
        _publicationYearMeta,
        publicationYear.isAcceptableOrUnknown(
          data['publication_year']!,
          _publicationYearMeta,
        ),
      );
    }
    if (data.containsKey('purchase_sale_mode')) {
      context.handle(
        _purchaseSaleModeMeta,
        purchaseSaleMode.isAcceptableOrUnknown(
          data['purchase_sale_mode']!,
          _purchaseSaleModeMeta,
        ),
      );
    }
    if (data.containsKey('bookmark')) {
      context.handle(
        _bookmarkMeta,
        bookmark.isAcceptableOrUnknown(data['bookmark']!, _bookmarkMeta),
      );
    }
    if (data.containsKey('packaging')) {
      context.handle(
        _packagingMeta,
        packaging.isAcceptableOrUnknown(data['packaging']!, _packagingMeta),
      );
    }
    if (data.containsKey('properity')) {
      context.handle(
        _properityMeta,
        properity.isAcceptableOrUnknown(data['properity']!, _properityMeta),
      );
    }
    if (data.containsKey('statistical_class')) {
      context.handle(
        _statisticalClassMeta,
        statisticalClass.isAcceptableOrUnknown(
          data['statistical_class']!,
          _statisticalClassMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      isbn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isbn'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      price: $ProductsTable.$converterprice.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}price'],
        )!,
      ),
      publisher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      ),
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      internalPricing: $ProductsTable.$converterinternalPricing.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}internal_pricing'],
        ),
      ),
      selfEncoding: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}self_encoding'],
      )!,
      purchasePrice: $ProductsTable.$converterpurchasePrice.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}purchase_price'],
        ),
      ),
      publicationYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}publication_year'],
      ),
      retailDiscount: $ProductsTable.$converterretailDiscount.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}retail_discount'],
        ),
      ),
      wholesaleDiscount: $ProductsTable.$converterwholesaleDiscount.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}wholesale_discount'],
        ),
      ),
      wholesalePrice: $ProductsTable.$converterwholesalePrice.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}wholesale_price'],
        ),
      ),
      memberDiscount: $ProductsTable.$convertermemberDiscount.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}member_discount'],
        ),
      ),
      purchaseSaleMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_sale_mode'],
      ),
      bookmark: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bookmark'],
      ),
      packaging: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}packaging'],
      ),
      properity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}properity'],
      ),
      statisticalClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statistical_class'],
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_by'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }

  static TypeConverter<double, int> $converterprice = moneyAsCentsConverter;
  static TypeConverter<double?, int?> $converterinternalPricing =
      nullableMoneyAsCentsConverter;
  static TypeConverter<double?, int?> $converterpurchasePrice =
      nullableMoneyAsCentsConverter;
  static TypeConverter<double?, int?> $converterretailDiscount =
      nullableDiscountAsBasisPointsConverter;
  static TypeConverter<double?, int?> $converterwholesaleDiscount =
      nullableDiscountAsBasisPointsConverter;
  static TypeConverter<double?, int?> $converterwholesalePrice =
      nullableMoneyAsCentsConverter;
  static TypeConverter<double?, int?> $convertermemberDiscount =
      nullableDiscountAsBasisPointsConverter;
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String title;
  final String author;
  final String? isbn;
  final String? category;
  final double price;
  final String? publisher;
  final String productId;
  final double? internalPricing;
  final String selfEncoding;
  final double? purchasePrice;
  final int? publicationYear;
  final double? retailDiscount;
  final double? wholesaleDiscount;
  final double? wholesalePrice;
  final double? memberDiscount;
  final String? purchaseSaleMode;
  final String? bookmark;
  final String? packaging;
  final String? properity;
  final String? statisticalClass;
  final int? createdBy;
  final int? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product({
    required this.id,
    required this.title,
    required this.author,
    this.isbn,
    this.category,
    required this.price,
    this.publisher,
    required this.productId,
    this.internalPricing,
    required this.selfEncoding,
    this.purchasePrice,
    this.publicationYear,
    this.retailDiscount,
    this.wholesaleDiscount,
    this.wholesalePrice,
    this.memberDiscount,
    this.purchaseSaleMode,
    this.bookmark,
    this.packaging,
    this.properity,
    this.statisticalClass,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    if (!nullToAbsent || isbn != null) {
      map['isbn'] = Variable<String>(isbn);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    {
      map['price'] = Variable<int>($ProductsTable.$converterprice.toSql(price));
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    map['product_id'] = Variable<String>(productId);
    if (!nullToAbsent || internalPricing != null) {
      map['internal_pricing'] = Variable<int>(
        $ProductsTable.$converterinternalPricing.toSql(internalPricing),
      );
    }
    map['self_encoding'] = Variable<String>(selfEncoding);
    if (!nullToAbsent || purchasePrice != null) {
      map['purchase_price'] = Variable<int>(
        $ProductsTable.$converterpurchasePrice.toSql(purchasePrice),
      );
    }
    if (!nullToAbsent || publicationYear != null) {
      map['publication_year'] = Variable<int>(publicationYear);
    }
    if (!nullToAbsent || retailDiscount != null) {
      map['retail_discount'] = Variable<int>(
        $ProductsTable.$converterretailDiscount.toSql(retailDiscount),
      );
    }
    if (!nullToAbsent || wholesaleDiscount != null) {
      map['wholesale_discount'] = Variable<int>(
        $ProductsTable.$converterwholesaleDiscount.toSql(wholesaleDiscount),
      );
    }
    if (!nullToAbsent || wholesalePrice != null) {
      map['wholesale_price'] = Variable<int>(
        $ProductsTable.$converterwholesalePrice.toSql(wholesalePrice),
      );
    }
    if (!nullToAbsent || memberDiscount != null) {
      map['member_discount'] = Variable<int>(
        $ProductsTable.$convertermemberDiscount.toSql(memberDiscount),
      );
    }
    if (!nullToAbsent || purchaseSaleMode != null) {
      map['purchase_sale_mode'] = Variable<String>(purchaseSaleMode);
    }
    if (!nullToAbsent || bookmark != null) {
      map['bookmark'] = Variable<String>(bookmark);
    }
    if (!nullToAbsent || packaging != null) {
      map['packaging'] = Variable<String>(packaging);
    }
    if (!nullToAbsent || properity != null) {
      map['properity'] = Variable<String>(properity);
    }
    if (!nullToAbsent || statisticalClass != null) {
      map['statistical_class'] = Variable<String>(statisticalClass);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<int>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<int>(updatedBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      isbn: isbn == null && nullToAbsent ? const Value.absent() : Value(isbn),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      price: Value(price),
      publisher: publisher == null && nullToAbsent
          ? const Value.absent()
          : Value(publisher),
      productId: Value(productId),
      internalPricing: internalPricing == null && nullToAbsent
          ? const Value.absent()
          : Value(internalPricing),
      selfEncoding: Value(selfEncoding),
      purchasePrice: purchasePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePrice),
      publicationYear: publicationYear == null && nullToAbsent
          ? const Value.absent()
          : Value(publicationYear),
      retailDiscount: retailDiscount == null && nullToAbsent
          ? const Value.absent()
          : Value(retailDiscount),
      wholesaleDiscount: wholesaleDiscount == null && nullToAbsent
          ? const Value.absent()
          : Value(wholesaleDiscount),
      wholesalePrice: wholesalePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(wholesalePrice),
      memberDiscount: memberDiscount == null && nullToAbsent
          ? const Value.absent()
          : Value(memberDiscount),
      purchaseSaleMode: purchaseSaleMode == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseSaleMode),
      bookmark: bookmark == null && nullToAbsent
          ? const Value.absent()
          : Value(bookmark),
      packaging: packaging == null && nullToAbsent
          ? const Value.absent()
          : Value(packaging),
      properity: properity == null && nullToAbsent
          ? const Value.absent()
          : Value(properity),
      statisticalClass: statisticalClass == null && nullToAbsent
          ? const Value.absent()
          : Value(statisticalClass),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      isbn: serializer.fromJson<String?>(json['isbn']),
      category: serializer.fromJson<String?>(json['category']),
      price: serializer.fromJson<double>(json['price']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      productId: serializer.fromJson<String>(json['productId']),
      internalPricing: serializer.fromJson<double?>(json['internalPricing']),
      selfEncoding: serializer.fromJson<String>(json['selfEncoding']),
      purchasePrice: serializer.fromJson<double?>(json['purchasePrice']),
      publicationYear: serializer.fromJson<int?>(json['publicationYear']),
      retailDiscount: serializer.fromJson<double?>(json['retailDiscount']),
      wholesaleDiscount: serializer.fromJson<double?>(
        json['wholesaleDiscount'],
      ),
      wholesalePrice: serializer.fromJson<double?>(json['wholesalePrice']),
      memberDiscount: serializer.fromJson<double?>(json['memberDiscount']),
      purchaseSaleMode: serializer.fromJson<String?>(json['purchaseSaleMode']),
      bookmark: serializer.fromJson<String?>(json['bookmark']),
      packaging: serializer.fromJson<String?>(json['packaging']),
      properity: serializer.fromJson<String?>(json['properity']),
      statisticalClass: serializer.fromJson<String?>(json['statisticalClass']),
      createdBy: serializer.fromJson<int?>(json['createdBy']),
      updatedBy: serializer.fromJson<int?>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'isbn': serializer.toJson<String?>(isbn),
      'category': serializer.toJson<String?>(category),
      'price': serializer.toJson<double>(price),
      'publisher': serializer.toJson<String?>(publisher),
      'productId': serializer.toJson<String>(productId),
      'internalPricing': serializer.toJson<double?>(internalPricing),
      'selfEncoding': serializer.toJson<String>(selfEncoding),
      'purchasePrice': serializer.toJson<double?>(purchasePrice),
      'publicationYear': serializer.toJson<int?>(publicationYear),
      'retailDiscount': serializer.toJson<double?>(retailDiscount),
      'wholesaleDiscount': serializer.toJson<double?>(wholesaleDiscount),
      'wholesalePrice': serializer.toJson<double?>(wholesalePrice),
      'memberDiscount': serializer.toJson<double?>(memberDiscount),
      'purchaseSaleMode': serializer.toJson<String?>(purchaseSaleMode),
      'bookmark': serializer.toJson<String?>(bookmark),
      'packaging': serializer.toJson<String?>(packaging),
      'properity': serializer.toJson<String?>(properity),
      'statisticalClass': serializer.toJson<String?>(statisticalClass),
      'createdBy': serializer.toJson<int?>(createdBy),
      'updatedBy': serializer.toJson<int?>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith({
    int? id,
    String? title,
    String? author,
    Value<String?> isbn = const Value.absent(),
    Value<String?> category = const Value.absent(),
    double? price,
    Value<String?> publisher = const Value.absent(),
    String? productId,
    Value<double?> internalPricing = const Value.absent(),
    String? selfEncoding,
    Value<double?> purchasePrice = const Value.absent(),
    Value<int?> publicationYear = const Value.absent(),
    Value<double?> retailDiscount = const Value.absent(),
    Value<double?> wholesaleDiscount = const Value.absent(),
    Value<double?> wholesalePrice = const Value.absent(),
    Value<double?> memberDiscount = const Value.absent(),
    Value<String?> purchaseSaleMode = const Value.absent(),
    Value<String?> bookmark = const Value.absent(),
    Value<String?> packaging = const Value.absent(),
    Value<String?> properity = const Value.absent(),
    Value<String?> statisticalClass = const Value.absent(),
    Value<int?> createdBy = const Value.absent(),
    Value<int?> updatedBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Product(
    id: id ?? this.id,
    title: title ?? this.title,
    author: author ?? this.author,
    isbn: isbn.present ? isbn.value : this.isbn,
    category: category.present ? category.value : this.category,
    price: price ?? this.price,
    publisher: publisher.present ? publisher.value : this.publisher,
    productId: productId ?? this.productId,
    internalPricing: internalPricing.present
        ? internalPricing.value
        : this.internalPricing,
    selfEncoding: selfEncoding ?? this.selfEncoding,
    purchasePrice: purchasePrice.present
        ? purchasePrice.value
        : this.purchasePrice,
    publicationYear: publicationYear.present
        ? publicationYear.value
        : this.publicationYear,
    retailDiscount: retailDiscount.present
        ? retailDiscount.value
        : this.retailDiscount,
    wholesaleDiscount: wholesaleDiscount.present
        ? wholesaleDiscount.value
        : this.wholesaleDiscount,
    wholesalePrice: wholesalePrice.present
        ? wholesalePrice.value
        : this.wholesalePrice,
    memberDiscount: memberDiscount.present
        ? memberDiscount.value
        : this.memberDiscount,
    purchaseSaleMode: purchaseSaleMode.present
        ? purchaseSaleMode.value
        : this.purchaseSaleMode,
    bookmark: bookmark.present ? bookmark.value : this.bookmark,
    packaging: packaging.present ? packaging.value : this.packaging,
    properity: properity.present ? properity.value : this.properity,
    statisticalClass: statisticalClass.present
        ? statisticalClass.value
        : this.statisticalClass,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      isbn: data.isbn.present ? data.isbn.value : this.isbn,
      category: data.category.present ? data.category.value : this.category,
      price: data.price.present ? data.price.value : this.price,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      productId: data.productId.present ? data.productId.value : this.productId,
      internalPricing: data.internalPricing.present
          ? data.internalPricing.value
          : this.internalPricing,
      selfEncoding: data.selfEncoding.present
          ? data.selfEncoding.value
          : this.selfEncoding,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      publicationYear: data.publicationYear.present
          ? data.publicationYear.value
          : this.publicationYear,
      retailDiscount: data.retailDiscount.present
          ? data.retailDiscount.value
          : this.retailDiscount,
      wholesaleDiscount: data.wholesaleDiscount.present
          ? data.wholesaleDiscount.value
          : this.wholesaleDiscount,
      wholesalePrice: data.wholesalePrice.present
          ? data.wholesalePrice.value
          : this.wholesalePrice,
      memberDiscount: data.memberDiscount.present
          ? data.memberDiscount.value
          : this.memberDiscount,
      purchaseSaleMode: data.purchaseSaleMode.present
          ? data.purchaseSaleMode.value
          : this.purchaseSaleMode,
      bookmark: data.bookmark.present ? data.bookmark.value : this.bookmark,
      packaging: data.packaging.present ? data.packaging.value : this.packaging,
      properity: data.properity.present ? data.properity.value : this.properity,
      statisticalClass: data.statisticalClass.present
          ? data.statisticalClass.value
          : this.statisticalClass,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('isbn: $isbn, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('publisher: $publisher, ')
          ..write('productId: $productId, ')
          ..write('internalPricing: $internalPricing, ')
          ..write('selfEncoding: $selfEncoding, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('publicationYear: $publicationYear, ')
          ..write('retailDiscount: $retailDiscount, ')
          ..write('wholesaleDiscount: $wholesaleDiscount, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('memberDiscount: $memberDiscount, ')
          ..write('purchaseSaleMode: $purchaseSaleMode, ')
          ..write('bookmark: $bookmark, ')
          ..write('packaging: $packaging, ')
          ..write('properity: $properity, ')
          ..write('statisticalClass: $statisticalClass, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    title,
    author,
    isbn,
    category,
    price,
    publisher,
    productId,
    internalPricing,
    selfEncoding,
    purchasePrice,
    publicationYear,
    retailDiscount,
    wholesaleDiscount,
    wholesalePrice,
    memberDiscount,
    purchaseSaleMode,
    bookmark,
    packaging,
    properity,
    statisticalClass,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.isbn == this.isbn &&
          other.category == this.category &&
          other.price == this.price &&
          other.publisher == this.publisher &&
          other.productId == this.productId &&
          other.internalPricing == this.internalPricing &&
          other.selfEncoding == this.selfEncoding &&
          other.purchasePrice == this.purchasePrice &&
          other.publicationYear == this.publicationYear &&
          other.retailDiscount == this.retailDiscount &&
          other.wholesaleDiscount == this.wholesaleDiscount &&
          other.wholesalePrice == this.wholesalePrice &&
          other.memberDiscount == this.memberDiscount &&
          other.purchaseSaleMode == this.purchaseSaleMode &&
          other.bookmark == this.bookmark &&
          other.packaging == this.packaging &&
          other.properity == this.properity &&
          other.statisticalClass == this.statisticalClass &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String?> isbn;
  final Value<String?> category;
  final Value<double> price;
  final Value<String?> publisher;
  final Value<String> productId;
  final Value<double?> internalPricing;
  final Value<String> selfEncoding;
  final Value<double?> purchasePrice;
  final Value<int?> publicationYear;
  final Value<double?> retailDiscount;
  final Value<double?> wholesaleDiscount;
  final Value<double?> wholesalePrice;
  final Value<double?> memberDiscount;
  final Value<String?> purchaseSaleMode;
  final Value<String?> bookmark;
  final Value<String?> packaging;
  final Value<String?> properity;
  final Value<String?> statisticalClass;
  final Value<int?> createdBy;
  final Value<int?> updatedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.isbn = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.publisher = const Value.absent(),
    this.productId = const Value.absent(),
    this.internalPricing = const Value.absent(),
    this.selfEncoding = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.publicationYear = const Value.absent(),
    this.retailDiscount = const Value.absent(),
    this.wholesaleDiscount = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.memberDiscount = const Value.absent(),
    this.purchaseSaleMode = const Value.absent(),
    this.bookmark = const Value.absent(),
    this.packaging = const Value.absent(),
    this.properity = const Value.absent(),
    this.statisticalClass = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String author,
    this.isbn = const Value.absent(),
    this.category = const Value.absent(),
    required double price,
    this.publisher = const Value.absent(),
    required String productId,
    this.internalPricing = const Value.absent(),
    required String selfEncoding,
    this.purchasePrice = const Value.absent(),
    this.publicationYear = const Value.absent(),
    this.retailDiscount = const Value.absent(),
    this.wholesaleDiscount = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.memberDiscount = const Value.absent(),
    this.purchaseSaleMode = const Value.absent(),
    this.bookmark = const Value.absent(),
    this.packaging = const Value.absent(),
    this.properity = const Value.absent(),
    this.statisticalClass = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       author = Value(author),
       price = Value(price),
       productId = Value(productId),
       selfEncoding = Value(selfEncoding);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? isbn,
    Expression<String>? category,
    Expression<int>? price,
    Expression<String>? publisher,
    Expression<String>? productId,
    Expression<int>? internalPricing,
    Expression<String>? selfEncoding,
    Expression<int>? purchasePrice,
    Expression<int>? publicationYear,
    Expression<int>? retailDiscount,
    Expression<int>? wholesaleDiscount,
    Expression<int>? wholesalePrice,
    Expression<int>? memberDiscount,
    Expression<String>? purchaseSaleMode,
    Expression<String>? bookmark,
    Expression<String>? packaging,
    Expression<String>? properity,
    Expression<String>? statisticalClass,
    Expression<int>? createdBy,
    Expression<int>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (isbn != null) 'isbn': isbn,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (publisher != null) 'publisher': publisher,
      if (productId != null) 'product_id': productId,
      if (internalPricing != null) 'internal_pricing': internalPricing,
      if (selfEncoding != null) 'self_encoding': selfEncoding,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (publicationYear != null) 'publication_year': publicationYear,
      if (retailDiscount != null) 'retail_discount': retailDiscount,
      if (wholesaleDiscount != null) 'wholesale_discount': wholesaleDiscount,
      if (wholesalePrice != null) 'wholesale_price': wholesalePrice,
      if (memberDiscount != null) 'member_discount': memberDiscount,
      if (purchaseSaleMode != null) 'purchase_sale_mode': purchaseSaleMode,
      if (bookmark != null) 'bookmark': bookmark,
      if (packaging != null) 'packaging': packaging,
      if (properity != null) 'properity': properity,
      if (statisticalClass != null) 'statistical_class': statisticalClass,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? author,
    Value<String?>? isbn,
    Value<String?>? category,
    Value<double>? price,
    Value<String?>? publisher,
    Value<String>? productId,
    Value<double?>? internalPricing,
    Value<String>? selfEncoding,
    Value<double?>? purchasePrice,
    Value<int?>? publicationYear,
    Value<double?>? retailDiscount,
    Value<double?>? wholesaleDiscount,
    Value<double?>? wholesalePrice,
    Value<double?>? memberDiscount,
    Value<String?>? purchaseSaleMode,
    Value<String?>? bookmark,
    Value<String?>? packaging,
    Value<String?>? properity,
    Value<String?>? statisticalClass,
    Value<int?>? createdBy,
    Value<int?>? updatedBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      isbn: isbn ?? this.isbn,
      category: category ?? this.category,
      price: price ?? this.price,
      publisher: publisher ?? this.publisher,
      productId: productId ?? this.productId,
      internalPricing: internalPricing ?? this.internalPricing,
      selfEncoding: selfEncoding ?? this.selfEncoding,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      publicationYear: publicationYear ?? this.publicationYear,
      retailDiscount: retailDiscount ?? this.retailDiscount,
      wholesaleDiscount: wholesaleDiscount ?? this.wholesaleDiscount,
      wholesalePrice: wholesalePrice ?? this.wholesalePrice,
      memberDiscount: memberDiscount ?? this.memberDiscount,
      purchaseSaleMode: purchaseSaleMode ?? this.purchaseSaleMode,
      bookmark: bookmark ?? this.bookmark,
      packaging: packaging ?? this.packaging,
      properity: properity ?? this.properity,
      statisticalClass: statisticalClass ?? this.statisticalClass,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (isbn.present) {
      map['isbn'] = Variable<String>(isbn.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(
        $ProductsTable.$converterprice.toSql(price.value),
      );
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (internalPricing.present) {
      map['internal_pricing'] = Variable<int>(
        $ProductsTable.$converterinternalPricing.toSql(internalPricing.value),
      );
    }
    if (selfEncoding.present) {
      map['self_encoding'] = Variable<String>(selfEncoding.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<int>(
        $ProductsTable.$converterpurchasePrice.toSql(purchasePrice.value),
      );
    }
    if (publicationYear.present) {
      map['publication_year'] = Variable<int>(publicationYear.value);
    }
    if (retailDiscount.present) {
      map['retail_discount'] = Variable<int>(
        $ProductsTable.$converterretailDiscount.toSql(retailDiscount.value),
      );
    }
    if (wholesaleDiscount.present) {
      map['wholesale_discount'] = Variable<int>(
        $ProductsTable.$converterwholesaleDiscount.toSql(
          wholesaleDiscount.value,
        ),
      );
    }
    if (wholesalePrice.present) {
      map['wholesale_price'] = Variable<int>(
        $ProductsTable.$converterwholesalePrice.toSql(wholesalePrice.value),
      );
    }
    if (memberDiscount.present) {
      map['member_discount'] = Variable<int>(
        $ProductsTable.$convertermemberDiscount.toSql(memberDiscount.value),
      );
    }
    if (purchaseSaleMode.present) {
      map['purchase_sale_mode'] = Variable<String>(purchaseSaleMode.value);
    }
    if (bookmark.present) {
      map['bookmark'] = Variable<String>(bookmark.value);
    }
    if (packaging.present) {
      map['packaging'] = Variable<String>(packaging.value);
    }
    if (properity.present) {
      map['properity'] = Variable<String>(properity.value);
    }
    if (statisticalClass.present) {
      map['statistical_class'] = Variable<String>(statisticalClass.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<int>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<int>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('isbn: $isbn, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('publisher: $publisher, ')
          ..write('productId: $productId, ')
          ..write('internalPricing: $internalPricing, ')
          ..write('selfEncoding: $selfEncoding, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('publicationYear: $publicationYear, ')
          ..write('retailDiscount: $retailDiscount, ')
          ..write('wholesaleDiscount: $wholesaleDiscount, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('memberDiscount: $memberDiscount, ')
          ..write('purchaseSaleMode: $purchaseSaleMode, ')
          ..write('bookmark: $bookmark, ')
          ..write('packaging: $packaging, ')
          ..write('properity: $properity, ')
          ..write('statisticalClass: $statisticalClass, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ProductCategoriesTable extends ProductCategories
    with TableInfo<$ProductCategoriesTable, ProductCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_categories (id) ON UPDATE CASCADE ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parentId,
    code,
    name,
    sortOrder,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_id'],
      ),
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductCategoriesTable createAlias(String alias) {
    return $ProductCategoriesTable(attachedDatabase, alias);
  }
}

class ProductCategory extends DataClass implements Insertable<ProductCategory> {
  final int id;
  final int? parentId;
  final String code;
  final String name;
  final int sortOrder;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProductCategory({
    required this.id,
    this.parentId,
    required this.code,
    required this.name,
    required this.sortOrder,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['status'] = Variable<int>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ProductCategoriesCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      code: Value(code),
      name: Value(name),
      sortOrder: Value(sortOrder),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProductCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductCategory(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProductCategory copyWith({
    int? id,
    Value<int?> parentId = const Value.absent(),
    String? code,
    String? name,
    int? sortOrder,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ProductCategory(
    id: id ?? this.id,
    parentId: parentId.present ? parentId.value : this.parentId,
    code: code ?? this.code,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProductCategory copyWithCompanion(ProductCategoriesCompanion data) {
    return ProductCategory(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategory(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    parentId,
    code,
    name,
    sortOrder,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCategory &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.code == this.code &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductCategoriesCompanion extends UpdateCompanion<ProductCategory> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> code;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProductCategoriesCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductCategoriesCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String code,
    required String name,
    this.sortOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : code = Value(code),
       name = Value(name);
  static Insertable<ProductCategory> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductCategoriesCompanion copyWith({
    Value<int>? id,
    Value<int?>? parentId,
    Value<String>? code,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<int>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ProductCategoriesCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      code: code ?? this.code,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PublishersTable extends Publishers
    with TableInfo<$PublishersTable, Publisher> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PublishersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    contactName,
    phone,
    address,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'publishers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Publisher> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Publisher map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Publisher(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PublishersTable createAlias(String alias) {
    return $PublishersTable(attachedDatabase, alias);
  }
}

class Publisher extends DataClass implements Insertable<Publisher> {
  final int id;
  final String? code;
  final String name;
  final String? contactName;
  final String? phone;
  final String? address;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Publisher({
    required this.id,
    this.code,
    required this.name,
    this.contactName,
    this.phone,
    this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['status'] = Variable<int>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PublishersCompanion toCompanion(bool nullToAbsent) {
    return PublishersCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      name: Value(name),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Publisher.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Publisher(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String?>(code),
      'name': serializer.toJson<String>(name),
      'contactName': serializer.toJson<String?>(contactName),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Publisher copyWith({
    int? id,
    Value<String?> code = const Value.absent(),
    String? name,
    Value<String?> contactName = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Publisher(
    id: id ?? this.id,
    code: code.present ? code.value : this.code,
    name: name ?? this.name,
    contactName: contactName.present ? contactName.value : this.contactName,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Publisher copyWithCompanion(PublishersCompanion data) {
    return Publisher(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Publisher(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    contactName,
    phone,
    address,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Publisher &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.contactName == this.contactName &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PublishersCompanion extends UpdateCompanion<Publisher> {
  final Value<int> id;
  final Value<String?> code;
  final Value<String> name;
  final Value<String?> contactName;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PublishersCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.contactName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PublishersCompanion.insert({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    required String name,
    this.contactName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Publisher> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? contactName,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (contactName != null) 'contact_name': contactName,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PublishersCompanion copyWith({
    Value<int>? id,
    Value<String?>? code,
    Value<String>? name,
    Value<String?>? contactName,
    Value<String?>? phone,
    Value<String?>? address,
    Value<int>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PublishersCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PublishersCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _settlementTermMeta = const VerificationMeta(
    'settlementTerm',
  );
  @override
  late final GeneratedColumn<String> settlementTerm = GeneratedColumn<String>(
    'settlement_term',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    contactName,
    phone,
    address,
    settlementTerm,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('settlement_term')) {
      context.handle(
        _settlementTermMeta,
        settlementTerm.isAcceptableOrUnknown(
          data['settlement_term']!,
          _settlementTermMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      settlementTerm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}settlement_term'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final int id;
  final String code;
  final String name;
  final String? contactName;
  final String? phone;
  final String? address;
  final String? settlementTerm;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Supplier({
    required this.id,
    required this.code,
    required this.name,
    this.contactName,
    this.phone,
    this.address,
    this.settlementTerm,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || settlementTerm != null) {
      map['settlement_term'] = Variable<String>(settlementTerm);
    }
    map['status'] = Variable<int>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      settlementTerm: settlementTerm == null && nullToAbsent
          ? const Value.absent()
          : Value(settlementTerm),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Supplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      settlementTerm: serializer.fromJson<String?>(json['settlementTerm']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'contactName': serializer.toJson<String?>(contactName),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'settlementTerm': serializer.toJson<String?>(settlementTerm),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Supplier copyWith({
    int? id,
    String? code,
    String? name,
    Value<String?> contactName = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> settlementTerm = const Value.absent(),
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Supplier(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    contactName: contactName.present ? contactName.value : this.contactName,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    settlementTerm: settlementTerm.present
        ? settlementTerm.value
        : this.settlementTerm,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      settlementTerm: data.settlementTerm.present
          ? data.settlementTerm.value
          : this.settlementTerm,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('settlementTerm: $settlementTerm, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    contactName,
    phone,
    address,
    settlementTerm,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.contactName == this.contactName &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.settlementTerm == this.settlementTerm &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String?> contactName;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> settlementTerm;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.contactName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.settlementTerm = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.contactName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.settlementTerm = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : code = Value(code),
       name = Value(name);
  static Insertable<Supplier> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? contactName,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? settlementTerm,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (contactName != null) 'contact_name': contactName,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (settlementTerm != null) 'settlement_term': settlementTerm,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SuppliersCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<String?>? contactName,
    Value<String?>? phone,
    Value<String?>? address,
    Value<String?>? settlementTerm,
    Value<int>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      settlementTerm: settlementTerm ?? this.settlementTerm,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (settlementTerm.present) {
      map['settlement_term'] = Variable<String>(settlementTerm.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('settlementTerm: $settlementTerm, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerTypeMeta = const VerificationMeta(
    'customerType',
  );
  @override
  late final GeneratedColumn<String> customerType = GeneratedColumn<String>(
    'customer_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('retail'),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _memberLevelMeta = const VerificationMeta(
    'memberLevel',
  );
  @override
  late final GeneratedColumn<String> memberLevel = GeneratedColumn<String>(
    'member_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    customerType,
    phone,
    email,
    address,
    memberLevel,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('customer_type')) {
      context.handle(
        _customerTypeMeta,
        customerType.isAcceptableOrUnknown(
          data['customer_type']!,
          _customerTypeMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('member_level')) {
      context.handle(
        _memberLevelMeta,
        memberLevel.isAcceptableOrUnknown(
          data['member_level']!,
          _memberLevelMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      customerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_type'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      memberLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_level'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String code;
  final String name;
  final String customerType;
  final String? phone;
  final String? email;
  final String? address;
  final String? memberLevel;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Customer({
    required this.id,
    required this.code,
    required this.name,
    required this.customerType,
    this.phone,
    this.email,
    this.address,
    this.memberLevel,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['customer_type'] = Variable<String>(customerType);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || memberLevel != null) {
      map['member_level'] = Variable<String>(memberLevel);
    }
    map['status'] = Variable<int>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      customerType: Value(customerType),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      memberLevel: memberLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(memberLevel),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      customerType: serializer.fromJson<String>(json['customerType']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      memberLevel: serializer.fromJson<String?>(json['memberLevel']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'customerType': serializer.toJson<String>(customerType),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'memberLevel': serializer.toJson<String?>(memberLevel),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Customer copyWith({
    int? id,
    String? code,
    String? name,
    String? customerType,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> memberLevel = const Value.absent(),
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Customer(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    customerType: customerType ?? this.customerType,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    memberLevel: memberLevel.present ? memberLevel.value : this.memberLevel,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      customerType: data.customerType.present
          ? data.customerType.value
          : this.customerType,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      memberLevel: data.memberLevel.present
          ? data.memberLevel.value
          : this.memberLevel,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('customerType: $customerType, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('memberLevel: $memberLevel, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    customerType,
    phone,
    email,
    address,
    memberLevel,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.customerType == this.customerType &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.memberLevel == this.memberLevel &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String> customerType;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> memberLevel;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.customerType = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.memberLevel = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.customerType = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.memberLevel = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : code = Value(code),
       name = Value(name);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? customerType,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? memberLevel,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (customerType != null) 'customer_type': customerType,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (memberLevel != null) 'member_level': memberLevel,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<String>? customerType,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<String?>? memberLevel,
    Value<int>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      customerType: customerType ?? this.customerType,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      memberLevel: memberLevel ?? this.memberLevel,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (customerType.present) {
      map['customer_type'] = Variable<String>(customerType.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (memberLevel.present) {
      map['member_level'] = Variable<String>(memberLevel.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('customerType: $customerType, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('memberLevel: $memberLevel, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WarehousesTable extends Warehouses
    with TableInfo<$WarehousesTable, Warehouse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WarehousesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _managerUserIdMeta = const VerificationMeta(
    'managerUserId',
  );
  @override
  late final GeneratedColumn<int> managerUserId = GeneratedColumn<int>(
    'manager_user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON UPDATE CASCADE ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    address,
    managerUserId,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'warehouses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Warehouse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('manager_user_id')) {
      context.handle(
        _managerUserIdMeta,
        managerUserId.isAcceptableOrUnknown(
          data['manager_user_id']!,
          _managerUserIdMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Warehouse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Warehouse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      managerUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}manager_user_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WarehousesTable createAlias(String alias) {
    return $WarehousesTable(attachedDatabase, alias);
  }
}

class Warehouse extends DataClass implements Insertable<Warehouse> {
  final int id;
  final String code;
  final String name;
  final String? address;
  final int? managerUserId;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Warehouse({
    required this.id,
    required this.code,
    required this.name,
    this.address,
    this.managerUserId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || managerUserId != null) {
      map['manager_user_id'] = Variable<int>(managerUserId);
    }
    map['status'] = Variable<int>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WarehousesCompanion toCompanion(bool nullToAbsent) {
    return WarehousesCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      managerUserId: managerUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(managerUserId),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Warehouse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Warehouse(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      managerUserId: serializer.fromJson<int?>(json['managerUserId']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'managerUserId': serializer.toJson<int?>(managerUserId),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Warehouse copyWith({
    int? id,
    String? code,
    String? name,
    Value<String?> address = const Value.absent(),
    Value<int?> managerUserId = const Value.absent(),
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Warehouse(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    managerUserId: managerUserId.present
        ? managerUserId.value
        : this.managerUserId,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Warehouse copyWithCompanion(WarehousesCompanion data) {
    return Warehouse(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      managerUserId: data.managerUserId.present
          ? data.managerUserId.value
          : this.managerUserId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Warehouse(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('managerUserId: $managerUserId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    address,
    managerUserId,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Warehouse &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.address == this.address &&
          other.managerUserId == this.managerUserId &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WarehousesCompanion extends UpdateCompanion<Warehouse> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String?> address;
  final Value<int?> managerUserId;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WarehousesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.managerUserId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WarehousesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.address = const Value.absent(),
    this.managerUserId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : code = Value(code),
       name = Value(name);
  static Insertable<Warehouse> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? address,
    Expression<int>? managerUserId,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (managerUserId != null) 'manager_user_id': managerUserId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WarehousesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<String?>? address,
    Value<int?>? managerUserId,
    Value<int>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return WarehousesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      address: address ?? this.address,
      managerUserId: managerUserId ?? this.managerUserId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (managerUserId.present) {
      map['manager_user_id'] = Variable<int>(managerUserId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WarehousesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('managerUserId: $managerUserId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StockBalancesTable extends StockBalances
    with TableInfo<$StockBalancesTable, StockBalance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockBalancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _warehouseIdMeta = const VerificationMeta(
    'warehouseId',
  );
  @override
  late final GeneratedColumn<int> warehouseId = GeneratedColumn<int>(
    'warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES warehouses (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _onHandQtyMeta = const VerificationMeta(
    'onHandQty',
  );
  @override
  late final GeneratedColumn<int> onHandQty = GeneratedColumn<int>(
    'on_hand_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reservedQtyMeta = const VerificationMeta(
    'reservedQty',
  );
  @override
  late final GeneratedColumn<int> reservedQty = GeneratedColumn<int>(
    'reserved_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _safetyStockQtyMeta = const VerificationMeta(
    'safetyStockQty',
  );
  @override
  late final GeneratedColumn<int> safetyStockQty = GeneratedColumn<int>(
    'safety_stock_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _shelfCodeMeta = const VerificationMeta(
    'shelfCode',
  );
  @override
  late final GeneratedColumn<String> shelfCode = GeneratedColumn<String>(
    'shelf_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    warehouseId,
    productId,
    onHandQty,
    reservedQty,
    safetyStockQty,
    shelfCode,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_balances';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockBalance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
        _warehouseIdMeta,
        warehouseId.isAcceptableOrUnknown(
          data['warehouse_id']!,
          _warehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('on_hand_qty')) {
      context.handle(
        _onHandQtyMeta,
        onHandQty.isAcceptableOrUnknown(data['on_hand_qty']!, _onHandQtyMeta),
      );
    }
    if (data.containsKey('reserved_qty')) {
      context.handle(
        _reservedQtyMeta,
        reservedQty.isAcceptableOrUnknown(
          data['reserved_qty']!,
          _reservedQtyMeta,
        ),
      );
    }
    if (data.containsKey('safety_stock_qty')) {
      context.handle(
        _safetyStockQtyMeta,
        safetyStockQty.isAcceptableOrUnknown(
          data['safety_stock_qty']!,
          _safetyStockQtyMeta,
        ),
      );
    }
    if (data.containsKey('shelf_code')) {
      context.handle(
        _shelfCodeMeta,
        shelfCode.isAcceptableOrUnknown(data['shelf_code']!, _shelfCodeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockBalance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockBalance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      warehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}warehouse_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      onHandQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}on_hand_qty'],
      )!,
      reservedQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reserved_qty'],
      )!,
      safetyStockQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}safety_stock_qty'],
      )!,
      shelfCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shelf_code'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StockBalancesTable createAlias(String alias) {
    return $StockBalancesTable(attachedDatabase, alias);
  }
}

class StockBalance extends DataClass implements Insertable<StockBalance> {
  final int id;
  final int warehouseId;
  final int productId;
  final int onHandQty;
  final int reservedQty;
  final int safetyStockQty;
  final String? shelfCode;
  final DateTime updatedAt;
  const StockBalance({
    required this.id,
    required this.warehouseId,
    required this.productId,
    required this.onHandQty,
    required this.reservedQty,
    required this.safetyStockQty,
    this.shelfCode,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['warehouse_id'] = Variable<int>(warehouseId);
    map['product_id'] = Variable<int>(productId);
    map['on_hand_qty'] = Variable<int>(onHandQty);
    map['reserved_qty'] = Variable<int>(reservedQty);
    map['safety_stock_qty'] = Variable<int>(safetyStockQty);
    if (!nullToAbsent || shelfCode != null) {
      map['shelf_code'] = Variable<String>(shelfCode);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StockBalancesCompanion toCompanion(bool nullToAbsent) {
    return StockBalancesCompanion(
      id: Value(id),
      warehouseId: Value(warehouseId),
      productId: Value(productId),
      onHandQty: Value(onHandQty),
      reservedQty: Value(reservedQty),
      safetyStockQty: Value(safetyStockQty),
      shelfCode: shelfCode == null && nullToAbsent
          ? const Value.absent()
          : Value(shelfCode),
      updatedAt: Value(updatedAt),
    );
  }

  factory StockBalance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockBalance(
      id: serializer.fromJson<int>(json['id']),
      warehouseId: serializer.fromJson<int>(json['warehouseId']),
      productId: serializer.fromJson<int>(json['productId']),
      onHandQty: serializer.fromJson<int>(json['onHandQty']),
      reservedQty: serializer.fromJson<int>(json['reservedQty']),
      safetyStockQty: serializer.fromJson<int>(json['safetyStockQty']),
      shelfCode: serializer.fromJson<String?>(json['shelfCode']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'warehouseId': serializer.toJson<int>(warehouseId),
      'productId': serializer.toJson<int>(productId),
      'onHandQty': serializer.toJson<int>(onHandQty),
      'reservedQty': serializer.toJson<int>(reservedQty),
      'safetyStockQty': serializer.toJson<int>(safetyStockQty),
      'shelfCode': serializer.toJson<String?>(shelfCode),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StockBalance copyWith({
    int? id,
    int? warehouseId,
    int? productId,
    int? onHandQty,
    int? reservedQty,
    int? safetyStockQty,
    Value<String?> shelfCode = const Value.absent(),
    DateTime? updatedAt,
  }) => StockBalance(
    id: id ?? this.id,
    warehouseId: warehouseId ?? this.warehouseId,
    productId: productId ?? this.productId,
    onHandQty: onHandQty ?? this.onHandQty,
    reservedQty: reservedQty ?? this.reservedQty,
    safetyStockQty: safetyStockQty ?? this.safetyStockQty,
    shelfCode: shelfCode.present ? shelfCode.value : this.shelfCode,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StockBalance copyWithCompanion(StockBalancesCompanion data) {
    return StockBalance(
      id: data.id.present ? data.id.value : this.id,
      warehouseId: data.warehouseId.present
          ? data.warehouseId.value
          : this.warehouseId,
      productId: data.productId.present ? data.productId.value : this.productId,
      onHandQty: data.onHandQty.present ? data.onHandQty.value : this.onHandQty,
      reservedQty: data.reservedQty.present
          ? data.reservedQty.value
          : this.reservedQty,
      safetyStockQty: data.safetyStockQty.present
          ? data.safetyStockQty.value
          : this.safetyStockQty,
      shelfCode: data.shelfCode.present ? data.shelfCode.value : this.shelfCode,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockBalance(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('productId: $productId, ')
          ..write('onHandQty: $onHandQty, ')
          ..write('reservedQty: $reservedQty, ')
          ..write('safetyStockQty: $safetyStockQty, ')
          ..write('shelfCode: $shelfCode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    warehouseId,
    productId,
    onHandQty,
    reservedQty,
    safetyStockQty,
    shelfCode,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockBalance &&
          other.id == this.id &&
          other.warehouseId == this.warehouseId &&
          other.productId == this.productId &&
          other.onHandQty == this.onHandQty &&
          other.reservedQty == this.reservedQty &&
          other.safetyStockQty == this.safetyStockQty &&
          other.shelfCode == this.shelfCode &&
          other.updatedAt == this.updatedAt);
}

class StockBalancesCompanion extends UpdateCompanion<StockBalance> {
  final Value<int> id;
  final Value<int> warehouseId;
  final Value<int> productId;
  final Value<int> onHandQty;
  final Value<int> reservedQty;
  final Value<int> safetyStockQty;
  final Value<String?> shelfCode;
  final Value<DateTime> updatedAt;
  const StockBalancesCompanion({
    this.id = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.productId = const Value.absent(),
    this.onHandQty = const Value.absent(),
    this.reservedQty = const Value.absent(),
    this.safetyStockQty = const Value.absent(),
    this.shelfCode = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StockBalancesCompanion.insert({
    this.id = const Value.absent(),
    required int warehouseId,
    required int productId,
    this.onHandQty = const Value.absent(),
    this.reservedQty = const Value.absent(),
    this.safetyStockQty = const Value.absent(),
    this.shelfCode = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : warehouseId = Value(warehouseId),
       productId = Value(productId);
  static Insertable<StockBalance> custom({
    Expression<int>? id,
    Expression<int>? warehouseId,
    Expression<int>? productId,
    Expression<int>? onHandQty,
    Expression<int>? reservedQty,
    Expression<int>? safetyStockQty,
    Expression<String>? shelfCode,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (productId != null) 'product_id': productId,
      if (onHandQty != null) 'on_hand_qty': onHandQty,
      if (reservedQty != null) 'reserved_qty': reservedQty,
      if (safetyStockQty != null) 'safety_stock_qty': safetyStockQty,
      if (shelfCode != null) 'shelf_code': shelfCode,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StockBalancesCompanion copyWith({
    Value<int>? id,
    Value<int>? warehouseId,
    Value<int>? productId,
    Value<int>? onHandQty,
    Value<int>? reservedQty,
    Value<int>? safetyStockQty,
    Value<String?>? shelfCode,
    Value<DateTime>? updatedAt,
  }) {
    return StockBalancesCompanion(
      id: id ?? this.id,
      warehouseId: warehouseId ?? this.warehouseId,
      productId: productId ?? this.productId,
      onHandQty: onHandQty ?? this.onHandQty,
      reservedQty: reservedQty ?? this.reservedQty,
      safetyStockQty: safetyStockQty ?? this.safetyStockQty,
      shelfCode: shelfCode ?? this.shelfCode,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<int>(warehouseId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (onHandQty.present) {
      map['on_hand_qty'] = Variable<int>(onHandQty.value);
    }
    if (reservedQty.present) {
      map['reserved_qty'] = Variable<int>(reservedQty.value);
    }
    if (safetyStockQty.present) {
      map['safety_stock_qty'] = Variable<int>(safetyStockQty.value);
    }
    if (shelfCode.present) {
      map['shelf_code'] = Variable<String>(shelfCode.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockBalancesCompanion(')
          ..write('id: $id, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('productId: $productId, ')
          ..write('onHandQty: $onHandQty, ')
          ..write('reservedQty: $reservedQty, ')
          ..write('safetyStockQty: $safetyStockQty, ')
          ..write('shelfCode: $shelfCode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements
    with TableInfo<$StockMovementsTable, StockMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _movementNoMeta = const VerificationMeta(
    'movementNo',
  );
  @override
  late final GeneratedColumn<String> movementNo = GeneratedColumn<String>(
    'movement_no',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _movementTypeMeta = const VerificationMeta(
    'movementType',
  );
  @override
  late final GeneratedColumn<String> movementType = GeneratedColumn<String>(
    'movement_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refTypeMeta = const VerificationMeta(
    'refType',
  );
  @override
  late final GeneratedColumn<String> refType = GeneratedColumn<String>(
    'ref_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refIdMeta = const VerificationMeta('refId');
  @override
  late final GeneratedColumn<int> refId = GeneratedColumn<int>(
    'ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warehouseIdMeta = const VerificationMeta(
    'warehouseId',
  );
  @override
  late final GeneratedColumn<int> warehouseId = GeneratedColumn<int>(
    'warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES warehouses (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _qtyDeltaMeta = const VerificationMeta(
    'qtyDelta',
  );
  @override
  late final GeneratedColumn<int> qtyDelta = GeneratedColumn<int>(
    'qty_delta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostCentMeta = const VerificationMeta(
    'unitCostCent',
  );
  @override
  late final GeneratedColumn<int> unitCostCent = GeneratedColumn<int>(
    'unit_cost_cent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountCentMeta = const VerificationMeta(
    'amountCent',
  );
  @override
  late final GeneratedColumn<int> amountCent = GeneratedColumn<int>(
    'amount_cent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operatorUserIdMeta = const VerificationMeta(
    'operatorUserId',
  );
  @override
  late final GeneratedColumn<int> operatorUserId = GeneratedColumn<int>(
    'operator_user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON UPDATE CASCADE ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    movementNo,
    movementType,
    refType,
    refId,
    warehouseId,
    productId,
    qtyDelta,
    unitCostCent,
    amountCent,
    occurredAt,
    operatorUserId,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('movement_no')) {
      context.handle(
        _movementNoMeta,
        movementNo.isAcceptableOrUnknown(data['movement_no']!, _movementNoMeta),
      );
    } else if (isInserting) {
      context.missing(_movementNoMeta);
    }
    if (data.containsKey('movement_type')) {
      context.handle(
        _movementTypeMeta,
        movementType.isAcceptableOrUnknown(
          data['movement_type']!,
          _movementTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_movementTypeMeta);
    }
    if (data.containsKey('ref_type')) {
      context.handle(
        _refTypeMeta,
        refType.isAcceptableOrUnknown(data['ref_type']!, _refTypeMeta),
      );
    }
    if (data.containsKey('ref_id')) {
      context.handle(
        _refIdMeta,
        refId.isAcceptableOrUnknown(data['ref_id']!, _refIdMeta),
      );
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
        _warehouseIdMeta,
        warehouseId.isAcceptableOrUnknown(
          data['warehouse_id']!,
          _warehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty_delta')) {
      context.handle(
        _qtyDeltaMeta,
        qtyDelta.isAcceptableOrUnknown(data['qty_delta']!, _qtyDeltaMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyDeltaMeta);
    }
    if (data.containsKey('unit_cost_cent')) {
      context.handle(
        _unitCostCentMeta,
        unitCostCent.isAcceptableOrUnknown(
          data['unit_cost_cent']!,
          _unitCostCentMeta,
        ),
      );
    }
    if (data.containsKey('amount_cent')) {
      context.handle(
        _amountCentMeta,
        amountCent.isAcceptableOrUnknown(data['amount_cent']!, _amountCentMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('operator_user_id')) {
      context.handle(
        _operatorUserIdMeta,
        operatorUserId.isAcceptableOrUnknown(
          data['operator_user_id']!,
          _operatorUserIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      movementNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}movement_no'],
      )!,
      movementType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}movement_type'],
      )!,
      refType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_type'],
      ),
      refId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ref_id'],
      ),
      warehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}warehouse_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      qtyDelta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty_delta'],
      )!,
      unitCostCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_cost_cent'],
      ),
      amountCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cent'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      operatorUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}operator_user_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovement extends DataClass implements Insertable<StockMovement> {
  final int id;
  final String movementNo;
  final String movementType;
  final String? refType;
  final int? refId;
  final int warehouseId;
  final int productId;
  final int qtyDelta;
  final int? unitCostCent;
  final int? amountCent;
  final DateTime occurredAt;
  final int? operatorUserId;
  final String? note;
  final DateTime createdAt;
  const StockMovement({
    required this.id,
    required this.movementNo,
    required this.movementType,
    this.refType,
    this.refId,
    required this.warehouseId,
    required this.productId,
    required this.qtyDelta,
    this.unitCostCent,
    this.amountCent,
    required this.occurredAt,
    this.operatorUserId,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['movement_no'] = Variable<String>(movementNo);
    map['movement_type'] = Variable<String>(movementType);
    if (!nullToAbsent || refType != null) {
      map['ref_type'] = Variable<String>(refType);
    }
    if (!nullToAbsent || refId != null) {
      map['ref_id'] = Variable<int>(refId);
    }
    map['warehouse_id'] = Variable<int>(warehouseId);
    map['product_id'] = Variable<int>(productId);
    map['qty_delta'] = Variable<int>(qtyDelta);
    if (!nullToAbsent || unitCostCent != null) {
      map['unit_cost_cent'] = Variable<int>(unitCostCent);
    }
    if (!nullToAbsent || amountCent != null) {
      map['amount_cent'] = Variable<int>(amountCent);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || operatorUserId != null) {
      map['operator_user_id'] = Variable<int>(operatorUserId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      id: Value(id),
      movementNo: Value(movementNo),
      movementType: Value(movementType),
      refType: refType == null && nullToAbsent
          ? const Value.absent()
          : Value(refType),
      refId: refId == null && nullToAbsent
          ? const Value.absent()
          : Value(refId),
      warehouseId: Value(warehouseId),
      productId: Value(productId),
      qtyDelta: Value(qtyDelta),
      unitCostCent: unitCostCent == null && nullToAbsent
          ? const Value.absent()
          : Value(unitCostCent),
      amountCent: amountCent == null && nullToAbsent
          ? const Value.absent()
          : Value(amountCent),
      occurredAt: Value(occurredAt),
      operatorUserId: operatorUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(operatorUserId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory StockMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovement(
      id: serializer.fromJson<int>(json['id']),
      movementNo: serializer.fromJson<String>(json['movementNo']),
      movementType: serializer.fromJson<String>(json['movementType']),
      refType: serializer.fromJson<String?>(json['refType']),
      refId: serializer.fromJson<int?>(json['refId']),
      warehouseId: serializer.fromJson<int>(json['warehouseId']),
      productId: serializer.fromJson<int>(json['productId']),
      qtyDelta: serializer.fromJson<int>(json['qtyDelta']),
      unitCostCent: serializer.fromJson<int?>(json['unitCostCent']),
      amountCent: serializer.fromJson<int?>(json['amountCent']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      operatorUserId: serializer.fromJson<int?>(json['operatorUserId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'movementNo': serializer.toJson<String>(movementNo),
      'movementType': serializer.toJson<String>(movementType),
      'refType': serializer.toJson<String?>(refType),
      'refId': serializer.toJson<int?>(refId),
      'warehouseId': serializer.toJson<int>(warehouseId),
      'productId': serializer.toJson<int>(productId),
      'qtyDelta': serializer.toJson<int>(qtyDelta),
      'unitCostCent': serializer.toJson<int?>(unitCostCent),
      'amountCent': serializer.toJson<int?>(amountCent),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'operatorUserId': serializer.toJson<int?>(operatorUserId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockMovement copyWith({
    int? id,
    String? movementNo,
    String? movementType,
    Value<String?> refType = const Value.absent(),
    Value<int?> refId = const Value.absent(),
    int? warehouseId,
    int? productId,
    int? qtyDelta,
    Value<int?> unitCostCent = const Value.absent(),
    Value<int?> amountCent = const Value.absent(),
    DateTime? occurredAt,
    Value<int?> operatorUserId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => StockMovement(
    id: id ?? this.id,
    movementNo: movementNo ?? this.movementNo,
    movementType: movementType ?? this.movementType,
    refType: refType.present ? refType.value : this.refType,
    refId: refId.present ? refId.value : this.refId,
    warehouseId: warehouseId ?? this.warehouseId,
    productId: productId ?? this.productId,
    qtyDelta: qtyDelta ?? this.qtyDelta,
    unitCostCent: unitCostCent.present ? unitCostCent.value : this.unitCostCent,
    amountCent: amountCent.present ? amountCent.value : this.amountCent,
    occurredAt: occurredAt ?? this.occurredAt,
    operatorUserId: operatorUserId.present
        ? operatorUserId.value
        : this.operatorUserId,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  StockMovement copyWithCompanion(StockMovementsCompanion data) {
    return StockMovement(
      id: data.id.present ? data.id.value : this.id,
      movementNo: data.movementNo.present
          ? data.movementNo.value
          : this.movementNo,
      movementType: data.movementType.present
          ? data.movementType.value
          : this.movementType,
      refType: data.refType.present ? data.refType.value : this.refType,
      refId: data.refId.present ? data.refId.value : this.refId,
      warehouseId: data.warehouseId.present
          ? data.warehouseId.value
          : this.warehouseId,
      productId: data.productId.present ? data.productId.value : this.productId,
      qtyDelta: data.qtyDelta.present ? data.qtyDelta.value : this.qtyDelta,
      unitCostCent: data.unitCostCent.present
          ? data.unitCostCent.value
          : this.unitCostCent,
      amountCent: data.amountCent.present
          ? data.amountCent.value
          : this.amountCent,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      operatorUserId: data.operatorUserId.present
          ? data.operatorUserId.value
          : this.operatorUserId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovement(')
          ..write('id: $id, ')
          ..write('movementNo: $movementNo, ')
          ..write('movementType: $movementType, ')
          ..write('refType: $refType, ')
          ..write('refId: $refId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('productId: $productId, ')
          ..write('qtyDelta: $qtyDelta, ')
          ..write('unitCostCent: $unitCostCent, ')
          ..write('amountCent: $amountCent, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('operatorUserId: $operatorUserId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    movementNo,
    movementType,
    refType,
    refId,
    warehouseId,
    productId,
    qtyDelta,
    unitCostCent,
    amountCent,
    occurredAt,
    operatorUserId,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovement &&
          other.id == this.id &&
          other.movementNo == this.movementNo &&
          other.movementType == this.movementType &&
          other.refType == this.refType &&
          other.refId == this.refId &&
          other.warehouseId == this.warehouseId &&
          other.productId == this.productId &&
          other.qtyDelta == this.qtyDelta &&
          other.unitCostCent == this.unitCostCent &&
          other.amountCent == this.amountCent &&
          other.occurredAt == this.occurredAt &&
          other.operatorUserId == this.operatorUserId &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovement> {
  final Value<int> id;
  final Value<String> movementNo;
  final Value<String> movementType;
  final Value<String?> refType;
  final Value<int?> refId;
  final Value<int> warehouseId;
  final Value<int> productId;
  final Value<int> qtyDelta;
  final Value<int?> unitCostCent;
  final Value<int?> amountCent;
  final Value<DateTime> occurredAt;
  final Value<int?> operatorUserId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const StockMovementsCompanion({
    this.id = const Value.absent(),
    this.movementNo = const Value.absent(),
    this.movementType = const Value.absent(),
    this.refType = const Value.absent(),
    this.refId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.productId = const Value.absent(),
    this.qtyDelta = const Value.absent(),
    this.unitCostCent = const Value.absent(),
    this.amountCent = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.operatorUserId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    this.id = const Value.absent(),
    required String movementNo,
    required String movementType,
    this.refType = const Value.absent(),
    this.refId = const Value.absent(),
    required int warehouseId,
    required int productId,
    required int qtyDelta,
    this.unitCostCent = const Value.absent(),
    this.amountCent = const Value.absent(),
    required DateTime occurredAt,
    this.operatorUserId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : movementNo = Value(movementNo),
       movementType = Value(movementType),
       warehouseId = Value(warehouseId),
       productId = Value(productId),
       qtyDelta = Value(qtyDelta),
       occurredAt = Value(occurredAt);
  static Insertable<StockMovement> custom({
    Expression<int>? id,
    Expression<String>? movementNo,
    Expression<String>? movementType,
    Expression<String>? refType,
    Expression<int>? refId,
    Expression<int>? warehouseId,
    Expression<int>? productId,
    Expression<int>? qtyDelta,
    Expression<int>? unitCostCent,
    Expression<int>? amountCent,
    Expression<DateTime>? occurredAt,
    Expression<int>? operatorUserId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (movementNo != null) 'movement_no': movementNo,
      if (movementType != null) 'movement_type': movementType,
      if (refType != null) 'ref_type': refType,
      if (refId != null) 'ref_id': refId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (productId != null) 'product_id': productId,
      if (qtyDelta != null) 'qty_delta': qtyDelta,
      if (unitCostCent != null) 'unit_cost_cent': unitCostCent,
      if (amountCent != null) 'amount_cent': amountCent,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (operatorUserId != null) 'operator_user_id': operatorUserId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StockMovementsCompanion copyWith({
    Value<int>? id,
    Value<String>? movementNo,
    Value<String>? movementType,
    Value<String?>? refType,
    Value<int?>? refId,
    Value<int>? warehouseId,
    Value<int>? productId,
    Value<int>? qtyDelta,
    Value<int?>? unitCostCent,
    Value<int?>? amountCent,
    Value<DateTime>? occurredAt,
    Value<int?>? operatorUserId,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return StockMovementsCompanion(
      id: id ?? this.id,
      movementNo: movementNo ?? this.movementNo,
      movementType: movementType ?? this.movementType,
      refType: refType ?? this.refType,
      refId: refId ?? this.refId,
      warehouseId: warehouseId ?? this.warehouseId,
      productId: productId ?? this.productId,
      qtyDelta: qtyDelta ?? this.qtyDelta,
      unitCostCent: unitCostCent ?? this.unitCostCent,
      amountCent: amountCent ?? this.amountCent,
      occurredAt: occurredAt ?? this.occurredAt,
      operatorUserId: operatorUserId ?? this.operatorUserId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (movementNo.present) {
      map['movement_no'] = Variable<String>(movementNo.value);
    }
    if (movementType.present) {
      map['movement_type'] = Variable<String>(movementType.value);
    }
    if (refType.present) {
      map['ref_type'] = Variable<String>(refType.value);
    }
    if (refId.present) {
      map['ref_id'] = Variable<int>(refId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<int>(warehouseId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (qtyDelta.present) {
      map['qty_delta'] = Variable<int>(qtyDelta.value);
    }
    if (unitCostCent.present) {
      map['unit_cost_cent'] = Variable<int>(unitCostCent.value);
    }
    if (amountCent.present) {
      map['amount_cent'] = Variable<int>(amountCent.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (operatorUserId.present) {
      map['operator_user_id'] = Variable<int>(operatorUserId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('id: $id, ')
          ..write('movementNo: $movementNo, ')
          ..write('movementType: $movementType, ')
          ..write('refType: $refType, ')
          ..write('refId: $refId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('productId: $productId, ')
          ..write('qtyDelta: $qtyDelta, ')
          ..write('unitCostCent: $unitCostCent, ')
          ..write('amountCent: $amountCent, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('operatorUserId: $operatorUserId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrdersTable extends PurchaseOrders
    with TableInfo<$PurchaseOrdersTable, PurchaseOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderNoMeta = const VerificationMeta(
    'orderNo',
  );
  @override
  late final GeneratedColumn<String> orderNo = GeneratedColumn<String>(
    'order_no',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _warehouseIdMeta = const VerificationMeta(
    'warehouseId',
  );
  @override
  late final GeneratedColumn<int> warehouseId = GeneratedColumn<int>(
    'warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES warehouses (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _orderedAtMeta = const VerificationMeta(
    'orderedAt',
  );
  @override
  late final GeneratedColumn<DateTime> orderedAt = GeneratedColumn<DateTime>(
    'ordered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedAtMeta = const VerificationMeta(
    'expectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> expectedAt = GeneratedColumn<DateTime>(
    'expected_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalAmountCentMeta = const VerificationMeta(
    'totalAmountCent',
  );
  @override
  late final GeneratedColumn<int> totalAmountCent = GeneratedColumn<int>(
    'total_amount_cent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidAmountCentMeta = const VerificationMeta(
    'paidAmountCent',
  );
  @override
  late final GeneratedColumn<int> paidAmountCent = GeneratedColumn<int>(
    'paid_amount_cent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<int> createdBy = GeneratedColumn<int>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON UPDATE CASCADE ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _approvedByMeta = const VerificationMeta(
    'approvedBy',
  );
  @override
  late final GeneratedColumn<int> approvedBy = GeneratedColumn<int>(
    'approved_by',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON UPDATE CASCADE ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderNo,
    supplierId,
    warehouseId,
    status,
    orderedAt,
    expectedAt,
    totalAmountCent,
    paidAmountCent,
    createdBy,
    approvedBy,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_no')) {
      context.handle(
        _orderNoMeta,
        orderNo.isAcceptableOrUnknown(data['order_no']!, _orderNoMeta),
      );
    } else if (isInserting) {
      context.missing(_orderNoMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
        _warehouseIdMeta,
        warehouseId.isAcceptableOrUnknown(
          data['warehouse_id']!,
          _warehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('ordered_at')) {
      context.handle(
        _orderedAtMeta,
        orderedAt.isAcceptableOrUnknown(data['ordered_at']!, _orderedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_orderedAtMeta);
    }
    if (data.containsKey('expected_at')) {
      context.handle(
        _expectedAtMeta,
        expectedAt.isAcceptableOrUnknown(data['expected_at']!, _expectedAtMeta),
      );
    }
    if (data.containsKey('total_amount_cent')) {
      context.handle(
        _totalAmountCentMeta,
        totalAmountCent.isAcceptableOrUnknown(
          data['total_amount_cent']!,
          _totalAmountCentMeta,
        ),
      );
    }
    if (data.containsKey('paid_amount_cent')) {
      context.handle(
        _paidAmountCentMeta,
        paidAmountCent.isAcceptableOrUnknown(
          data['paid_amount_cent']!,
          _paidAmountCentMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('approved_by')) {
      context.handle(
        _approvedByMeta,
        approvedBy.isAcceptableOrUnknown(data['approved_by']!, _approvedByMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_no'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supplier_id'],
      )!,
      warehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}warehouse_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      orderedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ordered_at'],
      )!,
      expectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_at'],
      ),
      totalAmountCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_amount_cent'],
      )!,
      paidAmountCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paid_amount_cent'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_by'],
      ),
      approvedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}approved_by'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PurchaseOrdersTable createAlias(String alias) {
    return $PurchaseOrdersTable(attachedDatabase, alias);
  }
}

class PurchaseOrder extends DataClass implements Insertable<PurchaseOrder> {
  final int id;
  final String orderNo;
  final int supplierId;
  final int warehouseId;
  final int status;
  final DateTime orderedAt;
  final DateTime? expectedAt;
  final int totalAmountCent;
  final int paidAmountCent;
  final int? createdBy;
  final int? approvedBy;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PurchaseOrder({
    required this.id,
    required this.orderNo,
    required this.supplierId,
    required this.warehouseId,
    required this.status,
    required this.orderedAt,
    this.expectedAt,
    required this.totalAmountCent,
    required this.paidAmountCent,
    this.createdBy,
    this.approvedBy,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_no'] = Variable<String>(orderNo);
    map['supplier_id'] = Variable<int>(supplierId);
    map['warehouse_id'] = Variable<int>(warehouseId);
    map['status'] = Variable<int>(status);
    map['ordered_at'] = Variable<DateTime>(orderedAt);
    if (!nullToAbsent || expectedAt != null) {
      map['expected_at'] = Variable<DateTime>(expectedAt);
    }
    map['total_amount_cent'] = Variable<int>(totalAmountCent);
    map['paid_amount_cent'] = Variable<int>(paidAmountCent);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<int>(createdBy);
    }
    if (!nullToAbsent || approvedBy != null) {
      map['approved_by'] = Variable<int>(approvedBy);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PurchaseOrdersCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrdersCompanion(
      id: Value(id),
      orderNo: Value(orderNo),
      supplierId: Value(supplierId),
      warehouseId: Value(warehouseId),
      status: Value(status),
      orderedAt: Value(orderedAt),
      expectedAt: expectedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedAt),
      totalAmountCent: Value(totalAmountCent),
      paidAmountCent: Value(paidAmountCent),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      approvedBy: approvedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedBy),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PurchaseOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrder(
      id: serializer.fromJson<int>(json['id']),
      orderNo: serializer.fromJson<String>(json['orderNo']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      warehouseId: serializer.fromJson<int>(json['warehouseId']),
      status: serializer.fromJson<int>(json['status']),
      orderedAt: serializer.fromJson<DateTime>(json['orderedAt']),
      expectedAt: serializer.fromJson<DateTime?>(json['expectedAt']),
      totalAmountCent: serializer.fromJson<int>(json['totalAmountCent']),
      paidAmountCent: serializer.fromJson<int>(json['paidAmountCent']),
      createdBy: serializer.fromJson<int?>(json['createdBy']),
      approvedBy: serializer.fromJson<int?>(json['approvedBy']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderNo': serializer.toJson<String>(orderNo),
      'supplierId': serializer.toJson<int>(supplierId),
      'warehouseId': serializer.toJson<int>(warehouseId),
      'status': serializer.toJson<int>(status),
      'orderedAt': serializer.toJson<DateTime>(orderedAt),
      'expectedAt': serializer.toJson<DateTime?>(expectedAt),
      'totalAmountCent': serializer.toJson<int>(totalAmountCent),
      'paidAmountCent': serializer.toJson<int>(paidAmountCent),
      'createdBy': serializer.toJson<int?>(createdBy),
      'approvedBy': serializer.toJson<int?>(approvedBy),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PurchaseOrder copyWith({
    int? id,
    String? orderNo,
    int? supplierId,
    int? warehouseId,
    int? status,
    DateTime? orderedAt,
    Value<DateTime?> expectedAt = const Value.absent(),
    int? totalAmountCent,
    int? paidAmountCent,
    Value<int?> createdBy = const Value.absent(),
    Value<int?> approvedBy = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PurchaseOrder(
    id: id ?? this.id,
    orderNo: orderNo ?? this.orderNo,
    supplierId: supplierId ?? this.supplierId,
    warehouseId: warehouseId ?? this.warehouseId,
    status: status ?? this.status,
    orderedAt: orderedAt ?? this.orderedAt,
    expectedAt: expectedAt.present ? expectedAt.value : this.expectedAt,
    totalAmountCent: totalAmountCent ?? this.totalAmountCent,
    paidAmountCent: paidAmountCent ?? this.paidAmountCent,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    approvedBy: approvedBy.present ? approvedBy.value : this.approvedBy,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PurchaseOrder copyWithCompanion(PurchaseOrdersCompanion data) {
    return PurchaseOrder(
      id: data.id.present ? data.id.value : this.id,
      orderNo: data.orderNo.present ? data.orderNo.value : this.orderNo,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      warehouseId: data.warehouseId.present
          ? data.warehouseId.value
          : this.warehouseId,
      status: data.status.present ? data.status.value : this.status,
      orderedAt: data.orderedAt.present ? data.orderedAt.value : this.orderedAt,
      expectedAt: data.expectedAt.present
          ? data.expectedAt.value
          : this.expectedAt,
      totalAmountCent: data.totalAmountCent.present
          ? data.totalAmountCent.value
          : this.totalAmountCent,
      paidAmountCent: data.paidAmountCent.present
          ? data.paidAmountCent.value
          : this.paidAmountCent,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      approvedBy: data.approvedBy.present
          ? data.approvedBy.value
          : this.approvedBy,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrder(')
          ..write('id: $id, ')
          ..write('orderNo: $orderNo, ')
          ..write('supplierId: $supplierId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('status: $status, ')
          ..write('orderedAt: $orderedAt, ')
          ..write('expectedAt: $expectedAt, ')
          ..write('totalAmountCent: $totalAmountCent, ')
          ..write('paidAmountCent: $paidAmountCent, ')
          ..write('createdBy: $createdBy, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderNo,
    supplierId,
    warehouseId,
    status,
    orderedAt,
    expectedAt,
    totalAmountCent,
    paidAmountCent,
    createdBy,
    approvedBy,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrder &&
          other.id == this.id &&
          other.orderNo == this.orderNo &&
          other.supplierId == this.supplierId &&
          other.warehouseId == this.warehouseId &&
          other.status == this.status &&
          other.orderedAt == this.orderedAt &&
          other.expectedAt == this.expectedAt &&
          other.totalAmountCent == this.totalAmountCent &&
          other.paidAmountCent == this.paidAmountCent &&
          other.createdBy == this.createdBy &&
          other.approvedBy == this.approvedBy &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PurchaseOrdersCompanion extends UpdateCompanion<PurchaseOrder> {
  final Value<int> id;
  final Value<String> orderNo;
  final Value<int> supplierId;
  final Value<int> warehouseId;
  final Value<int> status;
  final Value<DateTime> orderedAt;
  final Value<DateTime?> expectedAt;
  final Value<int> totalAmountCent;
  final Value<int> paidAmountCent;
  final Value<int?> createdBy;
  final Value<int?> approvedBy;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PurchaseOrdersCompanion({
    this.id = const Value.absent(),
    this.orderNo = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.status = const Value.absent(),
    this.orderedAt = const Value.absent(),
    this.expectedAt = const Value.absent(),
    this.totalAmountCent = const Value.absent(),
    this.paidAmountCent = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PurchaseOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String orderNo,
    required int supplierId,
    required int warehouseId,
    this.status = const Value.absent(),
    required DateTime orderedAt,
    this.expectedAt = const Value.absent(),
    this.totalAmountCent = const Value.absent(),
    this.paidAmountCent = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : orderNo = Value(orderNo),
       supplierId = Value(supplierId),
       warehouseId = Value(warehouseId),
       orderedAt = Value(orderedAt);
  static Insertable<PurchaseOrder> custom({
    Expression<int>? id,
    Expression<String>? orderNo,
    Expression<int>? supplierId,
    Expression<int>? warehouseId,
    Expression<int>? status,
    Expression<DateTime>? orderedAt,
    Expression<DateTime>? expectedAt,
    Expression<int>? totalAmountCent,
    Expression<int>? paidAmountCent,
    Expression<int>? createdBy,
    Expression<int>? approvedBy,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderNo != null) 'order_no': orderNo,
      if (supplierId != null) 'supplier_id': supplierId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (status != null) 'status': status,
      if (orderedAt != null) 'ordered_at': orderedAt,
      if (expectedAt != null) 'expected_at': expectedAt,
      if (totalAmountCent != null) 'total_amount_cent': totalAmountCent,
      if (paidAmountCent != null) 'paid_amount_cent': paidAmountCent,
      if (createdBy != null) 'created_by': createdBy,
      if (approvedBy != null) 'approved_by': approvedBy,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PurchaseOrdersCompanion copyWith({
    Value<int>? id,
    Value<String>? orderNo,
    Value<int>? supplierId,
    Value<int>? warehouseId,
    Value<int>? status,
    Value<DateTime>? orderedAt,
    Value<DateTime?>? expectedAt,
    Value<int>? totalAmountCent,
    Value<int>? paidAmountCent,
    Value<int?>? createdBy,
    Value<int?>? approvedBy,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PurchaseOrdersCompanion(
      id: id ?? this.id,
      orderNo: orderNo ?? this.orderNo,
      supplierId: supplierId ?? this.supplierId,
      warehouseId: warehouseId ?? this.warehouseId,
      status: status ?? this.status,
      orderedAt: orderedAt ?? this.orderedAt,
      expectedAt: expectedAt ?? this.expectedAt,
      totalAmountCent: totalAmountCent ?? this.totalAmountCent,
      paidAmountCent: paidAmountCent ?? this.paidAmountCent,
      createdBy: createdBy ?? this.createdBy,
      approvedBy: approvedBy ?? this.approvedBy,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderNo.present) {
      map['order_no'] = Variable<String>(orderNo.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<int>(warehouseId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (orderedAt.present) {
      map['ordered_at'] = Variable<DateTime>(orderedAt.value);
    }
    if (expectedAt.present) {
      map['expected_at'] = Variable<DateTime>(expectedAt.value);
    }
    if (totalAmountCent.present) {
      map['total_amount_cent'] = Variable<int>(totalAmountCent.value);
    }
    if (paidAmountCent.present) {
      map['paid_amount_cent'] = Variable<int>(paidAmountCent.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<int>(createdBy.value);
    }
    if (approvedBy.present) {
      map['approved_by'] = Variable<int>(approvedBy.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrdersCompanion(')
          ..write('id: $id, ')
          ..write('orderNo: $orderNo, ')
          ..write('supplierId: $supplierId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('status: $status, ')
          ..write('orderedAt: $orderedAt, ')
          ..write('expectedAt: $expectedAt, ')
          ..write('totalAmountCent: $totalAmountCent, ')
          ..write('paidAmountCent: $paidAmountCent, ')
          ..write('createdBy: $createdBy, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrderItemsTable extends PurchaseOrderItems
    with TableInfo<$PurchaseOrderItemsTable, PurchaseOrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _purchaseOrderIdMeta = const VerificationMeta(
    'purchaseOrderId',
  );
  @override
  late final GeneratedColumn<int> purchaseOrderId = GeneratedColumn<int>(
    'purchase_order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_orders (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _lineNoMeta = const VerificationMeta('lineNo');
  @override
  late final GeneratedColumn<int> lineNo = GeneratedColumn<int>(
    'line_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceCentMeta = const VerificationMeta(
    'unitPriceCent',
  );
  @override
  late final GeneratedColumn<int> unitPriceCent = GeneratedColumn<int>(
    'unit_price_cent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountBpMeta = const VerificationMeta(
    'discountBp',
  );
  @override
  late final GeneratedColumn<int> discountBp = GeneratedColumn<int>(
    'discount_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10000),
  );
  static const VerificationMeta _lineAmountCentMeta = const VerificationMeta(
    'lineAmountCent',
  );
  @override
  late final GeneratedColumn<int> lineAmountCent = GeneratedColumn<int>(
    'line_amount_cent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedQtyMeta = const VerificationMeta(
    'receivedQty',
  );
  @override
  late final GeneratedColumn<int> receivedQty = GeneratedColumn<int>(
    'received_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseOrderId,
    lineNo,
    productId,
    qty,
    unitPriceCent,
    discountBp,
    lineAmountCent,
    receivedQty,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_order_id')) {
      context.handle(
        _purchaseOrderIdMeta,
        purchaseOrderId.isAcceptableOrUnknown(
          data['purchase_order_id']!,
          _purchaseOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseOrderIdMeta);
    }
    if (data.containsKey('line_no')) {
      context.handle(
        _lineNoMeta,
        lineNo.isAcceptableOrUnknown(data['line_no']!, _lineNoMeta),
      );
    } else if (isInserting) {
      context.missing(_lineNoMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('unit_price_cent')) {
      context.handle(
        _unitPriceCentMeta,
        unitPriceCent.isAcceptableOrUnknown(
          data['unit_price_cent']!,
          _unitPriceCentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceCentMeta);
    }
    if (data.containsKey('discount_bp')) {
      context.handle(
        _discountBpMeta,
        discountBp.isAcceptableOrUnknown(data['discount_bp']!, _discountBpMeta),
      );
    }
    if (data.containsKey('line_amount_cent')) {
      context.handle(
        _lineAmountCentMeta,
        lineAmountCent.isAcceptableOrUnknown(
          data['line_amount_cent']!,
          _lineAmountCentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineAmountCentMeta);
    }
    if (data.containsKey('received_qty')) {
      context.handle(
        _receivedQtyMeta,
        receivedQty.isAcceptableOrUnknown(
          data['received_qty']!,
          _receivedQtyMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_order_id'],
      )!,
      lineNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_no'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
      unitPriceCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_cent'],
      )!,
      discountBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_bp'],
      )!,
      lineAmountCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_amount_cent'],
      )!,
      receivedQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}received_qty'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $PurchaseOrderItemsTable createAlias(String alias) {
    return $PurchaseOrderItemsTable(attachedDatabase, alias);
  }
}

class PurchaseOrderItem extends DataClass
    implements Insertable<PurchaseOrderItem> {
  final int id;
  final int purchaseOrderId;
  final int lineNo;
  final int productId;
  final int qty;
  final int unitPriceCent;
  final int discountBp;
  final int lineAmountCent;
  final int receivedQty;
  final String? note;
  const PurchaseOrderItem({
    required this.id,
    required this.purchaseOrderId,
    required this.lineNo,
    required this.productId,
    required this.qty,
    required this.unitPriceCent,
    required this.discountBp,
    required this.lineAmountCent,
    required this.receivedQty,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_order_id'] = Variable<int>(purchaseOrderId);
    map['line_no'] = Variable<int>(lineNo);
    map['product_id'] = Variable<int>(productId);
    map['qty'] = Variable<int>(qty);
    map['unit_price_cent'] = Variable<int>(unitPriceCent);
    map['discount_bp'] = Variable<int>(discountBp);
    map['line_amount_cent'] = Variable<int>(lineAmountCent);
    map['received_qty'] = Variable<int>(receivedQty);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PurchaseOrderItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrderItemsCompanion(
      id: Value(id),
      purchaseOrderId: Value(purchaseOrderId),
      lineNo: Value(lineNo),
      productId: Value(productId),
      qty: Value(qty),
      unitPriceCent: Value(unitPriceCent),
      discountBp: Value(discountBp),
      lineAmountCent: Value(lineAmountCent),
      receivedQty: Value(receivedQty),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory PurchaseOrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrderItem(
      id: serializer.fromJson<int>(json['id']),
      purchaseOrderId: serializer.fromJson<int>(json['purchaseOrderId']),
      lineNo: serializer.fromJson<int>(json['lineNo']),
      productId: serializer.fromJson<int>(json['productId']),
      qty: serializer.fromJson<int>(json['qty']),
      unitPriceCent: serializer.fromJson<int>(json['unitPriceCent']),
      discountBp: serializer.fromJson<int>(json['discountBp']),
      lineAmountCent: serializer.fromJson<int>(json['lineAmountCent']),
      receivedQty: serializer.fromJson<int>(json['receivedQty']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseOrderId': serializer.toJson<int>(purchaseOrderId),
      'lineNo': serializer.toJson<int>(lineNo),
      'productId': serializer.toJson<int>(productId),
      'qty': serializer.toJson<int>(qty),
      'unitPriceCent': serializer.toJson<int>(unitPriceCent),
      'discountBp': serializer.toJson<int>(discountBp),
      'lineAmountCent': serializer.toJson<int>(lineAmountCent),
      'receivedQty': serializer.toJson<int>(receivedQty),
      'note': serializer.toJson<String?>(note),
    };
  }

  PurchaseOrderItem copyWith({
    int? id,
    int? purchaseOrderId,
    int? lineNo,
    int? productId,
    int? qty,
    int? unitPriceCent,
    int? discountBp,
    int? lineAmountCent,
    int? receivedQty,
    Value<String?> note = const Value.absent(),
  }) => PurchaseOrderItem(
    id: id ?? this.id,
    purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
    lineNo: lineNo ?? this.lineNo,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
    unitPriceCent: unitPriceCent ?? this.unitPriceCent,
    discountBp: discountBp ?? this.discountBp,
    lineAmountCent: lineAmountCent ?? this.lineAmountCent,
    receivedQty: receivedQty ?? this.receivedQty,
    note: note.present ? note.value : this.note,
  );
  PurchaseOrderItem copyWithCompanion(PurchaseOrderItemsCompanion data) {
    return PurchaseOrderItem(
      id: data.id.present ? data.id.value : this.id,
      purchaseOrderId: data.purchaseOrderId.present
          ? data.purchaseOrderId.value
          : this.purchaseOrderId,
      lineNo: data.lineNo.present ? data.lineNo.value : this.lineNo,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
      unitPriceCent: data.unitPriceCent.present
          ? data.unitPriceCent.value
          : this.unitPriceCent,
      discountBp: data.discountBp.present
          ? data.discountBp.value
          : this.discountBp,
      lineAmountCent: data.lineAmountCent.present
          ? data.lineAmountCent.value
          : this.lineAmountCent,
      receivedQty: data.receivedQty.present
          ? data.receivedQty.value
          : this.receivedQty,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderItem(')
          ..write('id: $id, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('lineNo: $lineNo, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitPriceCent: $unitPriceCent, ')
          ..write('discountBp: $discountBp, ')
          ..write('lineAmountCent: $lineAmountCent, ')
          ..write('receivedQty: $receivedQty, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseOrderId,
    lineNo,
    productId,
    qty,
    unitPriceCent,
    discountBp,
    lineAmountCent,
    receivedQty,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrderItem &&
          other.id == this.id &&
          other.purchaseOrderId == this.purchaseOrderId &&
          other.lineNo == this.lineNo &&
          other.productId == this.productId &&
          other.qty == this.qty &&
          other.unitPriceCent == this.unitPriceCent &&
          other.discountBp == this.discountBp &&
          other.lineAmountCent == this.lineAmountCent &&
          other.receivedQty == this.receivedQty &&
          other.note == this.note);
}

class PurchaseOrderItemsCompanion extends UpdateCompanion<PurchaseOrderItem> {
  final Value<int> id;
  final Value<int> purchaseOrderId;
  final Value<int> lineNo;
  final Value<int> productId;
  final Value<int> qty;
  final Value<int> unitPriceCent;
  final Value<int> discountBp;
  final Value<int> lineAmountCent;
  final Value<int> receivedQty;
  final Value<String?> note;
  const PurchaseOrderItemsCompanion({
    this.id = const Value.absent(),
    this.purchaseOrderId = const Value.absent(),
    this.lineNo = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.unitPriceCent = const Value.absent(),
    this.discountBp = const Value.absent(),
    this.lineAmountCent = const Value.absent(),
    this.receivedQty = const Value.absent(),
    this.note = const Value.absent(),
  });
  PurchaseOrderItemsCompanion.insert({
    this.id = const Value.absent(),
    required int purchaseOrderId,
    required int lineNo,
    required int productId,
    required int qty,
    required int unitPriceCent,
    this.discountBp = const Value.absent(),
    required int lineAmountCent,
    this.receivedQty = const Value.absent(),
    this.note = const Value.absent(),
  }) : purchaseOrderId = Value(purchaseOrderId),
       lineNo = Value(lineNo),
       productId = Value(productId),
       qty = Value(qty),
       unitPriceCent = Value(unitPriceCent),
       lineAmountCent = Value(lineAmountCent);
  static Insertable<PurchaseOrderItem> custom({
    Expression<int>? id,
    Expression<int>? purchaseOrderId,
    Expression<int>? lineNo,
    Expression<int>? productId,
    Expression<int>? qty,
    Expression<int>? unitPriceCent,
    Expression<int>? discountBp,
    Expression<int>? lineAmountCent,
    Expression<int>? receivedQty,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseOrderId != null) 'purchase_order_id': purchaseOrderId,
      if (lineNo != null) 'line_no': lineNo,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (unitPriceCent != null) 'unit_price_cent': unitPriceCent,
      if (discountBp != null) 'discount_bp': discountBp,
      if (lineAmountCent != null) 'line_amount_cent': lineAmountCent,
      if (receivedQty != null) 'received_qty': receivedQty,
      if (note != null) 'note': note,
    });
  }

  PurchaseOrderItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? purchaseOrderId,
    Value<int>? lineNo,
    Value<int>? productId,
    Value<int>? qty,
    Value<int>? unitPriceCent,
    Value<int>? discountBp,
    Value<int>? lineAmountCent,
    Value<int>? receivedQty,
    Value<String?>? note,
  }) {
    return PurchaseOrderItemsCompanion(
      id: id ?? this.id,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      lineNo: lineNo ?? this.lineNo,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      unitPriceCent: unitPriceCent ?? this.unitPriceCent,
      discountBp: discountBp ?? this.discountBp,
      lineAmountCent: lineAmountCent ?? this.lineAmountCent,
      receivedQty: receivedQty ?? this.receivedQty,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseOrderId.present) {
      map['purchase_order_id'] = Variable<int>(purchaseOrderId.value);
    }
    if (lineNo.present) {
      map['line_no'] = Variable<int>(lineNo.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (unitPriceCent.present) {
      map['unit_price_cent'] = Variable<int>(unitPriceCent.value);
    }
    if (discountBp.present) {
      map['discount_bp'] = Variable<int>(discountBp.value);
    }
    if (lineAmountCent.present) {
      map['line_amount_cent'] = Variable<int>(lineAmountCent.value);
    }
    if (receivedQty.present) {
      map['received_qty'] = Variable<int>(receivedQty.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('lineNo: $lineNo, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitPriceCent: $unitPriceCent, ')
          ..write('discountBp: $discountBp, ')
          ..write('lineAmountCent: $lineAmountCent, ')
          ..write('receivedQty: $receivedQty, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $SalesOrdersTable extends SalesOrders
    with TableInfo<$SalesOrdersTable, SalesOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderNoMeta = const VerificationMeta(
    'orderNo',
  );
  @override
  late final GeneratedColumn<String> orderNo = GeneratedColumn<String>(
    'order_no',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id) ON UPDATE CASCADE ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _warehouseIdMeta = const VerificationMeta(
    'warehouseId',
  );
  @override
  late final GeneratedColumn<int> warehouseId = GeneratedColumn<int>(
    'warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES warehouses (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _salesChannelMeta = const VerificationMeta(
    'salesChannel',
  );
  @override
  late final GeneratedColumn<String> salesChannel = GeneratedColumn<String>(
    'sales_channel',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('store'),
  );
  static const VerificationMeta _soldAtMeta = const VerificationMeta('soldAt');
  @override
  late final GeneratedColumn<DateTime> soldAt = GeneratedColumn<DateTime>(
    'sold_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountCentMeta = const VerificationMeta(
    'totalAmountCent',
  );
  @override
  late final GeneratedColumn<int> totalAmountCent = GeneratedColumn<int>(
    'total_amount_cent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _receivableAmountCentMeta =
      const VerificationMeta('receivableAmountCent');
  @override
  late final GeneratedColumn<int> receivableAmountCent = GeneratedColumn<int>(
    'receivable_amount_cent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _receivedAmountCentMeta =
      const VerificationMeta('receivedAmountCent');
  @override
  late final GeneratedColumn<int> receivedAmountCent = GeneratedColumn<int>(
    'received_amount_cent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<int> createdBy = GeneratedColumn<int>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON UPDATE CASCADE ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderNo,
    customerId,
    warehouseId,
    status,
    salesChannel,
    soldAt,
    totalAmountCent,
    receivableAmountCent,
    receivedAmountCent,
    createdBy,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_no')) {
      context.handle(
        _orderNoMeta,
        orderNo.isAcceptableOrUnknown(data['order_no']!, _orderNoMeta),
      );
    } else if (isInserting) {
      context.missing(_orderNoMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
        _warehouseIdMeta,
        warehouseId.isAcceptableOrUnknown(
          data['warehouse_id']!,
          _warehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('sales_channel')) {
      context.handle(
        _salesChannelMeta,
        salesChannel.isAcceptableOrUnknown(
          data['sales_channel']!,
          _salesChannelMeta,
        ),
      );
    }
    if (data.containsKey('sold_at')) {
      context.handle(
        _soldAtMeta,
        soldAt.isAcceptableOrUnknown(data['sold_at']!, _soldAtMeta),
      );
    } else if (isInserting) {
      context.missing(_soldAtMeta);
    }
    if (data.containsKey('total_amount_cent')) {
      context.handle(
        _totalAmountCentMeta,
        totalAmountCent.isAcceptableOrUnknown(
          data['total_amount_cent']!,
          _totalAmountCentMeta,
        ),
      );
    }
    if (data.containsKey('receivable_amount_cent')) {
      context.handle(
        _receivableAmountCentMeta,
        receivableAmountCent.isAcceptableOrUnknown(
          data['receivable_amount_cent']!,
          _receivableAmountCentMeta,
        ),
      );
    }
    if (data.containsKey('received_amount_cent')) {
      context.handle(
        _receivedAmountCentMeta,
        receivedAmountCent.isAcceptableOrUnknown(
          data['received_amount_cent']!,
          _receivedAmountCentMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_no'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      warehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}warehouse_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      salesChannel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sales_channel'],
      )!,
      soldAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sold_at'],
      )!,
      totalAmountCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_amount_cent'],
      )!,
      receivableAmountCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receivable_amount_cent'],
      )!,
      receivedAmountCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}received_amount_cent'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_by'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SalesOrdersTable createAlias(String alias) {
    return $SalesOrdersTable(attachedDatabase, alias);
  }
}

class SalesOrder extends DataClass implements Insertable<SalesOrder> {
  final int id;
  final String orderNo;
  final int? customerId;
  final int warehouseId;
  final int status;
  final String salesChannel;
  final DateTime soldAt;
  final int totalAmountCent;
  final int receivableAmountCent;
  final int receivedAmountCent;
  final int? createdBy;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SalesOrder({
    required this.id,
    required this.orderNo,
    this.customerId,
    required this.warehouseId,
    required this.status,
    required this.salesChannel,
    required this.soldAt,
    required this.totalAmountCent,
    required this.receivableAmountCent,
    required this.receivedAmountCent,
    this.createdBy,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_no'] = Variable<String>(orderNo);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['warehouse_id'] = Variable<int>(warehouseId);
    map['status'] = Variable<int>(status);
    map['sales_channel'] = Variable<String>(salesChannel);
    map['sold_at'] = Variable<DateTime>(soldAt);
    map['total_amount_cent'] = Variable<int>(totalAmountCent);
    map['receivable_amount_cent'] = Variable<int>(receivableAmountCent);
    map['received_amount_cent'] = Variable<int>(receivedAmountCent);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<int>(createdBy);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SalesOrdersCompanion toCompanion(bool nullToAbsent) {
    return SalesOrdersCompanion(
      id: Value(id),
      orderNo: Value(orderNo),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      warehouseId: Value(warehouseId),
      status: Value(status),
      salesChannel: Value(salesChannel),
      soldAt: Value(soldAt),
      totalAmountCent: Value(totalAmountCent),
      receivableAmountCent: Value(receivableAmountCent),
      receivedAmountCent: Value(receivedAmountCent),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SalesOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesOrder(
      id: serializer.fromJson<int>(json['id']),
      orderNo: serializer.fromJson<String>(json['orderNo']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      warehouseId: serializer.fromJson<int>(json['warehouseId']),
      status: serializer.fromJson<int>(json['status']),
      salesChannel: serializer.fromJson<String>(json['salesChannel']),
      soldAt: serializer.fromJson<DateTime>(json['soldAt']),
      totalAmountCent: serializer.fromJson<int>(json['totalAmountCent']),
      receivableAmountCent: serializer.fromJson<int>(
        json['receivableAmountCent'],
      ),
      receivedAmountCent: serializer.fromJson<int>(json['receivedAmountCent']),
      createdBy: serializer.fromJson<int?>(json['createdBy']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderNo': serializer.toJson<String>(orderNo),
      'customerId': serializer.toJson<int?>(customerId),
      'warehouseId': serializer.toJson<int>(warehouseId),
      'status': serializer.toJson<int>(status),
      'salesChannel': serializer.toJson<String>(salesChannel),
      'soldAt': serializer.toJson<DateTime>(soldAt),
      'totalAmountCent': serializer.toJson<int>(totalAmountCent),
      'receivableAmountCent': serializer.toJson<int>(receivableAmountCent),
      'receivedAmountCent': serializer.toJson<int>(receivedAmountCent),
      'createdBy': serializer.toJson<int?>(createdBy),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SalesOrder copyWith({
    int? id,
    String? orderNo,
    Value<int?> customerId = const Value.absent(),
    int? warehouseId,
    int? status,
    String? salesChannel,
    DateTime? soldAt,
    int? totalAmountCent,
    int? receivableAmountCent,
    int? receivedAmountCent,
    Value<int?> createdBy = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SalesOrder(
    id: id ?? this.id,
    orderNo: orderNo ?? this.orderNo,
    customerId: customerId.present ? customerId.value : this.customerId,
    warehouseId: warehouseId ?? this.warehouseId,
    status: status ?? this.status,
    salesChannel: salesChannel ?? this.salesChannel,
    soldAt: soldAt ?? this.soldAt,
    totalAmountCent: totalAmountCent ?? this.totalAmountCent,
    receivableAmountCent: receivableAmountCent ?? this.receivableAmountCent,
    receivedAmountCent: receivedAmountCent ?? this.receivedAmountCent,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SalesOrder copyWithCompanion(SalesOrdersCompanion data) {
    return SalesOrder(
      id: data.id.present ? data.id.value : this.id,
      orderNo: data.orderNo.present ? data.orderNo.value : this.orderNo,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      warehouseId: data.warehouseId.present
          ? data.warehouseId.value
          : this.warehouseId,
      status: data.status.present ? data.status.value : this.status,
      salesChannel: data.salesChannel.present
          ? data.salesChannel.value
          : this.salesChannel,
      soldAt: data.soldAt.present ? data.soldAt.value : this.soldAt,
      totalAmountCent: data.totalAmountCent.present
          ? data.totalAmountCent.value
          : this.totalAmountCent,
      receivableAmountCent: data.receivableAmountCent.present
          ? data.receivableAmountCent.value
          : this.receivableAmountCent,
      receivedAmountCent: data.receivedAmountCent.present
          ? data.receivedAmountCent.value
          : this.receivedAmountCent,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesOrder(')
          ..write('id: $id, ')
          ..write('orderNo: $orderNo, ')
          ..write('customerId: $customerId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('status: $status, ')
          ..write('salesChannel: $salesChannel, ')
          ..write('soldAt: $soldAt, ')
          ..write('totalAmountCent: $totalAmountCent, ')
          ..write('receivableAmountCent: $receivableAmountCent, ')
          ..write('receivedAmountCent: $receivedAmountCent, ')
          ..write('createdBy: $createdBy, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderNo,
    customerId,
    warehouseId,
    status,
    salesChannel,
    soldAt,
    totalAmountCent,
    receivableAmountCent,
    receivedAmountCent,
    createdBy,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesOrder &&
          other.id == this.id &&
          other.orderNo == this.orderNo &&
          other.customerId == this.customerId &&
          other.warehouseId == this.warehouseId &&
          other.status == this.status &&
          other.salesChannel == this.salesChannel &&
          other.soldAt == this.soldAt &&
          other.totalAmountCent == this.totalAmountCent &&
          other.receivableAmountCent == this.receivableAmountCent &&
          other.receivedAmountCent == this.receivedAmountCent &&
          other.createdBy == this.createdBy &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SalesOrdersCompanion extends UpdateCompanion<SalesOrder> {
  final Value<int> id;
  final Value<String> orderNo;
  final Value<int?> customerId;
  final Value<int> warehouseId;
  final Value<int> status;
  final Value<String> salesChannel;
  final Value<DateTime> soldAt;
  final Value<int> totalAmountCent;
  final Value<int> receivableAmountCent;
  final Value<int> receivedAmountCent;
  final Value<int?> createdBy;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SalesOrdersCompanion({
    this.id = const Value.absent(),
    this.orderNo = const Value.absent(),
    this.customerId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.status = const Value.absent(),
    this.salesChannel = const Value.absent(),
    this.soldAt = const Value.absent(),
    this.totalAmountCent = const Value.absent(),
    this.receivableAmountCent = const Value.absent(),
    this.receivedAmountCent = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SalesOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String orderNo,
    this.customerId = const Value.absent(),
    required int warehouseId,
    this.status = const Value.absent(),
    this.salesChannel = const Value.absent(),
    required DateTime soldAt,
    this.totalAmountCent = const Value.absent(),
    this.receivableAmountCent = const Value.absent(),
    this.receivedAmountCent = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : orderNo = Value(orderNo),
       warehouseId = Value(warehouseId),
       soldAt = Value(soldAt);
  static Insertable<SalesOrder> custom({
    Expression<int>? id,
    Expression<String>? orderNo,
    Expression<int>? customerId,
    Expression<int>? warehouseId,
    Expression<int>? status,
    Expression<String>? salesChannel,
    Expression<DateTime>? soldAt,
    Expression<int>? totalAmountCent,
    Expression<int>? receivableAmountCent,
    Expression<int>? receivedAmountCent,
    Expression<int>? createdBy,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderNo != null) 'order_no': orderNo,
      if (customerId != null) 'customer_id': customerId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (status != null) 'status': status,
      if (salesChannel != null) 'sales_channel': salesChannel,
      if (soldAt != null) 'sold_at': soldAt,
      if (totalAmountCent != null) 'total_amount_cent': totalAmountCent,
      if (receivableAmountCent != null)
        'receivable_amount_cent': receivableAmountCent,
      if (receivedAmountCent != null)
        'received_amount_cent': receivedAmountCent,
      if (createdBy != null) 'created_by': createdBy,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SalesOrdersCompanion copyWith({
    Value<int>? id,
    Value<String>? orderNo,
    Value<int?>? customerId,
    Value<int>? warehouseId,
    Value<int>? status,
    Value<String>? salesChannel,
    Value<DateTime>? soldAt,
    Value<int>? totalAmountCent,
    Value<int>? receivableAmountCent,
    Value<int>? receivedAmountCent,
    Value<int?>? createdBy,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SalesOrdersCompanion(
      id: id ?? this.id,
      orderNo: orderNo ?? this.orderNo,
      customerId: customerId ?? this.customerId,
      warehouseId: warehouseId ?? this.warehouseId,
      status: status ?? this.status,
      salesChannel: salesChannel ?? this.salesChannel,
      soldAt: soldAt ?? this.soldAt,
      totalAmountCent: totalAmountCent ?? this.totalAmountCent,
      receivableAmountCent: receivableAmountCent ?? this.receivableAmountCent,
      receivedAmountCent: receivedAmountCent ?? this.receivedAmountCent,
      createdBy: createdBy ?? this.createdBy,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderNo.present) {
      map['order_no'] = Variable<String>(orderNo.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<int>(warehouseId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (salesChannel.present) {
      map['sales_channel'] = Variable<String>(salesChannel.value);
    }
    if (soldAt.present) {
      map['sold_at'] = Variable<DateTime>(soldAt.value);
    }
    if (totalAmountCent.present) {
      map['total_amount_cent'] = Variable<int>(totalAmountCent.value);
    }
    if (receivableAmountCent.present) {
      map['receivable_amount_cent'] = Variable<int>(receivableAmountCent.value);
    }
    if (receivedAmountCent.present) {
      map['received_amount_cent'] = Variable<int>(receivedAmountCent.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<int>(createdBy.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesOrdersCompanion(')
          ..write('id: $id, ')
          ..write('orderNo: $orderNo, ')
          ..write('customerId: $customerId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('status: $status, ')
          ..write('salesChannel: $salesChannel, ')
          ..write('soldAt: $soldAt, ')
          ..write('totalAmountCent: $totalAmountCent, ')
          ..write('receivableAmountCent: $receivableAmountCent, ')
          ..write('receivedAmountCent: $receivedAmountCent, ')
          ..write('createdBy: $createdBy, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SalesOrderItemsTable extends SalesOrderItems
    with TableInfo<$SalesOrderItemsTable, SalesOrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesOrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _salesOrderIdMeta = const VerificationMeta(
    'salesOrderId',
  );
  @override
  late final GeneratedColumn<int> salesOrderId = GeneratedColumn<int>(
    'sales_order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sales_orders (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _lineNoMeta = const VerificationMeta('lineNo');
  @override
  late final GeneratedColumn<int> lineNo = GeneratedColumn<int>(
    'line_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON UPDATE CASCADE ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceCentMeta = const VerificationMeta(
    'unitPriceCent',
  );
  @override
  late final GeneratedColumn<int> unitPriceCent = GeneratedColumn<int>(
    'unit_price_cent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountBpMeta = const VerificationMeta(
    'discountBp',
  );
  @override
  late final GeneratedColumn<int> discountBp = GeneratedColumn<int>(
    'discount_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10000),
  );
  static const VerificationMeta _lineAmountCentMeta = const VerificationMeta(
    'lineAmountCent',
  );
  @override
  late final GeneratedColumn<int> lineAmountCent = GeneratedColumn<int>(
    'line_amount_cent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPriceCentMeta = const VerificationMeta(
    'costPriceCent',
  );
  @override
  late final GeneratedColumn<int> costPriceCent = GeneratedColumn<int>(
    'cost_price_cent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    salesOrderId,
    lineNo,
    productId,
    qty,
    unitPriceCent,
    discountBp,
    lineAmountCent,
    costPriceCent,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesOrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sales_order_id')) {
      context.handle(
        _salesOrderIdMeta,
        salesOrderId.isAcceptableOrUnknown(
          data['sales_order_id']!,
          _salesOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_salesOrderIdMeta);
    }
    if (data.containsKey('line_no')) {
      context.handle(
        _lineNoMeta,
        lineNo.isAcceptableOrUnknown(data['line_no']!, _lineNoMeta),
      );
    } else if (isInserting) {
      context.missing(_lineNoMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('unit_price_cent')) {
      context.handle(
        _unitPriceCentMeta,
        unitPriceCent.isAcceptableOrUnknown(
          data['unit_price_cent']!,
          _unitPriceCentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceCentMeta);
    }
    if (data.containsKey('discount_bp')) {
      context.handle(
        _discountBpMeta,
        discountBp.isAcceptableOrUnknown(data['discount_bp']!, _discountBpMeta),
      );
    }
    if (data.containsKey('line_amount_cent')) {
      context.handle(
        _lineAmountCentMeta,
        lineAmountCent.isAcceptableOrUnknown(
          data['line_amount_cent']!,
          _lineAmountCentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineAmountCentMeta);
    }
    if (data.containsKey('cost_price_cent')) {
      context.handle(
        _costPriceCentMeta,
        costPriceCent.isAcceptableOrUnknown(
          data['cost_price_cent']!,
          _costPriceCentMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesOrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesOrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      salesOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sales_order_id'],
      )!,
      lineNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_no'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
      unitPriceCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_cent'],
      )!,
      discountBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_bp'],
      )!,
      lineAmountCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_amount_cent'],
      )!,
      costPriceCent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_price_cent'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $SalesOrderItemsTable createAlias(String alias) {
    return $SalesOrderItemsTable(attachedDatabase, alias);
  }
}

class SalesOrderItem extends DataClass implements Insertable<SalesOrderItem> {
  final int id;
  final int salesOrderId;
  final int lineNo;
  final int productId;
  final int qty;
  final int unitPriceCent;
  final int discountBp;
  final int lineAmountCent;
  final int? costPriceCent;
  final String? note;
  const SalesOrderItem({
    required this.id,
    required this.salesOrderId,
    required this.lineNo,
    required this.productId,
    required this.qty,
    required this.unitPriceCent,
    required this.discountBp,
    required this.lineAmountCent,
    this.costPriceCent,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sales_order_id'] = Variable<int>(salesOrderId);
    map['line_no'] = Variable<int>(lineNo);
    map['product_id'] = Variable<int>(productId);
    map['qty'] = Variable<int>(qty);
    map['unit_price_cent'] = Variable<int>(unitPriceCent);
    map['discount_bp'] = Variable<int>(discountBp);
    map['line_amount_cent'] = Variable<int>(lineAmountCent);
    if (!nullToAbsent || costPriceCent != null) {
      map['cost_price_cent'] = Variable<int>(costPriceCent);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SalesOrderItemsCompanion toCompanion(bool nullToAbsent) {
    return SalesOrderItemsCompanion(
      id: Value(id),
      salesOrderId: Value(salesOrderId),
      lineNo: Value(lineNo),
      productId: Value(productId),
      qty: Value(qty),
      unitPriceCent: Value(unitPriceCent),
      discountBp: Value(discountBp),
      lineAmountCent: Value(lineAmountCent),
      costPriceCent: costPriceCent == null && nullToAbsent
          ? const Value.absent()
          : Value(costPriceCent),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory SalesOrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesOrderItem(
      id: serializer.fromJson<int>(json['id']),
      salesOrderId: serializer.fromJson<int>(json['salesOrderId']),
      lineNo: serializer.fromJson<int>(json['lineNo']),
      productId: serializer.fromJson<int>(json['productId']),
      qty: serializer.fromJson<int>(json['qty']),
      unitPriceCent: serializer.fromJson<int>(json['unitPriceCent']),
      discountBp: serializer.fromJson<int>(json['discountBp']),
      lineAmountCent: serializer.fromJson<int>(json['lineAmountCent']),
      costPriceCent: serializer.fromJson<int?>(json['costPriceCent']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'salesOrderId': serializer.toJson<int>(salesOrderId),
      'lineNo': serializer.toJson<int>(lineNo),
      'productId': serializer.toJson<int>(productId),
      'qty': serializer.toJson<int>(qty),
      'unitPriceCent': serializer.toJson<int>(unitPriceCent),
      'discountBp': serializer.toJson<int>(discountBp),
      'lineAmountCent': serializer.toJson<int>(lineAmountCent),
      'costPriceCent': serializer.toJson<int?>(costPriceCent),
      'note': serializer.toJson<String?>(note),
    };
  }

  SalesOrderItem copyWith({
    int? id,
    int? salesOrderId,
    int? lineNo,
    int? productId,
    int? qty,
    int? unitPriceCent,
    int? discountBp,
    int? lineAmountCent,
    Value<int?> costPriceCent = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => SalesOrderItem(
    id: id ?? this.id,
    salesOrderId: salesOrderId ?? this.salesOrderId,
    lineNo: lineNo ?? this.lineNo,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
    unitPriceCent: unitPriceCent ?? this.unitPriceCent,
    discountBp: discountBp ?? this.discountBp,
    lineAmountCent: lineAmountCent ?? this.lineAmountCent,
    costPriceCent: costPriceCent.present
        ? costPriceCent.value
        : this.costPriceCent,
    note: note.present ? note.value : this.note,
  );
  SalesOrderItem copyWithCompanion(SalesOrderItemsCompanion data) {
    return SalesOrderItem(
      id: data.id.present ? data.id.value : this.id,
      salesOrderId: data.salesOrderId.present
          ? data.salesOrderId.value
          : this.salesOrderId,
      lineNo: data.lineNo.present ? data.lineNo.value : this.lineNo,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
      unitPriceCent: data.unitPriceCent.present
          ? data.unitPriceCent.value
          : this.unitPriceCent,
      discountBp: data.discountBp.present
          ? data.discountBp.value
          : this.discountBp,
      lineAmountCent: data.lineAmountCent.present
          ? data.lineAmountCent.value
          : this.lineAmountCent,
      costPriceCent: data.costPriceCent.present
          ? data.costPriceCent.value
          : this.costPriceCent,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesOrderItem(')
          ..write('id: $id, ')
          ..write('salesOrderId: $salesOrderId, ')
          ..write('lineNo: $lineNo, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitPriceCent: $unitPriceCent, ')
          ..write('discountBp: $discountBp, ')
          ..write('lineAmountCent: $lineAmountCent, ')
          ..write('costPriceCent: $costPriceCent, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    salesOrderId,
    lineNo,
    productId,
    qty,
    unitPriceCent,
    discountBp,
    lineAmountCent,
    costPriceCent,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesOrderItem &&
          other.id == this.id &&
          other.salesOrderId == this.salesOrderId &&
          other.lineNo == this.lineNo &&
          other.productId == this.productId &&
          other.qty == this.qty &&
          other.unitPriceCent == this.unitPriceCent &&
          other.discountBp == this.discountBp &&
          other.lineAmountCent == this.lineAmountCent &&
          other.costPriceCent == this.costPriceCent &&
          other.note == this.note);
}

class SalesOrderItemsCompanion extends UpdateCompanion<SalesOrderItem> {
  final Value<int> id;
  final Value<int> salesOrderId;
  final Value<int> lineNo;
  final Value<int> productId;
  final Value<int> qty;
  final Value<int> unitPriceCent;
  final Value<int> discountBp;
  final Value<int> lineAmountCent;
  final Value<int?> costPriceCent;
  final Value<String?> note;
  const SalesOrderItemsCompanion({
    this.id = const Value.absent(),
    this.salesOrderId = const Value.absent(),
    this.lineNo = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.unitPriceCent = const Value.absent(),
    this.discountBp = const Value.absent(),
    this.lineAmountCent = const Value.absent(),
    this.costPriceCent = const Value.absent(),
    this.note = const Value.absent(),
  });
  SalesOrderItemsCompanion.insert({
    this.id = const Value.absent(),
    required int salesOrderId,
    required int lineNo,
    required int productId,
    required int qty,
    required int unitPriceCent,
    this.discountBp = const Value.absent(),
    required int lineAmountCent,
    this.costPriceCent = const Value.absent(),
    this.note = const Value.absent(),
  }) : salesOrderId = Value(salesOrderId),
       lineNo = Value(lineNo),
       productId = Value(productId),
       qty = Value(qty),
       unitPriceCent = Value(unitPriceCent),
       lineAmountCent = Value(lineAmountCent);
  static Insertable<SalesOrderItem> custom({
    Expression<int>? id,
    Expression<int>? salesOrderId,
    Expression<int>? lineNo,
    Expression<int>? productId,
    Expression<int>? qty,
    Expression<int>? unitPriceCent,
    Expression<int>? discountBp,
    Expression<int>? lineAmountCent,
    Expression<int>? costPriceCent,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (salesOrderId != null) 'sales_order_id': salesOrderId,
      if (lineNo != null) 'line_no': lineNo,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (unitPriceCent != null) 'unit_price_cent': unitPriceCent,
      if (discountBp != null) 'discount_bp': discountBp,
      if (lineAmountCent != null) 'line_amount_cent': lineAmountCent,
      if (costPriceCent != null) 'cost_price_cent': costPriceCent,
      if (note != null) 'note': note,
    });
  }

  SalesOrderItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? salesOrderId,
    Value<int>? lineNo,
    Value<int>? productId,
    Value<int>? qty,
    Value<int>? unitPriceCent,
    Value<int>? discountBp,
    Value<int>? lineAmountCent,
    Value<int?>? costPriceCent,
    Value<String?>? note,
  }) {
    return SalesOrderItemsCompanion(
      id: id ?? this.id,
      salesOrderId: salesOrderId ?? this.salesOrderId,
      lineNo: lineNo ?? this.lineNo,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      unitPriceCent: unitPriceCent ?? this.unitPriceCent,
      discountBp: discountBp ?? this.discountBp,
      lineAmountCent: lineAmountCent ?? this.lineAmountCent,
      costPriceCent: costPriceCent ?? this.costPriceCent,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (salesOrderId.present) {
      map['sales_order_id'] = Variable<int>(salesOrderId.value);
    }
    if (lineNo.present) {
      map['line_no'] = Variable<int>(lineNo.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (unitPriceCent.present) {
      map['unit_price_cent'] = Variable<int>(unitPriceCent.value);
    }
    if (discountBp.present) {
      map['discount_bp'] = Variable<int>(discountBp.value);
    }
    if (lineAmountCent.present) {
      map['line_amount_cent'] = Variable<int>(lineAmountCent.value);
    }
    if (costPriceCent.present) {
      map['cost_price_cent'] = Variable<int>(costPriceCent.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesOrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('salesOrderId: $salesOrderId, ')
          ..write('lineNo: $lineNo, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitPriceCent: $unitPriceCent, ')
          ..write('discountBp: $discountBp, ')
          ..write('lineAmountCent: $lineAmountCent, ')
          ..write('costPriceCent: $costPriceCent, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductCategoriesTable productCategories =
      $ProductCategoriesTable(this);
  late final $PublishersTable publishers = $PublishersTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $WarehousesTable warehouses = $WarehousesTable(this);
  late final $StockBalancesTable stockBalances = $StockBalancesTable(this);
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $PurchaseOrdersTable purchaseOrders = $PurchaseOrdersTable(this);
  late final $PurchaseOrderItemsTable purchaseOrderItems =
      $PurchaseOrderItemsTable(this);
  late final $SalesOrdersTable salesOrders = $SalesOrdersTable(this);
  late final $SalesOrderItemsTable salesOrderItems = $SalesOrderItemsTable(
    this,
  );
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  late final UserDao userDao = UserDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    products,
    productCategories,
    publishers,
    suppliers,
    customers,
    warehouses,
    stockBalances,
    stockMovements,
    purchaseOrders,
    purchaseOrderItems,
    salesOrders,
    salesOrderItems,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('products', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('products', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('products', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('products', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'product_categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('product_categories', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'product_categories',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('product_categories', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('warehouses', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('warehouses', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'warehouses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('stock_balances', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'warehouses',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('stock_balances', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('stock_balances', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('stock_balances', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'warehouses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('stock_movements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'warehouses',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('stock_movements', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('stock_movements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('stock_movements', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('stock_movements', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('stock_movements', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'suppliers',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('purchase_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'warehouses',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('purchase_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchase_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('purchase_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchase_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('purchase_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'purchase_orders',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchase_order_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'purchase_orders',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('purchase_order_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('purchase_order_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'customers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sales_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'customers',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sales_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'warehouses',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sales_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sales_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sales_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sales_orders',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sales_order_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sales_orders',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sales_order_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sales_order_items', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String password,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String role,
      required String salt,
      Value<int> status,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> password,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> role,
      Value<String> salt,
      Value<int> status,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductsTable, List<Product>>
  _createdProductsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: $_aliasNameGenerator(db.users.id, db.products.createdBy),
  );

  $$ProductsTableProcessedTableManager get createdProducts {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.createdBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_createdProductsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProductsTable, List<Product>>
  _updatedProductsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: $_aliasNameGenerator(db.users.id, db.products.updatedBy),
  );

  $$ProductsTableProcessedTableManager get updatedProducts {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.updatedBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_updatedProductsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WarehousesTable, List<Warehouse>>
  _warehouseManagersTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.warehouses,
    aliasName: $_aliasNameGenerator(db.users.id, db.warehouses.managerUserId),
  );

  $$WarehousesTableProcessedTableManager get warehouseManagers {
    final manager = $$WarehousesTableTableManager(
      $_db,
      $_db.warehouses,
    ).filter((f) => f.managerUserId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_warehouseManagersTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StockMovementsTable, List<StockMovement>>
  _stockMovementOperatorsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.stockMovements,
        aliasName: $_aliasNameGenerator(
          db.users.id,
          db.stockMovements.operatorUserId,
        ),
      );

  $$StockMovementsTableProcessedTableManager get stockMovementOperators {
    final manager = $$StockMovementsTableTableManager(
      $_db,
      $_db.stockMovements,
    ).filter((f) => f.operatorUserId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _stockMovementOperatorsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchaseOrdersTable, List<PurchaseOrder>>
  _purchaseOrdersCreatedByTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseOrders,
        aliasName: $_aliasNameGenerator(
          db.users.id,
          db.purchaseOrders.createdBy,
        ),
      );

  $$PurchaseOrdersTableProcessedTableManager get purchaseOrdersCreatedBy {
    final manager = $$PurchaseOrdersTableTableManager(
      $_db,
      $_db.purchaseOrders,
    ).filter((f) => f.createdBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseOrdersCreatedByTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchaseOrdersTable, List<PurchaseOrder>>
  _purchaseOrdersApprovedByTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseOrders,
        aliasName: $_aliasNameGenerator(
          db.users.id,
          db.purchaseOrders.approvedBy,
        ),
      );

  $$PurchaseOrdersTableProcessedTableManager get purchaseOrdersApprovedBy {
    final manager = $$PurchaseOrdersTableTableManager(
      $_db,
      $_db.purchaseOrders,
    ).filter((f) => f.approvedBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseOrdersApprovedByTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SalesOrdersTable, List<SalesOrder>>
  _salesOrdersCreatedByTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salesOrders,
    aliasName: $_aliasNameGenerator(db.users.id, db.salesOrders.createdBy),
  );

  $$SalesOrdersTableProcessedTableManager get salesOrdersCreatedBy {
    final manager = $$SalesOrdersTableTableManager(
      $_db,
      $_db.salesOrders,
    ).filter((f) => f.createdBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _salesOrdersCreatedByTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get salt => $composableBuilder(
    column: $table.salt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> createdProducts(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> updatedProducts(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.updatedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> warehouseManagers(
    Expression<bool> Function($$WarehousesTableFilterComposer f) f,
  ) {
    final $$WarehousesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.managerUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableFilterComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockMovementOperators(
    Expression<bool> Function($$StockMovementsTableFilterComposer f) f,
  ) {
    final $$StockMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.operatorUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableFilterComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseOrdersCreatedBy(
    Expression<bool> Function($$PurchaseOrdersTableFilterComposer f) f,
  ) {
    final $$PurchaseOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseOrdersApprovedBy(
    Expression<bool> Function($$PurchaseOrdersTableFilterComposer f) f,
  ) {
    final $$PurchaseOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.approvedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> salesOrdersCreatedBy(
    Expression<bool> Function($$SalesOrdersTableFilterComposer f) f,
  ) {
    final $$SalesOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrders,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrdersTableFilterComposer(
            $db: $db,
            $table: $db.salesOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get salt => $composableBuilder(
    column: $table.salt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get salt =>
      $composableBuilder(column: $table.salt, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> createdProducts<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> updatedProducts<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.updatedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> warehouseManagers<T extends Object>(
    Expression<T> Function($$WarehousesTableAnnotationComposer a) f,
  ) {
    final $$WarehousesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.managerUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableAnnotationComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockMovementOperators<T extends Object>(
    Expression<T> Function($$StockMovementsTableAnnotationComposer a) f,
  ) {
    final $$StockMovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.operatorUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchaseOrdersCreatedBy<T extends Object>(
    Expression<T> Function($$PurchaseOrdersTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchaseOrdersApprovedBy<T extends Object>(
    Expression<T> Function($$PurchaseOrdersTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.approvedBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> salesOrdersCreatedBy<T extends Object>(
    Expression<T> Function($$SalesOrdersTableAnnotationComposer a) f,
  ) {
    final $$SalesOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrders,
      getReferencedColumn: (t) => t.createdBy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.salesOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool createdProducts,
            bool updatedProducts,
            bool warehouseManagers,
            bool stockMovementOperators,
            bool purchaseOrdersCreatedBy,
            bool purchaseOrdersApprovedBy,
            bool salesOrdersCreatedBy,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> salt = const Value.absent(),
                Value<int> status = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                password: password,
                email: email,
                phone: phone,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                role: role,
                salt: salt,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String password,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String role,
                required String salt,
                Value<int> status = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                password: password,
                email: email,
                phone: phone,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                role: role,
                salt: salt,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                createdProducts = false,
                updatedProducts = false,
                warehouseManagers = false,
                stockMovementOperators = false,
                purchaseOrdersCreatedBy = false,
                purchaseOrdersApprovedBy = false,
                salesOrdersCreatedBy = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (createdProducts) db.products,
                    if (updatedProducts) db.products,
                    if (warehouseManagers) db.warehouses,
                    if (stockMovementOperators) db.stockMovements,
                    if (purchaseOrdersCreatedBy) db.purchaseOrders,
                    if (purchaseOrdersApprovedBy) db.purchaseOrders,
                    if (salesOrdersCreatedBy) db.salesOrders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (createdProducts)
                        await $_getPrefetchedData<User, $UsersTable, Product>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._createdProductsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).createdProducts,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.createdBy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (updatedProducts)
                        await $_getPrefetchedData<User, $UsersTable, Product>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._updatedProductsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).updatedProducts,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.updatedBy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (warehouseManagers)
                        await $_getPrefetchedData<User, $UsersTable, Warehouse>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._warehouseManagersTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).warehouseManagers,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.managerUserId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (stockMovementOperators)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          StockMovement
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._stockMovementOperatorsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).stockMovementOperators,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.operatorUserId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseOrdersCreatedBy)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          PurchaseOrder
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._purchaseOrdersCreatedByTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseOrdersCreatedBy,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.createdBy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseOrdersApprovedBy)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          PurchaseOrder
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._purchaseOrdersApprovedByTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseOrdersApprovedBy,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.approvedBy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (salesOrdersCreatedBy)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          SalesOrder
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._salesOrdersCreatedByTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).salesOrdersCreatedBy,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.createdBy == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool createdProducts,
        bool updatedProducts,
        bool warehouseManagers,
        bool stockMovementOperators,
        bool purchaseOrdersCreatedBy,
        bool purchaseOrdersApprovedBy,
        bool salesOrdersCreatedBy,
      })
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String title,
      required String author,
      Value<String?> isbn,
      Value<String?> category,
      required double price,
      Value<String?> publisher,
      required String productId,
      Value<double?> internalPricing,
      required String selfEncoding,
      Value<double?> purchasePrice,
      Value<int?> publicationYear,
      Value<double?> retailDiscount,
      Value<double?> wholesaleDiscount,
      Value<double?> wholesalePrice,
      Value<double?> memberDiscount,
      Value<String?> purchaseSaleMode,
      Value<String?> bookmark,
      Value<String?> packaging,
      Value<String?> properity,
      Value<String?> statisticalClass,
      Value<int?> createdBy,
      Value<int?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> author,
      Value<String?> isbn,
      Value<String?> category,
      Value<double> price,
      Value<String?> publisher,
      Value<String> productId,
      Value<double?> internalPricing,
      Value<String> selfEncoding,
      Value<double?> purchasePrice,
      Value<int?> publicationYear,
      Value<double?> retailDiscount,
      Value<double?> wholesaleDiscount,
      Value<double?> wholesalePrice,
      Value<double?> memberDiscount,
      Value<String?> purchaseSaleMode,
      Value<String?> bookmark,
      Value<String?> packaging,
      Value<String?> properity,
      Value<String?> statisticalClass,
      Value<int?> createdBy,
      Value<int?> updatedBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _createdByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.products.createdBy, db.users.id),
  );

  $$UsersTableProcessedTableManager? get createdBy {
    final $_column = $_itemColumn<int>('created_by');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _updatedByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.products.updatedBy, db.users.id),
  );

  $$UsersTableProcessedTableManager? get updatedBy {
    final $_column = $_itemColumn<int>('updated_by');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_updatedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StockBalancesTable, List<StockBalance>>
  _stockBalancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockBalances,
    aliasName: $_aliasNameGenerator(db.products.id, db.stockBalances.productId),
  );

  $$StockBalancesTableProcessedTableManager get stockBalancesRefs {
    final manager = $$StockBalancesTableTableManager(
      $_db,
      $_db.stockBalances,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockBalancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StockMovementsTable, List<StockMovement>>
  _stockMovementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockMovements,
    aliasName: $_aliasNameGenerator(
      db.products.id,
      db.stockMovements.productId,
    ),
  );

  $$StockMovementsTableProcessedTableManager get stockMovementsRefs {
    final manager = $$StockMovementsTableTableManager(
      $_db,
      $_db.stockMovements,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchaseOrderItemsTable, List<PurchaseOrderItem>>
  _purchaseOrderItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseOrderItems,
        aliasName: $_aliasNameGenerator(
          db.products.id,
          db.purchaseOrderItems.productId,
        ),
      );

  $$PurchaseOrderItemsTableProcessedTableManager get purchaseOrderItemsRefs {
    final manager = $$PurchaseOrderItemsTableTableManager(
      $_db,
      $_db.purchaseOrderItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseOrderItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SalesOrderItemsTable, List<SalesOrderItem>>
  _salesOrderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salesOrderItems,
    aliasName: $_aliasNameGenerator(
      db.products.id,
      db.salesOrderItems.productId,
    ),
  );

  $$SalesOrderItemsTableProcessedTableManager get salesOrderItemsRefs {
    final manager = $$SalesOrderItemsTableTableManager(
      $_db,
      $_db.salesOrderItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _salesOrderItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isbn => $composableBuilder(
    column: $table.isbn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<double, double, int> get price =>
      $composableBuilder(
        column: $table.price,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<double?, double, int> get internalPricing =>
      $composableBuilder(
        column: $table.internalPricing,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get selfEncoding => $composableBuilder(
    column: $table.selfEncoding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<double?, double, int> get purchasePrice =>
      $composableBuilder(
        column: $table.purchasePrice,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get publicationYear => $composableBuilder(
    column: $table.publicationYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<double?, double, int> get retailDiscount =>
      $composableBuilder(
        column: $table.retailDiscount,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<double?, double, int> get wholesaleDiscount =>
      $composableBuilder(
        column: $table.wholesaleDiscount,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<double?, double, int> get wholesalePrice =>
      $composableBuilder(
        column: $table.wholesalePrice,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<double?, double, int> get memberDiscount =>
      $composableBuilder(
        column: $table.memberDiscount,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get purchaseSaleMode => $composableBuilder(
    column: $table.purchaseSaleMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookmark => $composableBuilder(
    column: $table.bookmark,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packaging => $composableBuilder(
    column: $table.packaging,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get properity => $composableBuilder(
    column: $table.properity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statisticalClass => $composableBuilder(
    column: $table.statisticalClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get createdBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get updatedBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.updatedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> stockBalancesRefs(
    Expression<bool> Function($$StockBalancesTableFilterComposer f) f,
  ) {
    final $$StockBalancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockBalances,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockBalancesTableFilterComposer(
            $db: $db,
            $table: $db.stockBalances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockMovementsRefs(
    Expression<bool> Function($$StockMovementsTableFilterComposer f) f,
  ) {
    final $$StockMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableFilterComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseOrderItemsRefs(
    Expression<bool> Function($$PurchaseOrderItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseOrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrderItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> salesOrderItemsRefs(
    Expression<bool> Function($$SalesOrderItemsTableFilterComposer f) f,
  ) {
    final $$SalesOrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrderItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.salesOrderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isbn => $composableBuilder(
    column: $table.isbn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get internalPricing => $composableBuilder(
    column: $table.internalPricing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selfEncoding => $composableBuilder(
    column: $table.selfEncoding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get publicationYear => $composableBuilder(
    column: $table.publicationYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retailDiscount => $composableBuilder(
    column: $table.retailDiscount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wholesaleDiscount => $composableBuilder(
    column: $table.wholesaleDiscount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get memberDiscount => $composableBuilder(
    column: $table.memberDiscount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseSaleMode => $composableBuilder(
    column: $table.purchaseSaleMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookmark => $composableBuilder(
    column: $table.bookmark,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packaging => $composableBuilder(
    column: $table.packaging,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get properity => $composableBuilder(
    column: $table.properity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statisticalClass => $composableBuilder(
    column: $table.statisticalClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get createdBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get updatedBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.updatedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get isbn =>
      $composableBuilder(column: $table.isbn, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumnWithTypeConverter<double, int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<double?, int> get internalPricing =>
      $composableBuilder(
        column: $table.internalPricing,
        builder: (column) => column,
      );

  GeneratedColumn<String> get selfEncoding => $composableBuilder(
    column: $table.selfEncoding,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<double?, int> get purchasePrice =>
      $composableBuilder(
        column: $table.purchasePrice,
        builder: (column) => column,
      );

  GeneratedColumn<int> get publicationYear => $composableBuilder(
    column: $table.publicationYear,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<double?, int> get retailDiscount =>
      $composableBuilder(
        column: $table.retailDiscount,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<double?, int> get wholesaleDiscount =>
      $composableBuilder(
        column: $table.wholesaleDiscount,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<double?, int> get wholesalePrice =>
      $composableBuilder(
        column: $table.wholesalePrice,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<double?, int> get memberDiscount =>
      $composableBuilder(
        column: $table.memberDiscount,
        builder: (column) => column,
      );

  GeneratedColumn<String> get purchaseSaleMode => $composableBuilder(
    column: $table.purchaseSaleMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bookmark =>
      $composableBuilder(column: $table.bookmark, builder: (column) => column);

  GeneratedColumn<String> get packaging =>
      $composableBuilder(column: $table.packaging, builder: (column) => column);

  GeneratedColumn<String> get properity =>
      $composableBuilder(column: $table.properity, builder: (column) => column);

  GeneratedColumn<String> get statisticalClass => $composableBuilder(
    column: $table.statisticalClass,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get createdBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get updatedBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.updatedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> stockBalancesRefs<T extends Object>(
    Expression<T> Function($$StockBalancesTableAnnotationComposer a) f,
  ) {
    final $$StockBalancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockBalances,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockBalancesTableAnnotationComposer(
            $db: $db,
            $table: $db.stockBalances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockMovementsRefs<T extends Object>(
    Expression<T> Function($$StockMovementsTableAnnotationComposer a) f,
  ) {
    final $$StockMovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchaseOrderItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseOrderItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrderItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseOrderItems,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseOrderItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseOrderItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> salesOrderItemsRefs<T extends Object>(
    Expression<T> Function($$SalesOrderItemsTableAnnotationComposer a) f,
  ) {
    final $$SalesOrderItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrderItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrderItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.salesOrderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool createdBy,
            bool updatedBy,
            bool stockBalancesRefs,
            bool stockMovementsRefs,
            bool purchaseOrderItemsRefs,
            bool salesOrderItemsRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String?> isbn = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<double?> internalPricing = const Value.absent(),
                Value<String> selfEncoding = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<int?> publicationYear = const Value.absent(),
                Value<double?> retailDiscount = const Value.absent(),
                Value<double?> wholesaleDiscount = const Value.absent(),
                Value<double?> wholesalePrice = const Value.absent(),
                Value<double?> memberDiscount = const Value.absent(),
                Value<String?> purchaseSaleMode = const Value.absent(),
                Value<String?> bookmark = const Value.absent(),
                Value<String?> packaging = const Value.absent(),
                Value<String?> properity = const Value.absent(),
                Value<String?> statisticalClass = const Value.absent(),
                Value<int?> createdBy = const Value.absent(),
                Value<int?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                title: title,
                author: author,
                isbn: isbn,
                category: category,
                price: price,
                publisher: publisher,
                productId: productId,
                internalPricing: internalPricing,
                selfEncoding: selfEncoding,
                purchasePrice: purchasePrice,
                publicationYear: publicationYear,
                retailDiscount: retailDiscount,
                wholesaleDiscount: wholesaleDiscount,
                wholesalePrice: wholesalePrice,
                memberDiscount: memberDiscount,
                purchaseSaleMode: purchaseSaleMode,
                bookmark: bookmark,
                packaging: packaging,
                properity: properity,
                statisticalClass: statisticalClass,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String author,
                Value<String?> isbn = const Value.absent(),
                Value<String?> category = const Value.absent(),
                required double price,
                Value<String?> publisher = const Value.absent(),
                required String productId,
                Value<double?> internalPricing = const Value.absent(),
                required String selfEncoding,
                Value<double?> purchasePrice = const Value.absent(),
                Value<int?> publicationYear = const Value.absent(),
                Value<double?> retailDiscount = const Value.absent(),
                Value<double?> wholesaleDiscount = const Value.absent(),
                Value<double?> wholesalePrice = const Value.absent(),
                Value<double?> memberDiscount = const Value.absent(),
                Value<String?> purchaseSaleMode = const Value.absent(),
                Value<String?> bookmark = const Value.absent(),
                Value<String?> packaging = const Value.absent(),
                Value<String?> properity = const Value.absent(),
                Value<String?> statisticalClass = const Value.absent(),
                Value<int?> createdBy = const Value.absent(),
                Value<int?> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                title: title,
                author: author,
                isbn: isbn,
                category: category,
                price: price,
                publisher: publisher,
                productId: productId,
                internalPricing: internalPricing,
                selfEncoding: selfEncoding,
                purchasePrice: purchasePrice,
                publicationYear: publicationYear,
                retailDiscount: retailDiscount,
                wholesaleDiscount: wholesaleDiscount,
                wholesalePrice: wholesalePrice,
                memberDiscount: memberDiscount,
                purchaseSaleMode: purchaseSaleMode,
                bookmark: bookmark,
                packaging: packaging,
                properity: properity,
                statisticalClass: statisticalClass,
                createdBy: createdBy,
                updatedBy: updatedBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                createdBy = false,
                updatedBy = false,
                stockBalancesRefs = false,
                stockMovementsRefs = false,
                purchaseOrderItemsRefs = false,
                salesOrderItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (stockBalancesRefs) db.stockBalances,
                    if (stockMovementsRefs) db.stockMovements,
                    if (purchaseOrderItemsRefs) db.purchaseOrderItems,
                    if (salesOrderItemsRefs) db.salesOrderItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (createdBy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.createdBy,
                                    referencedTable: $$ProductsTableReferences
                                        ._createdByTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._createdByTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (updatedBy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.updatedBy,
                                    referencedTable: $$ProductsTableReferences
                                        ._updatedByTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._updatedByTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (stockBalancesRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          StockBalance
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._stockBalancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).stockBalancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (stockMovementsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          StockMovement
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._stockMovementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).stockMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseOrderItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          PurchaseOrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._purchaseOrderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseOrderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (salesOrderItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          SalesOrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._salesOrderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).salesOrderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool createdBy,
        bool updatedBy,
        bool stockBalancesRefs,
        bool stockMovementsRefs,
        bool purchaseOrderItemsRefs,
        bool salesOrderItemsRefs,
      })
    >;
typedef $$ProductCategoriesTableCreateCompanionBuilder =
    ProductCategoriesCompanion Function({
      Value<int> id,
      Value<int?> parentId,
      required String code,
      required String name,
      Value<int> sortOrder,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ProductCategoriesTableUpdateCompanionBuilder =
    ProductCategoriesCompanion Function({
      Value<int> id,
      Value<int?> parentId,
      Value<String> code,
      Value<String> name,
      Value<int> sortOrder,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ProductCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductCategoriesTable,
          ProductCategory
        > {
  $$ProductCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductCategoriesTable _parentIdTable(_$AppDatabase db) =>
      db.productCategories.createAlias(
        $_aliasNameGenerator(
          db.productCategories.parentId,
          db.productCategories.id,
        ),
      );

  $$ProductCategoriesTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<int>('parent_id');
    if ($_column == null) return null;
    final manager = $$ProductCategoriesTableTableManager(
      $_db,
      $_db.productCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductCategoriesTableFilterComposer get parentId {
    final $$ProductCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.productCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.productCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductCategoriesTableOrderingComposer get parentId {
    final $$ProductCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.productCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.productCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProductCategoriesTableAnnotationComposer get parentId {
    final $$ProductCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.parentId,
          referencedTable: $db.productCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.productCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ProductCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductCategoriesTable,
          ProductCategory,
          $$ProductCategoriesTableFilterComposer,
          $$ProductCategoriesTableOrderingComposer,
          $$ProductCategoriesTableAnnotationComposer,
          $$ProductCategoriesTableCreateCompanionBuilder,
          $$ProductCategoriesTableUpdateCompanionBuilder,
          (ProductCategory, $$ProductCategoriesTableReferences),
          ProductCategory,
          PrefetchHooks Function({bool parentId})
        > {
  $$ProductCategoriesTableTableManager(
    _$AppDatabase db,
    $ProductCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProductCategoriesCompanion(
                id: id,
                parentId: parentId,
                code: code,
                name: name,
                sortOrder: sortOrder,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                required String code,
                required String name,
                Value<int> sortOrder = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProductCategoriesCompanion.insert(
                id: id,
                parentId: parentId,
                code: code,
                name: name,
                sortOrder: sortOrder,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (parentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.parentId,
                                referencedTable:
                                    $$ProductCategoriesTableReferences
                                        ._parentIdTable(db),
                                referencedColumn:
                                    $$ProductCategoriesTableReferences
                                        ._parentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductCategoriesTable,
      ProductCategory,
      $$ProductCategoriesTableFilterComposer,
      $$ProductCategoriesTableOrderingComposer,
      $$ProductCategoriesTableAnnotationComposer,
      $$ProductCategoriesTableCreateCompanionBuilder,
      $$ProductCategoriesTableUpdateCompanionBuilder,
      (ProductCategory, $$ProductCategoriesTableReferences),
      ProductCategory,
      PrefetchHooks Function({bool parentId})
    >;
typedef $$PublishersTableCreateCompanionBuilder =
    PublishersCompanion Function({
      Value<int> id,
      Value<String?> code,
      required String name,
      Value<String?> contactName,
      Value<String?> phone,
      Value<String?> address,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$PublishersTableUpdateCompanionBuilder =
    PublishersCompanion Function({
      Value<int> id,
      Value<String?> code,
      Value<String> name,
      Value<String?> contactName,
      Value<String?> phone,
      Value<String?> address,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$PublishersTableFilterComposer
    extends Composer<_$AppDatabase, $PublishersTable> {
  $$PublishersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PublishersTableOrderingComposer
    extends Composer<_$AppDatabase, $PublishersTable> {
  $$PublishersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PublishersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PublishersTable> {
  $$PublishersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PublishersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PublishersTable,
          Publisher,
          $$PublishersTableFilterComposer,
          $$PublishersTableOrderingComposer,
          $$PublishersTableAnnotationComposer,
          $$PublishersTableCreateCompanionBuilder,
          $$PublishersTableUpdateCompanionBuilder,
          (
            Publisher,
            BaseReferences<_$AppDatabase, $PublishersTable, Publisher>,
          ),
          Publisher,
          PrefetchHooks Function()
        > {
  $$PublishersTableTableManager(_$AppDatabase db, $PublishersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PublishersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PublishersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PublishersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PublishersCompanion(
                id: id,
                code: code,
                name: name,
                contactName: contactName,
                phone: phone,
                address: address,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> code = const Value.absent(),
                required String name,
                Value<String?> contactName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PublishersCompanion.insert(
                id: id,
                code: code,
                name: name,
                contactName: contactName,
                phone: phone,
                address: address,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PublishersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PublishersTable,
      Publisher,
      $$PublishersTableFilterComposer,
      $$PublishersTableOrderingComposer,
      $$PublishersTableAnnotationComposer,
      $$PublishersTableCreateCompanionBuilder,
      $$PublishersTableUpdateCompanionBuilder,
      (Publisher, BaseReferences<_$AppDatabase, $PublishersTable, Publisher>),
      Publisher,
      PrefetchHooks Function()
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      Value<String?> contactName,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> settlementTerm,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<String?> contactName,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> settlementTerm,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SuppliersTableReferences
    extends BaseReferences<_$AppDatabase, $SuppliersTable, Supplier> {
  $$SuppliersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PurchaseOrdersTable, List<PurchaseOrder>>
  _purchaseOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseOrders,
    aliasName: $_aliasNameGenerator(
      db.suppliers.id,
      db.purchaseOrders.supplierId,
    ),
  );

  $$PurchaseOrdersTableProcessedTableManager get purchaseOrdersRefs {
    final manager = $$PurchaseOrdersTableTableManager(
      $_db,
      $_db.purchaseOrders,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settlementTerm => $composableBuilder(
    column: $table.settlementTerm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchaseOrdersRefs(
    Expression<bool> Function($$PurchaseOrdersTableFilterComposer f) f,
  ) {
    final $$PurchaseOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settlementTerm => $composableBuilder(
    column: $table.settlementTerm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get settlementTerm => $composableBuilder(
    column: $table.settlementTerm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> purchaseOrdersRefs<T extends Object>(
    Expression<T> Function($$PurchaseOrdersTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, $$SuppliersTableReferences),
          Supplier,
          PrefetchHooks Function({bool purchaseOrdersRefs})
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> settlementTerm = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                code: code,
                name: name,
                contactName: contactName,
                phone: phone,
                address: address,
                settlementTerm: settlementTerm,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                Value<String?> contactName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> settlementTerm = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                code: code,
                name: name,
                contactName: contactName,
                phone: phone,
                address: address,
                settlementTerm: settlementTerm,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SuppliersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseOrdersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (purchaseOrdersRefs) db.purchaseOrders,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchaseOrdersRefs)
                    await $_getPrefetchedData<
                      Supplier,
                      $SuppliersTable,
                      PurchaseOrder
                    >(
                      currentTable: table,
                      referencedTable: $$SuppliersTableReferences
                          ._purchaseOrdersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SuppliersTableReferences(
                            db,
                            table,
                            p0,
                          ).purchaseOrdersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.supplierId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, $$SuppliersTableReferences),
      Supplier,
      PrefetchHooks Function({bool purchaseOrdersRefs})
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      Value<String> customerType,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String?> memberLevel,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<String> customerType,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String?> memberLevel,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SalesOrdersTable, List<SalesOrder>>
  _salesOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salesOrders,
    aliasName: $_aliasNameGenerator(db.customers.id, db.salesOrders.customerId),
  );

  $$SalesOrdersTableProcessedTableManager get salesOrdersRefs {
    final manager = $$SalesOrdersTableTableManager(
      $_db,
      $_db.salesOrders,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_salesOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerType => $composableBuilder(
    column: $table.customerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberLevel => $composableBuilder(
    column: $table.memberLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> salesOrdersRefs(
    Expression<bool> Function($$SalesOrdersTableFilterComposer f) f,
  ) {
    final $$SalesOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrders,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrdersTableFilterComposer(
            $db: $db,
            $table: $db.salesOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerType => $composableBuilder(
    column: $table.customerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberLevel => $composableBuilder(
    column: $table.memberLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get customerType => $composableBuilder(
    column: $table.customerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get memberLevel => $composableBuilder(
    column: $table.memberLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> salesOrdersRefs<T extends Object>(
    Expression<T> Function($$SalesOrdersTableAnnotationComposer a) f,
  ) {
    final $$SalesOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrders,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.salesOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool salesOrdersRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> customerType = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> memberLevel = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                code: code,
                name: name,
                customerType: customerType,
                phone: phone,
                email: email,
                address: address,
                memberLevel: memberLevel,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                Value<String> customerType = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> memberLevel = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                code: code,
                name: name,
                customerType: customerType,
                phone: phone,
                email: email,
                address: address,
                memberLevel: memberLevel,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({salesOrdersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (salesOrdersRefs) db.salesOrders],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (salesOrdersRefs)
                    await $_getPrefetchedData<
                      Customer,
                      $CustomersTable,
                      SalesOrder
                    >(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._salesOrdersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomersTableReferences(
                            db,
                            table,
                            p0,
                          ).salesOrdersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.customerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool salesOrdersRefs})
    >;
typedef $$WarehousesTableCreateCompanionBuilder =
    WarehousesCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      Value<String?> address,
      Value<int?> managerUserId,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$WarehousesTableUpdateCompanionBuilder =
    WarehousesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<String?> address,
      Value<int?> managerUserId,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$WarehousesTableReferences
    extends BaseReferences<_$AppDatabase, $WarehousesTable, Warehouse> {
  $$WarehousesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _managerUserIdTable(_$AppDatabase db) =>
      db.users.createAlias(
        $_aliasNameGenerator(db.warehouses.managerUserId, db.users.id),
      );

  $$UsersTableProcessedTableManager? get managerUserId {
    final $_column = $_itemColumn<int>('manager_user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_managerUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StockBalancesTable, List<StockBalance>>
  _stockBalancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockBalances,
    aliasName: $_aliasNameGenerator(
      db.warehouses.id,
      db.stockBalances.warehouseId,
    ),
  );

  $$StockBalancesTableProcessedTableManager get stockBalancesRefs {
    final manager = $$StockBalancesTableTableManager(
      $_db,
      $_db.stockBalances,
    ).filter((f) => f.warehouseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockBalancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StockMovementsTable, List<StockMovement>>
  _stockMovementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockMovements,
    aliasName: $_aliasNameGenerator(
      db.warehouses.id,
      db.stockMovements.warehouseId,
    ),
  );

  $$StockMovementsTableProcessedTableManager get stockMovementsRefs {
    final manager = $$StockMovementsTableTableManager(
      $_db,
      $_db.stockMovements,
    ).filter((f) => f.warehouseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchaseOrdersTable, List<PurchaseOrder>>
  _purchaseOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseOrders,
    aliasName: $_aliasNameGenerator(
      db.warehouses.id,
      db.purchaseOrders.warehouseId,
    ),
  );

  $$PurchaseOrdersTableProcessedTableManager get purchaseOrdersRefs {
    final manager = $$PurchaseOrdersTableTableManager(
      $_db,
      $_db.purchaseOrders,
    ).filter((f) => f.warehouseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SalesOrdersTable, List<SalesOrder>>
  _salesOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salesOrders,
    aliasName: $_aliasNameGenerator(
      db.warehouses.id,
      db.salesOrders.warehouseId,
    ),
  );

  $$SalesOrdersTableProcessedTableManager get salesOrdersRefs {
    final manager = $$SalesOrdersTableTableManager(
      $_db,
      $_db.salesOrders,
    ).filter((f) => f.warehouseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_salesOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WarehousesTableFilterComposer
    extends Composer<_$AppDatabase, $WarehousesTable> {
  $$WarehousesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get managerUserId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> stockBalancesRefs(
    Expression<bool> Function($$StockBalancesTableFilterComposer f) f,
  ) {
    final $$StockBalancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockBalances,
      getReferencedColumn: (t) => t.warehouseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockBalancesTableFilterComposer(
            $db: $db,
            $table: $db.stockBalances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockMovementsRefs(
    Expression<bool> Function($$StockMovementsTableFilterComposer f) f,
  ) {
    final $$StockMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.warehouseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableFilterComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseOrdersRefs(
    Expression<bool> Function($$PurchaseOrdersTableFilterComposer f) f,
  ) {
    final $$PurchaseOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.warehouseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> salesOrdersRefs(
    Expression<bool> Function($$SalesOrdersTableFilterComposer f) f,
  ) {
    final $$SalesOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrders,
      getReferencedColumn: (t) => t.warehouseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrdersTableFilterComposer(
            $db: $db,
            $table: $db.salesOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WarehousesTableOrderingComposer
    extends Composer<_$AppDatabase, $WarehousesTable> {
  $$WarehousesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get managerUserId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WarehousesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WarehousesTable> {
  $$WarehousesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get managerUserId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> stockBalancesRefs<T extends Object>(
    Expression<T> Function($$StockBalancesTableAnnotationComposer a) f,
  ) {
    final $$StockBalancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockBalances,
      getReferencedColumn: (t) => t.warehouseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockBalancesTableAnnotationComposer(
            $db: $db,
            $table: $db.stockBalances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockMovementsRefs<T extends Object>(
    Expression<T> Function($$StockMovementsTableAnnotationComposer a) f,
  ) {
    final $$StockMovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.warehouseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchaseOrdersRefs<T extends Object>(
    Expression<T> Function($$PurchaseOrdersTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.warehouseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> salesOrdersRefs<T extends Object>(
    Expression<T> Function($$SalesOrdersTableAnnotationComposer a) f,
  ) {
    final $$SalesOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrders,
      getReferencedColumn: (t) => t.warehouseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.salesOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WarehousesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WarehousesTable,
          Warehouse,
          $$WarehousesTableFilterComposer,
          $$WarehousesTableOrderingComposer,
          $$WarehousesTableAnnotationComposer,
          $$WarehousesTableCreateCompanionBuilder,
          $$WarehousesTableUpdateCompanionBuilder,
          (Warehouse, $$WarehousesTableReferences),
          Warehouse,
          PrefetchHooks Function({
            bool managerUserId,
            bool stockBalancesRefs,
            bool stockMovementsRefs,
            bool purchaseOrdersRefs,
            bool salesOrdersRefs,
          })
        > {
  $$WarehousesTableTableManager(_$AppDatabase db, $WarehousesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WarehousesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WarehousesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WarehousesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int?> managerUserId = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WarehousesCompanion(
                id: id,
                code: code,
                name: name,
                address: address,
                managerUserId: managerUserId,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                Value<String?> address = const Value.absent(),
                Value<int?> managerUserId = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WarehousesCompanion.insert(
                id: id,
                code: code,
                name: name,
                address: address,
                managerUserId: managerUserId,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WarehousesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                managerUserId = false,
                stockBalancesRefs = false,
                stockMovementsRefs = false,
                purchaseOrdersRefs = false,
                salesOrdersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (stockBalancesRefs) db.stockBalances,
                    if (stockMovementsRefs) db.stockMovements,
                    if (purchaseOrdersRefs) db.purchaseOrders,
                    if (salesOrdersRefs) db.salesOrders,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (managerUserId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.managerUserId,
                                    referencedTable: $$WarehousesTableReferences
                                        ._managerUserIdTable(db),
                                    referencedColumn:
                                        $$WarehousesTableReferences
                                            ._managerUserIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (stockBalancesRefs)
                        await $_getPrefetchedData<
                          Warehouse,
                          $WarehousesTable,
                          StockBalance
                        >(
                          currentTable: table,
                          referencedTable: $$WarehousesTableReferences
                              ._stockBalancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WarehousesTableReferences(
                                db,
                                table,
                                p0,
                              ).stockBalancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.warehouseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (stockMovementsRefs)
                        await $_getPrefetchedData<
                          Warehouse,
                          $WarehousesTable,
                          StockMovement
                        >(
                          currentTable: table,
                          referencedTable: $$WarehousesTableReferences
                              ._stockMovementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WarehousesTableReferences(
                                db,
                                table,
                                p0,
                              ).stockMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.warehouseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseOrdersRefs)
                        await $_getPrefetchedData<
                          Warehouse,
                          $WarehousesTable,
                          PurchaseOrder
                        >(
                          currentTable: table,
                          referencedTable: $$WarehousesTableReferences
                              ._purchaseOrdersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WarehousesTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseOrdersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.warehouseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (salesOrdersRefs)
                        await $_getPrefetchedData<
                          Warehouse,
                          $WarehousesTable,
                          SalesOrder
                        >(
                          currentTable: table,
                          referencedTable: $$WarehousesTableReferences
                              ._salesOrdersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WarehousesTableReferences(
                                db,
                                table,
                                p0,
                              ).salesOrdersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.warehouseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WarehousesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WarehousesTable,
      Warehouse,
      $$WarehousesTableFilterComposer,
      $$WarehousesTableOrderingComposer,
      $$WarehousesTableAnnotationComposer,
      $$WarehousesTableCreateCompanionBuilder,
      $$WarehousesTableUpdateCompanionBuilder,
      (Warehouse, $$WarehousesTableReferences),
      Warehouse,
      PrefetchHooks Function({
        bool managerUserId,
        bool stockBalancesRefs,
        bool stockMovementsRefs,
        bool purchaseOrdersRefs,
        bool salesOrdersRefs,
      })
    >;
typedef $$StockBalancesTableCreateCompanionBuilder =
    StockBalancesCompanion Function({
      Value<int> id,
      required int warehouseId,
      required int productId,
      Value<int> onHandQty,
      Value<int> reservedQty,
      Value<int> safetyStockQty,
      Value<String?> shelfCode,
      Value<DateTime> updatedAt,
    });
typedef $$StockBalancesTableUpdateCompanionBuilder =
    StockBalancesCompanion Function({
      Value<int> id,
      Value<int> warehouseId,
      Value<int> productId,
      Value<int> onHandQty,
      Value<int> reservedQty,
      Value<int> safetyStockQty,
      Value<String?> shelfCode,
      Value<DateTime> updatedAt,
    });

final class $$StockBalancesTableReferences
    extends BaseReferences<_$AppDatabase, $StockBalancesTable, StockBalance> {
  $$StockBalancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WarehousesTable _warehouseIdTable(_$AppDatabase db) =>
      db.warehouses.createAlias(
        $_aliasNameGenerator(db.stockBalances.warehouseId, db.warehouses.id),
      );

  $$WarehousesTableProcessedTableManager get warehouseId {
    final $_column = $_itemColumn<int>('warehouse_id')!;

    final manager = $$WarehousesTableTableManager(
      $_db,
      $_db.warehouses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_warehouseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.stockBalances.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StockBalancesTableFilterComposer
    extends Composer<_$AppDatabase, $StockBalancesTable> {
  $$StockBalancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get onHandQty => $composableBuilder(
    column: $table.onHandQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reservedQty => $composableBuilder(
    column: $table.reservedQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get safetyStockQty => $composableBuilder(
    column: $table.safetyStockQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shelfCode => $composableBuilder(
    column: $table.shelfCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WarehousesTableFilterComposer get warehouseId {
    final $$WarehousesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableFilterComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockBalancesTableOrderingComposer
    extends Composer<_$AppDatabase, $StockBalancesTable> {
  $$StockBalancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get onHandQty => $composableBuilder(
    column: $table.onHandQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reservedQty => $composableBuilder(
    column: $table.reservedQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get safetyStockQty => $composableBuilder(
    column: $table.safetyStockQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shelfCode => $composableBuilder(
    column: $table.shelfCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WarehousesTableOrderingComposer get warehouseId {
    final $$WarehousesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableOrderingComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockBalancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockBalancesTable> {
  $$StockBalancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get onHandQty =>
      $composableBuilder(column: $table.onHandQty, builder: (column) => column);

  GeneratedColumn<int> get reservedQty => $composableBuilder(
    column: $table.reservedQty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get safetyStockQty => $composableBuilder(
    column: $table.safetyStockQty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shelfCode =>
      $composableBuilder(column: $table.shelfCode, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WarehousesTableAnnotationComposer get warehouseId {
    final $$WarehousesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableAnnotationComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockBalancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockBalancesTable,
          StockBalance,
          $$StockBalancesTableFilterComposer,
          $$StockBalancesTableOrderingComposer,
          $$StockBalancesTableAnnotationComposer,
          $$StockBalancesTableCreateCompanionBuilder,
          $$StockBalancesTableUpdateCompanionBuilder,
          (StockBalance, $$StockBalancesTableReferences),
          StockBalance,
          PrefetchHooks Function({bool warehouseId, bool productId})
        > {
  $$StockBalancesTableTableManager(_$AppDatabase db, $StockBalancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockBalancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockBalancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockBalancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> warehouseId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> onHandQty = const Value.absent(),
                Value<int> reservedQty = const Value.absent(),
                Value<int> safetyStockQty = const Value.absent(),
                Value<String?> shelfCode = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StockBalancesCompanion(
                id: id,
                warehouseId: warehouseId,
                productId: productId,
                onHandQty: onHandQty,
                reservedQty: reservedQty,
                safetyStockQty: safetyStockQty,
                shelfCode: shelfCode,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int warehouseId,
                required int productId,
                Value<int> onHandQty = const Value.absent(),
                Value<int> reservedQty = const Value.absent(),
                Value<int> safetyStockQty = const Value.absent(),
                Value<String?> shelfCode = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StockBalancesCompanion.insert(
                id: id,
                warehouseId: warehouseId,
                productId: productId,
                onHandQty: onHandQty,
                reservedQty: reservedQty,
                safetyStockQty: safetyStockQty,
                shelfCode: shelfCode,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StockBalancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({warehouseId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (warehouseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.warehouseId,
                                referencedTable: $$StockBalancesTableReferences
                                    ._warehouseIdTable(db),
                                referencedColumn: $$StockBalancesTableReferences
                                    ._warehouseIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$StockBalancesTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$StockBalancesTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StockBalancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockBalancesTable,
      StockBalance,
      $$StockBalancesTableFilterComposer,
      $$StockBalancesTableOrderingComposer,
      $$StockBalancesTableAnnotationComposer,
      $$StockBalancesTableCreateCompanionBuilder,
      $$StockBalancesTableUpdateCompanionBuilder,
      (StockBalance, $$StockBalancesTableReferences),
      StockBalance,
      PrefetchHooks Function({bool warehouseId, bool productId})
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      required String movementNo,
      required String movementType,
      Value<String?> refType,
      Value<int?> refId,
      required int warehouseId,
      required int productId,
      required int qtyDelta,
      Value<int?> unitCostCent,
      Value<int?> amountCent,
      required DateTime occurredAt,
      Value<int?> operatorUserId,
      Value<String?> note,
      Value<DateTime> createdAt,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      Value<String> movementNo,
      Value<String> movementType,
      Value<String?> refType,
      Value<int?> refId,
      Value<int> warehouseId,
      Value<int> productId,
      Value<int> qtyDelta,
      Value<int?> unitCostCent,
      Value<int?> amountCent,
      Value<DateTime> occurredAt,
      Value<int?> operatorUserId,
      Value<String?> note,
      Value<DateTime> createdAt,
    });

final class $$StockMovementsTableReferences
    extends BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement> {
  $$StockMovementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WarehousesTable _warehouseIdTable(_$AppDatabase db) =>
      db.warehouses.createAlias(
        $_aliasNameGenerator(db.stockMovements.warehouseId, db.warehouses.id),
      );

  $$WarehousesTableProcessedTableManager get warehouseId {
    final $_column = $_itemColumn<int>('warehouse_id')!;

    final manager = $$WarehousesTableTableManager(
      $_db,
      $_db.warehouses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_warehouseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.stockMovements.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _operatorUserIdTable(_$AppDatabase db) =>
      db.users.createAlias(
        $_aliasNameGenerator(db.stockMovements.operatorUserId, db.users.id),
      );

  $$UsersTableProcessedTableManager? get operatorUserId {
    final $_column = $_itemColumn<int>('operator_user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_operatorUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StockMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get movementNo => $composableBuilder(
    column: $table.movementNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refType => $composableBuilder(
    column: $table.refType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qtyDelta => $composableBuilder(
    column: $table.qtyDelta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitCostCent => $composableBuilder(
    column: $table.unitCostCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCent => $composableBuilder(
    column: $table.amountCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WarehousesTableFilterComposer get warehouseId {
    final $$WarehousesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableFilterComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get operatorUserId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.operatorUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get movementNo => $composableBuilder(
    column: $table.movementNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refType => $composableBuilder(
    column: $table.refType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qtyDelta => $composableBuilder(
    column: $table.qtyDelta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitCostCent => $composableBuilder(
    column: $table.unitCostCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCent => $composableBuilder(
    column: $table.amountCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WarehousesTableOrderingComposer get warehouseId {
    final $$WarehousesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableOrderingComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get operatorUserId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.operatorUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get movementNo => $composableBuilder(
    column: $table.movementNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get refType =>
      $composableBuilder(column: $table.refType, builder: (column) => column);

  GeneratedColumn<int> get refId =>
      $composableBuilder(column: $table.refId, builder: (column) => column);

  GeneratedColumn<int> get qtyDelta =>
      $composableBuilder(column: $table.qtyDelta, builder: (column) => column);

  GeneratedColumn<int> get unitCostCent => $composableBuilder(
    column: $table.unitCostCent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountCent => $composableBuilder(
    column: $table.amountCent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WarehousesTableAnnotationComposer get warehouseId {
    final $$WarehousesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableAnnotationComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get operatorUserId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.operatorUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTable,
          StockMovement,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (StockMovement, $$StockMovementsTableReferences),
          StockMovement,
          PrefetchHooks Function({
            bool warehouseId,
            bool productId,
            bool operatorUserId,
          })
        > {
  $$StockMovementsTableTableManager(
    _$AppDatabase db,
    $StockMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> movementNo = const Value.absent(),
                Value<String> movementType = const Value.absent(),
                Value<String?> refType = const Value.absent(),
                Value<int?> refId = const Value.absent(),
                Value<int> warehouseId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> qtyDelta = const Value.absent(),
                Value<int?> unitCostCent = const Value.absent(),
                Value<int?> amountCent = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int?> operatorUserId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockMovementsCompanion(
                id: id,
                movementNo: movementNo,
                movementType: movementType,
                refType: refType,
                refId: refId,
                warehouseId: warehouseId,
                productId: productId,
                qtyDelta: qtyDelta,
                unitCostCent: unitCostCent,
                amountCent: amountCent,
                occurredAt: occurredAt,
                operatorUserId: operatorUserId,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String movementNo,
                required String movementType,
                Value<String?> refType = const Value.absent(),
                Value<int?> refId = const Value.absent(),
                required int warehouseId,
                required int productId,
                required int qtyDelta,
                Value<int?> unitCostCent = const Value.absent(),
                Value<int?> amountCent = const Value.absent(),
                required DateTime occurredAt,
                Value<int?> operatorUserId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockMovementsCompanion.insert(
                id: id,
                movementNo: movementNo,
                movementType: movementType,
                refType: refType,
                refId: refId,
                warehouseId: warehouseId,
                productId: productId,
                qtyDelta: qtyDelta,
                unitCostCent: unitCostCent,
                amountCent: amountCent,
                occurredAt: occurredAt,
                operatorUserId: operatorUserId,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StockMovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                warehouseId = false,
                productId = false,
                operatorUserId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (warehouseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.warehouseId,
                                    referencedTable:
                                        $$StockMovementsTableReferences
                                            ._warehouseIdTable(db),
                                    referencedColumn:
                                        $$StockMovementsTableReferences
                                            ._warehouseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable:
                                        $$StockMovementsTableReferences
                                            ._productIdTable(db),
                                    referencedColumn:
                                        $$StockMovementsTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (operatorUserId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.operatorUserId,
                                    referencedTable:
                                        $$StockMovementsTableReferences
                                            ._operatorUserIdTable(db),
                                    referencedColumn:
                                        $$StockMovementsTableReferences
                                            ._operatorUserIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTable,
      StockMovement,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (StockMovement, $$StockMovementsTableReferences),
      StockMovement,
      PrefetchHooks Function({
        bool warehouseId,
        bool productId,
        bool operatorUserId,
      })
    >;
typedef $$PurchaseOrdersTableCreateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      Value<int> id,
      required String orderNo,
      required int supplierId,
      required int warehouseId,
      Value<int> status,
      required DateTime orderedAt,
      Value<DateTime?> expectedAt,
      Value<int> totalAmountCent,
      Value<int> paidAmountCent,
      Value<int?> createdBy,
      Value<int?> approvedBy,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$PurchaseOrdersTableUpdateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      Value<int> id,
      Value<String> orderNo,
      Value<int> supplierId,
      Value<int> warehouseId,
      Value<int> status,
      Value<DateTime> orderedAt,
      Value<DateTime?> expectedAt,
      Value<int> totalAmountCent,
      Value<int> paidAmountCent,
      Value<int?> createdBy,
      Value<int?> approvedBy,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$PurchaseOrdersTableReferences
    extends BaseReferences<_$AppDatabase, $PurchaseOrdersTable, PurchaseOrder> {
  $$PurchaseOrdersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias(
        $_aliasNameGenerator(db.purchaseOrders.supplierId, db.suppliers.id),
      );

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$SuppliersTableTableManager(
      $_db,
      $_db.suppliers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WarehousesTable _warehouseIdTable(_$AppDatabase db) =>
      db.warehouses.createAlias(
        $_aliasNameGenerator(db.purchaseOrders.warehouseId, db.warehouses.id),
      );

  $$WarehousesTableProcessedTableManager get warehouseId {
    final $_column = $_itemColumn<int>('warehouse_id')!;

    final manager = $$WarehousesTableTableManager(
      $_db,
      $_db.warehouses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_warehouseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _createdByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.purchaseOrders.createdBy, db.users.id),
  );

  $$UsersTableProcessedTableManager? get createdBy {
    final $_column = $_itemColumn<int>('created_by');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _approvedByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.purchaseOrders.approvedBy, db.users.id),
  );

  $$UsersTableProcessedTableManager? get approvedBy {
    final $_column = $_itemColumn<int>('approved_by');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_approvedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchaseOrderItemsTable, List<PurchaseOrderItem>>
  _purchaseOrderItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseOrderItems,
        aliasName: $_aliasNameGenerator(
          db.purchaseOrders.id,
          db.purchaseOrderItems.purchaseOrderId,
        ),
      );

  $$PurchaseOrderItemsTableProcessedTableManager get purchaseOrderItemsRefs {
    final manager = $$PurchaseOrderItemsTableTableManager(
      $_db,
      $_db.purchaseOrderItems,
    ).filter((f) => f.purchaseOrderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseOrderItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchaseOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderNo => $composableBuilder(
    column: $table.orderNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get orderedAt => $composableBuilder(
    column: $table.orderedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedAt => $composableBuilder(
    column: $table.expectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAmountCent => $composableBuilder(
    column: $table.totalAmountCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paidAmountCent => $composableBuilder(
    column: $table.paidAmountCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WarehousesTableFilterComposer get warehouseId {
    final $$WarehousesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableFilterComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get createdBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get approvedBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.approvedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseOrderItemsRefs(
    Expression<bool> Function($$PurchaseOrderItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseOrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseOrderItems,
      getReferencedColumn: (t) => t.purchaseOrderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderNo => $composableBuilder(
    column: $table.orderNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get orderedAt => $composableBuilder(
    column: $table.orderedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedAt => $composableBuilder(
    column: $table.expectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAmountCent => $composableBuilder(
    column: $table.totalAmountCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paidAmountCent => $composableBuilder(
    column: $table.paidAmountCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WarehousesTableOrderingComposer get warehouseId {
    final $$WarehousesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableOrderingComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get createdBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get approvedBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.approvedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderNo =>
      $composableBuilder(column: $table.orderNo, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get orderedAt =>
      $composableBuilder(column: $table.orderedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expectedAt => $composableBuilder(
    column: $table.expectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalAmountCent => $composableBuilder(
    column: $table.totalAmountCent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paidAmountCent => $composableBuilder(
    column: $table.paidAmountCent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WarehousesTableAnnotationComposer get warehouseId {
    final $$WarehousesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableAnnotationComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get createdBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get approvedBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.approvedBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseOrderItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseOrderItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseOrderItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseOrderItems,
          getReferencedColumn: (t) => t.purchaseOrderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseOrderItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseOrderItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PurchaseOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrdersTable,
          PurchaseOrder,
          $$PurchaseOrdersTableFilterComposer,
          $$PurchaseOrdersTableOrderingComposer,
          $$PurchaseOrdersTableAnnotationComposer,
          $$PurchaseOrdersTableCreateCompanionBuilder,
          $$PurchaseOrdersTableUpdateCompanionBuilder,
          (PurchaseOrder, $$PurchaseOrdersTableReferences),
          PurchaseOrder,
          PrefetchHooks Function({
            bool supplierId,
            bool warehouseId,
            bool createdBy,
            bool approvedBy,
            bool purchaseOrderItemsRefs,
          })
        > {
  $$PurchaseOrdersTableTableManager(
    _$AppDatabase db,
    $PurchaseOrdersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> orderNo = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<int> warehouseId = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> orderedAt = const Value.absent(),
                Value<DateTime?> expectedAt = const Value.absent(),
                Value<int> totalAmountCent = const Value.absent(),
                Value<int> paidAmountCent = const Value.absent(),
                Value<int?> createdBy = const Value.absent(),
                Value<int?> approvedBy = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PurchaseOrdersCompanion(
                id: id,
                orderNo: orderNo,
                supplierId: supplierId,
                warehouseId: warehouseId,
                status: status,
                orderedAt: orderedAt,
                expectedAt: expectedAt,
                totalAmountCent: totalAmountCent,
                paidAmountCent: paidAmountCent,
                createdBy: createdBy,
                approvedBy: approvedBy,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String orderNo,
                required int supplierId,
                required int warehouseId,
                Value<int> status = const Value.absent(),
                required DateTime orderedAt,
                Value<DateTime?> expectedAt = const Value.absent(),
                Value<int> totalAmountCent = const Value.absent(),
                Value<int> paidAmountCent = const Value.absent(),
                Value<int?> createdBy = const Value.absent(),
                Value<int?> approvedBy = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PurchaseOrdersCompanion.insert(
                id: id,
                orderNo: orderNo,
                supplierId: supplierId,
                warehouseId: warehouseId,
                status: status,
                orderedAt: orderedAt,
                expectedAt: expectedAt,
                totalAmountCent: totalAmountCent,
                paidAmountCent: paidAmountCent,
                createdBy: createdBy,
                approvedBy: approvedBy,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseOrdersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                supplierId = false,
                warehouseId = false,
                createdBy = false,
                approvedBy = false,
                purchaseOrderItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseOrderItemsRefs) db.purchaseOrderItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (supplierId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.supplierId,
                                    referencedTable:
                                        $$PurchaseOrdersTableReferences
                                            ._supplierIdTable(db),
                                    referencedColumn:
                                        $$PurchaseOrdersTableReferences
                                            ._supplierIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (warehouseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.warehouseId,
                                    referencedTable:
                                        $$PurchaseOrdersTableReferences
                                            ._warehouseIdTable(db),
                                    referencedColumn:
                                        $$PurchaseOrdersTableReferences
                                            ._warehouseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (createdBy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.createdBy,
                                    referencedTable:
                                        $$PurchaseOrdersTableReferences
                                            ._createdByTable(db),
                                    referencedColumn:
                                        $$PurchaseOrdersTableReferences
                                            ._createdByTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (approvedBy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.approvedBy,
                                    referencedTable:
                                        $$PurchaseOrdersTableReferences
                                            ._approvedByTable(db),
                                    referencedColumn:
                                        $$PurchaseOrdersTableReferences
                                            ._approvedByTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseOrderItemsRefs)
                        await $_getPrefetchedData<
                          PurchaseOrder,
                          $PurchaseOrdersTable,
                          PurchaseOrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$PurchaseOrdersTableReferences
                              ._purchaseOrderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchaseOrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseOrderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseOrderId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PurchaseOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrdersTable,
      PurchaseOrder,
      $$PurchaseOrdersTableFilterComposer,
      $$PurchaseOrdersTableOrderingComposer,
      $$PurchaseOrdersTableAnnotationComposer,
      $$PurchaseOrdersTableCreateCompanionBuilder,
      $$PurchaseOrdersTableUpdateCompanionBuilder,
      (PurchaseOrder, $$PurchaseOrdersTableReferences),
      PurchaseOrder,
      PrefetchHooks Function({
        bool supplierId,
        bool warehouseId,
        bool createdBy,
        bool approvedBy,
        bool purchaseOrderItemsRefs,
      })
    >;
typedef $$PurchaseOrderItemsTableCreateCompanionBuilder =
    PurchaseOrderItemsCompanion Function({
      Value<int> id,
      required int purchaseOrderId,
      required int lineNo,
      required int productId,
      required int qty,
      required int unitPriceCent,
      Value<int> discountBp,
      required int lineAmountCent,
      Value<int> receivedQty,
      Value<String?> note,
    });
typedef $$PurchaseOrderItemsTableUpdateCompanionBuilder =
    PurchaseOrderItemsCompanion Function({
      Value<int> id,
      Value<int> purchaseOrderId,
      Value<int> lineNo,
      Value<int> productId,
      Value<int> qty,
      Value<int> unitPriceCent,
      Value<int> discountBp,
      Value<int> lineAmountCent,
      Value<int> receivedQty,
      Value<String?> note,
    });

final class $$PurchaseOrderItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PurchaseOrderItemsTable,
          PurchaseOrderItem
        > {
  $$PurchaseOrderItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchaseOrdersTable _purchaseOrderIdTable(_$AppDatabase db) =>
      db.purchaseOrders.createAlias(
        $_aliasNameGenerator(
          db.purchaseOrderItems.purchaseOrderId,
          db.purchaseOrders.id,
        ),
      );

  $$PurchaseOrdersTableProcessedTableManager get purchaseOrderId {
    final $_column = $_itemColumn<int>('purchase_order_id')!;

    final manager = $$PurchaseOrdersTableTableManager(
      $_db,
      $_db.purchaseOrders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseOrderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.purchaseOrderItems.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PurchaseOrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrderItemsTable> {
  $$PurchaseOrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineNo => $composableBuilder(
    column: $table.lineNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceCent => $composableBuilder(
    column: $table.unitPriceCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountBp => $composableBuilder(
    column: $table.discountBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineAmountCent => $composableBuilder(
    column: $table.lineAmountCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receivedQty => $composableBuilder(
    column: $table.receivedQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchaseOrdersTableFilterComposer get purchaseOrderId {
    final $$PurchaseOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseOrderId,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableFilterComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseOrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrderItemsTable> {
  $$PurchaseOrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineNo => $composableBuilder(
    column: $table.lineNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceCent => $composableBuilder(
    column: $table.unitPriceCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountBp => $composableBuilder(
    column: $table.discountBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineAmountCent => $composableBuilder(
    column: $table.lineAmountCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receivedQty => $composableBuilder(
    column: $table.receivedQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchaseOrdersTableOrderingComposer get purchaseOrderId {
    final $$PurchaseOrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseOrderId,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableOrderingComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseOrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrderItemsTable> {
  $$PurchaseOrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get lineNo =>
      $composableBuilder(column: $table.lineNo, builder: (column) => column);

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<int> get unitPriceCent => $composableBuilder(
    column: $table.unitPriceCent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountBp => $composableBuilder(
    column: $table.discountBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineAmountCent => $composableBuilder(
    column: $table.lineAmountCent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get receivedQty => $composableBuilder(
    column: $table.receivedQty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$PurchaseOrdersTableAnnotationComposer get purchaseOrderId {
    final $$PurchaseOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseOrderId,
      referencedTable: $db.purchaseOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseOrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrderItemsTable,
          PurchaseOrderItem,
          $$PurchaseOrderItemsTableFilterComposer,
          $$PurchaseOrderItemsTableOrderingComposer,
          $$PurchaseOrderItemsTableAnnotationComposer,
          $$PurchaseOrderItemsTableCreateCompanionBuilder,
          $$PurchaseOrderItemsTableUpdateCompanionBuilder,
          (PurchaseOrderItem, $$PurchaseOrderItemsTableReferences),
          PurchaseOrderItem,
          PrefetchHooks Function({bool purchaseOrderId, bool productId})
        > {
  $$PurchaseOrderItemsTableTableManager(
    _$AppDatabase db,
    $PurchaseOrderItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrderItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> purchaseOrderId = const Value.absent(),
                Value<int> lineNo = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> unitPriceCent = const Value.absent(),
                Value<int> discountBp = const Value.absent(),
                Value<int> lineAmountCent = const Value.absent(),
                Value<int> receivedQty = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => PurchaseOrderItemsCompanion(
                id: id,
                purchaseOrderId: purchaseOrderId,
                lineNo: lineNo,
                productId: productId,
                qty: qty,
                unitPriceCent: unitPriceCent,
                discountBp: discountBp,
                lineAmountCent: lineAmountCent,
                receivedQty: receivedQty,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int purchaseOrderId,
                required int lineNo,
                required int productId,
                required int qty,
                required int unitPriceCent,
                Value<int> discountBp = const Value.absent(),
                required int lineAmountCent,
                Value<int> receivedQty = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => PurchaseOrderItemsCompanion.insert(
                id: id,
                purchaseOrderId: purchaseOrderId,
                lineNo: lineNo,
                productId: productId,
                qty: qty,
                unitPriceCent: unitPriceCent,
                discountBp: discountBp,
                lineAmountCent: lineAmountCent,
                receivedQty: receivedQty,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseOrderItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({purchaseOrderId = false, productId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (purchaseOrderId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.purchaseOrderId,
                                    referencedTable:
                                        $$PurchaseOrderItemsTableReferences
                                            ._purchaseOrderIdTable(db),
                                    referencedColumn:
                                        $$PurchaseOrderItemsTableReferences
                                            ._purchaseOrderIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable:
                                        $$PurchaseOrderItemsTableReferences
                                            ._productIdTable(db),
                                    referencedColumn:
                                        $$PurchaseOrderItemsTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PurchaseOrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrderItemsTable,
      PurchaseOrderItem,
      $$PurchaseOrderItemsTableFilterComposer,
      $$PurchaseOrderItemsTableOrderingComposer,
      $$PurchaseOrderItemsTableAnnotationComposer,
      $$PurchaseOrderItemsTableCreateCompanionBuilder,
      $$PurchaseOrderItemsTableUpdateCompanionBuilder,
      (PurchaseOrderItem, $$PurchaseOrderItemsTableReferences),
      PurchaseOrderItem,
      PrefetchHooks Function({bool purchaseOrderId, bool productId})
    >;
typedef $$SalesOrdersTableCreateCompanionBuilder =
    SalesOrdersCompanion Function({
      Value<int> id,
      required String orderNo,
      Value<int?> customerId,
      required int warehouseId,
      Value<int> status,
      Value<String> salesChannel,
      required DateTime soldAt,
      Value<int> totalAmountCent,
      Value<int> receivableAmountCent,
      Value<int> receivedAmountCent,
      Value<int?> createdBy,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SalesOrdersTableUpdateCompanionBuilder =
    SalesOrdersCompanion Function({
      Value<int> id,
      Value<String> orderNo,
      Value<int?> customerId,
      Value<int> warehouseId,
      Value<int> status,
      Value<String> salesChannel,
      Value<DateTime> soldAt,
      Value<int> totalAmountCent,
      Value<int> receivableAmountCent,
      Value<int> receivedAmountCent,
      Value<int?> createdBy,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SalesOrdersTableReferences
    extends BaseReferences<_$AppDatabase, $SalesOrdersTable, SalesOrder> {
  $$SalesOrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.salesOrders.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WarehousesTable _warehouseIdTable(_$AppDatabase db) =>
      db.warehouses.createAlias(
        $_aliasNameGenerator(db.salesOrders.warehouseId, db.warehouses.id),
      );

  $$WarehousesTableProcessedTableManager get warehouseId {
    final $_column = $_itemColumn<int>('warehouse_id')!;

    final manager = $$WarehousesTableTableManager(
      $_db,
      $_db.warehouses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_warehouseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _createdByTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.salesOrders.createdBy, db.users.id),
  );

  $$UsersTableProcessedTableManager? get createdBy {
    final $_column = $_itemColumn<int>('created_by');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SalesOrderItemsTable, List<SalesOrderItem>>
  _salesOrderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.salesOrderItems,
    aliasName: $_aliasNameGenerator(
      db.salesOrders.id,
      db.salesOrderItems.salesOrderId,
    ),
  );

  $$SalesOrderItemsTableProcessedTableManager get salesOrderItemsRefs {
    final manager = $$SalesOrderItemsTableTableManager(
      $_db,
      $_db.salesOrderItems,
    ).filter((f) => f.salesOrderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _salesOrderItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SalesOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $SalesOrdersTable> {
  $$SalesOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderNo => $composableBuilder(
    column: $table.orderNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get salesChannel => $composableBuilder(
    column: $table.salesChannel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get soldAt => $composableBuilder(
    column: $table.soldAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAmountCent => $composableBuilder(
    column: $table.totalAmountCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receivableAmountCent => $composableBuilder(
    column: $table.receivableAmountCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receivedAmountCent => $composableBuilder(
    column: $table.receivedAmountCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WarehousesTableFilterComposer get warehouseId {
    final $$WarehousesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableFilterComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get createdBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> salesOrderItemsRefs(
    Expression<bool> Function($$SalesOrderItemsTableFilterComposer f) f,
  ) {
    final $$SalesOrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrderItems,
      getReferencedColumn: (t) => t.salesOrderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.salesOrderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesOrdersTable> {
  $$SalesOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderNo => $composableBuilder(
    column: $table.orderNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get salesChannel => $composableBuilder(
    column: $table.salesChannel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get soldAt => $composableBuilder(
    column: $table.soldAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAmountCent => $composableBuilder(
    column: $table.totalAmountCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receivableAmountCent => $composableBuilder(
    column: $table.receivableAmountCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receivedAmountCent => $composableBuilder(
    column: $table.receivedAmountCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WarehousesTableOrderingComposer get warehouseId {
    final $$WarehousesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableOrderingComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get createdBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesOrdersTable> {
  $$SalesOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderNo =>
      $composableBuilder(column: $table.orderNo, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get salesChannel => $composableBuilder(
    column: $table.salesChannel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get soldAt =>
      $composableBuilder(column: $table.soldAt, builder: (column) => column);

  GeneratedColumn<int> get totalAmountCent => $composableBuilder(
    column: $table.totalAmountCent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get receivableAmountCent => $composableBuilder(
    column: $table.receivableAmountCent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get receivedAmountCent => $composableBuilder(
    column: $table.receivedAmountCent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WarehousesTableAnnotationComposer get warehouseId {
    final $$WarehousesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.warehouseId,
      referencedTable: $db.warehouses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WarehousesTableAnnotationComposer(
            $db: $db,
            $table: $db.warehouses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get createdBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdBy,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> salesOrderItemsRefs<T extends Object>(
    Expression<T> Function($$SalesOrderItemsTableAnnotationComposer a) f,
  ) {
    final $$SalesOrderItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesOrderItems,
      getReferencedColumn: (t) => t.salesOrderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrderItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.salesOrderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesOrdersTable,
          SalesOrder,
          $$SalesOrdersTableFilterComposer,
          $$SalesOrdersTableOrderingComposer,
          $$SalesOrdersTableAnnotationComposer,
          $$SalesOrdersTableCreateCompanionBuilder,
          $$SalesOrdersTableUpdateCompanionBuilder,
          (SalesOrder, $$SalesOrdersTableReferences),
          SalesOrder,
          PrefetchHooks Function({
            bool customerId,
            bool warehouseId,
            bool createdBy,
            bool salesOrderItemsRefs,
          })
        > {
  $$SalesOrdersTableTableManager(_$AppDatabase db, $SalesOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> orderNo = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<int> warehouseId = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<String> salesChannel = const Value.absent(),
                Value<DateTime> soldAt = const Value.absent(),
                Value<int> totalAmountCent = const Value.absent(),
                Value<int> receivableAmountCent = const Value.absent(),
                Value<int> receivedAmountCent = const Value.absent(),
                Value<int?> createdBy = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SalesOrdersCompanion(
                id: id,
                orderNo: orderNo,
                customerId: customerId,
                warehouseId: warehouseId,
                status: status,
                salesChannel: salesChannel,
                soldAt: soldAt,
                totalAmountCent: totalAmountCent,
                receivableAmountCent: receivableAmountCent,
                receivedAmountCent: receivedAmountCent,
                createdBy: createdBy,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String orderNo,
                Value<int?> customerId = const Value.absent(),
                required int warehouseId,
                Value<int> status = const Value.absent(),
                Value<String> salesChannel = const Value.absent(),
                required DateTime soldAt,
                Value<int> totalAmountCent = const Value.absent(),
                Value<int> receivableAmountCent = const Value.absent(),
                Value<int> receivedAmountCent = const Value.absent(),
                Value<int?> createdBy = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SalesOrdersCompanion.insert(
                id: id,
                orderNo: orderNo,
                customerId: customerId,
                warehouseId: warehouseId,
                status: status,
                salesChannel: salesChannel,
                soldAt: soldAt,
                totalAmountCent: totalAmountCent,
                receivableAmountCent: receivableAmountCent,
                receivedAmountCent: receivedAmountCent,
                createdBy: createdBy,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SalesOrdersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                customerId = false,
                warehouseId = false,
                createdBy = false,
                salesOrderItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (salesOrderItemsRefs) db.salesOrderItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable:
                                        $$SalesOrdersTableReferences
                                            ._customerIdTable(db),
                                    referencedColumn:
                                        $$SalesOrdersTableReferences
                                            ._customerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (warehouseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.warehouseId,
                                    referencedTable:
                                        $$SalesOrdersTableReferences
                                            ._warehouseIdTable(db),
                                    referencedColumn:
                                        $$SalesOrdersTableReferences
                                            ._warehouseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (createdBy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.createdBy,
                                    referencedTable:
                                        $$SalesOrdersTableReferences
                                            ._createdByTable(db),
                                    referencedColumn:
                                        $$SalesOrdersTableReferences
                                            ._createdByTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (salesOrderItemsRefs)
                        await $_getPrefetchedData<
                          SalesOrder,
                          $SalesOrdersTable,
                          SalesOrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$SalesOrdersTableReferences
                              ._salesOrderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SalesOrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).salesOrderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.salesOrderId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SalesOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesOrdersTable,
      SalesOrder,
      $$SalesOrdersTableFilterComposer,
      $$SalesOrdersTableOrderingComposer,
      $$SalesOrdersTableAnnotationComposer,
      $$SalesOrdersTableCreateCompanionBuilder,
      $$SalesOrdersTableUpdateCompanionBuilder,
      (SalesOrder, $$SalesOrdersTableReferences),
      SalesOrder,
      PrefetchHooks Function({
        bool customerId,
        bool warehouseId,
        bool createdBy,
        bool salesOrderItemsRefs,
      })
    >;
typedef $$SalesOrderItemsTableCreateCompanionBuilder =
    SalesOrderItemsCompanion Function({
      Value<int> id,
      required int salesOrderId,
      required int lineNo,
      required int productId,
      required int qty,
      required int unitPriceCent,
      Value<int> discountBp,
      required int lineAmountCent,
      Value<int?> costPriceCent,
      Value<String?> note,
    });
typedef $$SalesOrderItemsTableUpdateCompanionBuilder =
    SalesOrderItemsCompanion Function({
      Value<int> id,
      Value<int> salesOrderId,
      Value<int> lineNo,
      Value<int> productId,
      Value<int> qty,
      Value<int> unitPriceCent,
      Value<int> discountBp,
      Value<int> lineAmountCent,
      Value<int?> costPriceCent,
      Value<String?> note,
    });

final class $$SalesOrderItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SalesOrderItemsTable, SalesOrderItem> {
  $$SalesOrderItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SalesOrdersTable _salesOrderIdTable(_$AppDatabase db) =>
      db.salesOrders.createAlias(
        $_aliasNameGenerator(
          db.salesOrderItems.salesOrderId,
          db.salesOrders.id,
        ),
      );

  $$SalesOrdersTableProcessedTableManager get salesOrderId {
    final $_column = $_itemColumn<int>('sales_order_id')!;

    final manager = $$SalesOrdersTableTableManager(
      $_db,
      $_db.salesOrders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_salesOrderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.salesOrderItems.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SalesOrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SalesOrderItemsTable> {
  $$SalesOrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineNo => $composableBuilder(
    column: $table.lineNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceCent => $composableBuilder(
    column: $table.unitPriceCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountBp => $composableBuilder(
    column: $table.discountBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineAmountCent => $composableBuilder(
    column: $table.lineAmountCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPriceCent => $composableBuilder(
    column: $table.costPriceCent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$SalesOrdersTableFilterComposer get salesOrderId {
    final $$SalesOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.salesOrderId,
      referencedTable: $db.salesOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrdersTableFilterComposer(
            $db: $db,
            $table: $db.salesOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesOrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesOrderItemsTable> {
  $$SalesOrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineNo => $composableBuilder(
    column: $table.lineNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceCent => $composableBuilder(
    column: $table.unitPriceCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountBp => $composableBuilder(
    column: $table.discountBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineAmountCent => $composableBuilder(
    column: $table.lineAmountCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPriceCent => $composableBuilder(
    column: $table.costPriceCent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$SalesOrdersTableOrderingComposer get salesOrderId {
    final $$SalesOrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.salesOrderId,
      referencedTable: $db.salesOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrdersTableOrderingComposer(
            $db: $db,
            $table: $db.salesOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesOrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesOrderItemsTable> {
  $$SalesOrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get lineNo =>
      $composableBuilder(column: $table.lineNo, builder: (column) => column);

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<int> get unitPriceCent => $composableBuilder(
    column: $table.unitPriceCent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountBp => $composableBuilder(
    column: $table.discountBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineAmountCent => $composableBuilder(
    column: $table.lineAmountCent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costPriceCent => $composableBuilder(
    column: $table.costPriceCent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$SalesOrdersTableAnnotationComposer get salesOrderId {
    final $$SalesOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.salesOrderId,
      referencedTable: $db.salesOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.salesOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesOrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesOrderItemsTable,
          SalesOrderItem,
          $$SalesOrderItemsTableFilterComposer,
          $$SalesOrderItemsTableOrderingComposer,
          $$SalesOrderItemsTableAnnotationComposer,
          $$SalesOrderItemsTableCreateCompanionBuilder,
          $$SalesOrderItemsTableUpdateCompanionBuilder,
          (SalesOrderItem, $$SalesOrderItemsTableReferences),
          SalesOrderItem,
          PrefetchHooks Function({bool salesOrderId, bool productId})
        > {
  $$SalesOrderItemsTableTableManager(
    _$AppDatabase db,
    $SalesOrderItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesOrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesOrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesOrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> salesOrderId = const Value.absent(),
                Value<int> lineNo = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> unitPriceCent = const Value.absent(),
                Value<int> discountBp = const Value.absent(),
                Value<int> lineAmountCent = const Value.absent(),
                Value<int?> costPriceCent = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => SalesOrderItemsCompanion(
                id: id,
                salesOrderId: salesOrderId,
                lineNo: lineNo,
                productId: productId,
                qty: qty,
                unitPriceCent: unitPriceCent,
                discountBp: discountBp,
                lineAmountCent: lineAmountCent,
                costPriceCent: costPriceCent,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int salesOrderId,
                required int lineNo,
                required int productId,
                required int qty,
                required int unitPriceCent,
                Value<int> discountBp = const Value.absent(),
                required int lineAmountCent,
                Value<int?> costPriceCent = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => SalesOrderItemsCompanion.insert(
                id: id,
                salesOrderId: salesOrderId,
                lineNo: lineNo,
                productId: productId,
                qty: qty,
                unitPriceCent: unitPriceCent,
                discountBp: discountBp,
                lineAmountCent: lineAmountCent,
                costPriceCent: costPriceCent,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SalesOrderItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({salesOrderId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (salesOrderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.salesOrderId,
                                referencedTable:
                                    $$SalesOrderItemsTableReferences
                                        ._salesOrderIdTable(db),
                                referencedColumn:
                                    $$SalesOrderItemsTableReferences
                                        ._salesOrderIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable:
                                    $$SalesOrderItemsTableReferences
                                        ._productIdTable(db),
                                referencedColumn:
                                    $$SalesOrderItemsTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SalesOrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesOrderItemsTable,
      SalesOrderItem,
      $$SalesOrderItemsTableFilterComposer,
      $$SalesOrderItemsTableOrderingComposer,
      $$SalesOrderItemsTableAnnotationComposer,
      $$SalesOrderItemsTableCreateCompanionBuilder,
      $$SalesOrderItemsTableUpdateCompanionBuilder,
      (SalesOrderItem, $$SalesOrderItemsTableReferences),
      SalesOrderItem,
      PrefetchHooks Function({bool salesOrderId, bool productId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ProductCategoriesTableTableManager get productCategories =>
      $$ProductCategoriesTableTableManager(_db, _db.productCategories);
  $$PublishersTableTableManager get publishers =>
      $$PublishersTableTableManager(_db, _db.publishers);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$WarehousesTableTableManager get warehouses =>
      $$WarehousesTableTableManager(_db, _db.warehouses);
  $$StockBalancesTableTableManager get stockBalances =>
      $$StockBalancesTableTableManager(_db, _db.stockBalances);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$PurchaseOrdersTableTableManager get purchaseOrders =>
      $$PurchaseOrdersTableTableManager(_db, _db.purchaseOrders);
  $$PurchaseOrderItemsTableTableManager get purchaseOrderItems =>
      $$PurchaseOrderItemsTableTableManager(_db, _db.purchaseOrderItems);
  $$SalesOrdersTableTableManager get salesOrders =>
      $$SalesOrdersTableTableManager(_db, _db.salesOrders);
  $$SalesOrderItemsTableTableManager get salesOrderItems =>
      $$SalesOrderItemsTableTableManager(_db, _db.salesOrderItems);
}
