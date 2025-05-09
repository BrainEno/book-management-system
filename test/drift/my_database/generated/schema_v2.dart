// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class Books extends Table with TableInfo<Books, BooksData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Books(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
    'isbn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<double> internalPricing = GeneratedColumn<double>(
    'internal_pricing',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> selfEncoding = GeneratedColumn<String>(
    'self_encoding',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> publicationYear = GeneratedColumn<int>(
    'publication_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<double> retailDiscount = GeneratedColumn<double>(
    'retail_discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<double> wholesaleDiscount =
      GeneratedColumn<double>(
        'wholesale_discount',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  late final GeneratedColumn<double> wholesalePrice = GeneratedColumn<double>(
    'wholesale_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<double> memberDiscount = GeneratedColumn<double>(
    'member_discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> purchaseSaleMode = GeneratedColumn<String>(
    'purchase_sale_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> bookmark = GeneratedColumn<String>(
    'bookmark',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> packaging = GeneratedColumn<String>(
    'packaging',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> properity = GeneratedColumn<String>(
    'properity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> statisticalClass = GeneratedColumn<String>(
    'statistical_class',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> operator = GeneratedColumn<String>(
    'operator',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
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
    bookId,
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
    operator,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BooksData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BooksData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      author:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}author'],
          )!,
      isbn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}isbn'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      price:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}price'],
          )!,
      publisher:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}publisher'],
          )!,
      bookId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}book_id'],
          )!,
      internalPricing:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}internal_pricing'],
          )!,
      selfEncoding:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}self_encoding'],
          )!,
      purchasePrice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}purchase_price'],
          )!,
      publicationYear:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}publication_year'],
          )!,
      retailDiscount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}retail_discount'],
          )!,
      wholesaleDiscount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}wholesale_discount'],
          )!,
      wholesalePrice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}wholesale_price'],
          )!,
      memberDiscount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}member_discount'],
          )!,
      purchaseSaleMode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}purchase_sale_mode'],
          )!,
      bookmark:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}bookmark'],
          )!,
      packaging:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}packaging'],
          )!,
      properity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}properity'],
          )!,
      statisticalClass:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}statistical_class'],
          )!,
      operator:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}operator'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  Books createAlias(String alias) {
    return Books(attachedDatabase, alias);
  }
}

class BooksData extends DataClass implements Insertable<BooksData> {
  final int id;
  final String title;
  final String author;
  final String isbn;
  final String category;
  final double price;
  final String publisher;
  final String bookId;
  final double internalPricing;
  final String selfEncoding;
  final double purchasePrice;
  final int publicationYear;
  final double retailDiscount;
  final double wholesaleDiscount;
  final double wholesalePrice;
  final double memberDiscount;
  final String purchaseSaleMode;
  final String bookmark;
  final String packaging;
  final String properity;
  final String statisticalClass;
  final String operator;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BooksData({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.category,
    required this.price,
    required this.publisher,
    required this.bookId,
    required this.internalPricing,
    required this.selfEncoding,
    required this.purchasePrice,
    required this.publicationYear,
    required this.retailDiscount,
    required this.wholesaleDiscount,
    required this.wholesalePrice,
    required this.memberDiscount,
    required this.purchaseSaleMode,
    required this.bookmark,
    required this.packaging,
    required this.properity,
    required this.statisticalClass,
    required this.operator,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    map['isbn'] = Variable<String>(isbn);
    map['category'] = Variable<String>(category);
    map['price'] = Variable<double>(price);
    map['publisher'] = Variable<String>(publisher);
    map['book_id'] = Variable<String>(bookId);
    map['internal_pricing'] = Variable<double>(internalPricing);
    map['self_encoding'] = Variable<String>(selfEncoding);
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['publication_year'] = Variable<int>(publicationYear);
    map['retail_discount'] = Variable<double>(retailDiscount);
    map['wholesale_discount'] = Variable<double>(wholesaleDiscount);
    map['wholesale_price'] = Variable<double>(wholesalePrice);
    map['member_discount'] = Variable<double>(memberDiscount);
    map['purchase_sale_mode'] = Variable<String>(purchaseSaleMode);
    map['bookmark'] = Variable<String>(bookmark);
    map['packaging'] = Variable<String>(packaging);
    map['properity'] = Variable<String>(properity);
    map['statistical_class'] = Variable<String>(statisticalClass);
    map['operator'] = Variable<String>(operator);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      isbn: Value(isbn),
      category: Value(category),
      price: Value(price),
      publisher: Value(publisher),
      bookId: Value(bookId),
      internalPricing: Value(internalPricing),
      selfEncoding: Value(selfEncoding),
      purchasePrice: Value(purchasePrice),
      publicationYear: Value(publicationYear),
      retailDiscount: Value(retailDiscount),
      wholesaleDiscount: Value(wholesaleDiscount),
      wholesalePrice: Value(wholesalePrice),
      memberDiscount: Value(memberDiscount),
      purchaseSaleMode: Value(purchaseSaleMode),
      bookmark: Value(bookmark),
      packaging: Value(packaging),
      properity: Value(properity),
      statisticalClass: Value(statisticalClass),
      operator: Value(operator),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BooksData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BooksData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      isbn: serializer.fromJson<String>(json['isbn']),
      category: serializer.fromJson<String>(json['category']),
      price: serializer.fromJson<double>(json['price']),
      publisher: serializer.fromJson<String>(json['publisher']),
      bookId: serializer.fromJson<String>(json['bookId']),
      internalPricing: serializer.fromJson<double>(json['internalPricing']),
      selfEncoding: serializer.fromJson<String>(json['selfEncoding']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      publicationYear: serializer.fromJson<int>(json['publicationYear']),
      retailDiscount: serializer.fromJson<double>(json['retailDiscount']),
      wholesaleDiscount: serializer.fromJson<double>(json['wholesaleDiscount']),
      wholesalePrice: serializer.fromJson<double>(json['wholesalePrice']),
      memberDiscount: serializer.fromJson<double>(json['memberDiscount']),
      purchaseSaleMode: serializer.fromJson<String>(json['purchaseSaleMode']),
      bookmark: serializer.fromJson<String>(json['bookmark']),
      packaging: serializer.fromJson<String>(json['packaging']),
      properity: serializer.fromJson<String>(json['properity']),
      statisticalClass: serializer.fromJson<String>(json['statisticalClass']),
      operator: serializer.fromJson<String>(json['operator']),
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
      'isbn': serializer.toJson<String>(isbn),
      'category': serializer.toJson<String>(category),
      'price': serializer.toJson<double>(price),
      'publisher': serializer.toJson<String>(publisher),
      'bookId': serializer.toJson<String>(bookId),
      'internalPricing': serializer.toJson<double>(internalPricing),
      'selfEncoding': serializer.toJson<String>(selfEncoding),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'publicationYear': serializer.toJson<int>(publicationYear),
      'retailDiscount': serializer.toJson<double>(retailDiscount),
      'wholesaleDiscount': serializer.toJson<double>(wholesaleDiscount),
      'wholesalePrice': serializer.toJson<double>(wholesalePrice),
      'memberDiscount': serializer.toJson<double>(memberDiscount),
      'purchaseSaleMode': serializer.toJson<String>(purchaseSaleMode),
      'bookmark': serializer.toJson<String>(bookmark),
      'packaging': serializer.toJson<String>(packaging),
      'properity': serializer.toJson<String>(properity),
      'statisticalClass': serializer.toJson<String>(statisticalClass),
      'operator': serializer.toJson<String>(operator),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BooksData copyWith({
    int? id,
    String? title,
    String? author,
    String? isbn,
    String? category,
    double? price,
    String? publisher,
    String? bookId,
    double? internalPricing,
    String? selfEncoding,
    double? purchasePrice,
    int? publicationYear,
    double? retailDiscount,
    double? wholesaleDiscount,
    double? wholesalePrice,
    double? memberDiscount,
    String? purchaseSaleMode,
    String? bookmark,
    String? packaging,
    String? properity,
    String? statisticalClass,
    String? operator,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BooksData(
    id: id ?? this.id,
    title: title ?? this.title,
    author: author ?? this.author,
    isbn: isbn ?? this.isbn,
    category: category ?? this.category,
    price: price ?? this.price,
    publisher: publisher ?? this.publisher,
    bookId: bookId ?? this.bookId,
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
    operator: operator ?? this.operator,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BooksData copyWithCompanion(BooksCompanion data) {
    return BooksData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      isbn: data.isbn.present ? data.isbn.value : this.isbn,
      category: data.category.present ? data.category.value : this.category,
      price: data.price.present ? data.price.value : this.price,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      internalPricing:
          data.internalPricing.present
              ? data.internalPricing.value
              : this.internalPricing,
      selfEncoding:
          data.selfEncoding.present
              ? data.selfEncoding.value
              : this.selfEncoding,
      purchasePrice:
          data.purchasePrice.present
              ? data.purchasePrice.value
              : this.purchasePrice,
      publicationYear:
          data.publicationYear.present
              ? data.publicationYear.value
              : this.publicationYear,
      retailDiscount:
          data.retailDiscount.present
              ? data.retailDiscount.value
              : this.retailDiscount,
      wholesaleDiscount:
          data.wholesaleDiscount.present
              ? data.wholesaleDiscount.value
              : this.wholesaleDiscount,
      wholesalePrice:
          data.wholesalePrice.present
              ? data.wholesalePrice.value
              : this.wholesalePrice,
      memberDiscount:
          data.memberDiscount.present
              ? data.memberDiscount.value
              : this.memberDiscount,
      purchaseSaleMode:
          data.purchaseSaleMode.present
              ? data.purchaseSaleMode.value
              : this.purchaseSaleMode,
      bookmark: data.bookmark.present ? data.bookmark.value : this.bookmark,
      packaging: data.packaging.present ? data.packaging.value : this.packaging,
      properity: data.properity.present ? data.properity.value : this.properity,
      statisticalClass:
          data.statisticalClass.present
              ? data.statisticalClass.value
              : this.statisticalClass,
      operator: data.operator.present ? data.operator.value : this.operator,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BooksData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('isbn: $isbn, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('publisher: $publisher, ')
          ..write('bookId: $bookId, ')
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
          ..write('operator: $operator, ')
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
    bookId,
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
    operator,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BooksData &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.isbn == this.isbn &&
          other.category == this.category &&
          other.price == this.price &&
          other.publisher == this.publisher &&
          other.bookId == this.bookId &&
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
          other.operator == this.operator &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BooksCompanion extends UpdateCompanion<BooksData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String> isbn;
  final Value<String> category;
  final Value<double> price;
  final Value<String> publisher;
  final Value<String> bookId;
  final Value<double> internalPricing;
  final Value<String> selfEncoding;
  final Value<double> purchasePrice;
  final Value<int> publicationYear;
  final Value<double> retailDiscount;
  final Value<double> wholesaleDiscount;
  final Value<double> wholesalePrice;
  final Value<double> memberDiscount;
  final Value<String> purchaseSaleMode;
  final Value<String> bookmark;
  final Value<String> packaging;
  final Value<String> properity;
  final Value<String> statisticalClass;
  final Value<String> operator;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.isbn = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.publisher = const Value.absent(),
    this.bookId = const Value.absent(),
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
    this.operator = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BooksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String author,
    required String isbn,
    required String category,
    required double price,
    required String publisher,
    required String bookId,
    required double internalPricing,
    required String selfEncoding,
    required double purchasePrice,
    required int publicationYear,
    required double retailDiscount,
    required double wholesaleDiscount,
    required double wholesalePrice,
    required double memberDiscount,
    required String purchaseSaleMode,
    required String bookmark,
    required String packaging,
    required String properity,
    required String statisticalClass,
    required String operator,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       author = Value(author),
       isbn = Value(isbn),
       category = Value(category),
       price = Value(price),
       publisher = Value(publisher),
       bookId = Value(bookId),
       internalPricing = Value(internalPricing),
       selfEncoding = Value(selfEncoding),
       purchasePrice = Value(purchasePrice),
       publicationYear = Value(publicationYear),
       retailDiscount = Value(retailDiscount),
       wholesaleDiscount = Value(wholesaleDiscount),
       wholesalePrice = Value(wholesalePrice),
       memberDiscount = Value(memberDiscount),
       purchaseSaleMode = Value(purchaseSaleMode),
       bookmark = Value(bookmark),
       packaging = Value(packaging),
       properity = Value(properity),
       statisticalClass = Value(statisticalClass),
       operator = Value(operator);
  static Insertable<BooksData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? isbn,
    Expression<String>? category,
    Expression<double>? price,
    Expression<String>? publisher,
    Expression<String>? bookId,
    Expression<double>? internalPricing,
    Expression<String>? selfEncoding,
    Expression<double>? purchasePrice,
    Expression<int>? publicationYear,
    Expression<double>? retailDiscount,
    Expression<double>? wholesaleDiscount,
    Expression<double>? wholesalePrice,
    Expression<double>? memberDiscount,
    Expression<String>? purchaseSaleMode,
    Expression<String>? bookmark,
    Expression<String>? packaging,
    Expression<String>? properity,
    Expression<String>? statisticalClass,
    Expression<String>? operator,
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
      if (bookId != null) 'book_id': bookId,
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
      if (operator != null) 'operator': operator,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BooksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? author,
    Value<String>? isbn,
    Value<String>? category,
    Value<double>? price,
    Value<String>? publisher,
    Value<String>? bookId,
    Value<double>? internalPricing,
    Value<String>? selfEncoding,
    Value<double>? purchasePrice,
    Value<int>? publicationYear,
    Value<double>? retailDiscount,
    Value<double>? wholesaleDiscount,
    Value<double>? wholesalePrice,
    Value<double>? memberDiscount,
    Value<String>? purchaseSaleMode,
    Value<String>? bookmark,
    Value<String>? packaging,
    Value<String>? properity,
    Value<String>? statisticalClass,
    Value<String>? operator,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      isbn: isbn ?? this.isbn,
      category: category ?? this.category,
      price: price ?? this.price,
      publisher: publisher ?? this.publisher,
      bookId: bookId ?? this.bookId,
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
      operator: operator ?? this.operator,
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
      map['price'] = Variable<double>(price.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (internalPricing.present) {
      map['internal_pricing'] = Variable<double>(internalPricing.value);
    }
    if (selfEncoding.present) {
      map['self_encoding'] = Variable<String>(selfEncoding.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (publicationYear.present) {
      map['publication_year'] = Variable<int>(publicationYear.value);
    }
    if (retailDiscount.present) {
      map['retail_discount'] = Variable<double>(retailDiscount.value);
    }
    if (wholesaleDiscount.present) {
      map['wholesale_discount'] = Variable<double>(wholesaleDiscount.value);
    }
    if (wholesalePrice.present) {
      map['wholesale_price'] = Variable<double>(wholesalePrice.value);
    }
    if (memberDiscount.present) {
      map['member_discount'] = Variable<double>(memberDiscount.value);
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
    if (operator.present) {
      map['operator'] = Variable<String>(operator.value);
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
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('isbn: $isbn, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('publisher: $publisher, ')
          ..write('bookId: $bookId, ')
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
          ..write('operator: $operator, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class Users extends Table with TableInfo<Users, UsersData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Users(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
    'salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      username:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}username'],
          )!,
      password:
          attachedDatabase.typeMapping.read(
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
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      role:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}role'],
          )!,
      salt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}salt'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}status'],
          )!,
    );
  }

  @override
  Users createAlias(String alias) {
    return Users(attachedDatabase, alias);
  }
}

class UsersData extends DataClass implements Insertable<UsersData> {
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
  const UsersData({
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
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      role: Value(role),
      salt: Value(salt),
      status: Value(status),
    );
  }

  factory UsersData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersData(
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

  UsersData copyWith({
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
  }) => UsersData(
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
  UsersData copyWithCompanion(UsersCompanion data) {
    return UsersData(
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
    return (StringBuffer('UsersData(')
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
      (other is UsersData &&
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

class UsersCompanion extends UpdateCompanion<UsersData> {
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
  static Insertable<UsersData> custom({
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

class DatabaseAtV2 extends GeneratedDatabase {
  DatabaseAtV2(QueryExecutor e) : super(e);
  late final Books books = Books(this);
  late final Users users = Users(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [books, users];
  @override
  int get schemaVersion => 2;
}
