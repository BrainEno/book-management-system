// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isbnMeta = const VerificationMeta('isbn');
  @override
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
    'isbn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _internalPricingMeta = const VerificationMeta(
    'internalPricing',
  );
  @override
  late final GeneratedColumn<double> internalPricing = GeneratedColumn<double>(
    'internal_pricing',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selfEncodingMeta = const VerificationMeta(
    'selfEncoding',
  );
  @override
  late final GeneratedColumn<String> selfEncoding = GeneratedColumn<String>(
    'self_encoding',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publicationYearMeta = const VerificationMeta(
    'publicationYear',
  );
  @override
  late final GeneratedColumn<int> publicationYear = GeneratedColumn<int>(
    'publication_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retailDiscountMeta = const VerificationMeta(
    'retailDiscount',
  );
  @override
  late final GeneratedColumn<double> retailDiscount = GeneratedColumn<double>(
    'retail_discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wholesaleDiscountMeta = const VerificationMeta(
    'wholesaleDiscount',
  );
  @override
  late final GeneratedColumn<double> wholesaleDiscount =
      GeneratedColumn<double>(
        'wholesale_discount',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _wholesalePriceMeta = const VerificationMeta(
    'wholesalePrice',
  );
  @override
  late final GeneratedColumn<double> wholesalePrice = GeneratedColumn<double>(
    'wholesale_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberDiscountMeta = const VerificationMeta(
    'memberDiscount',
  );
  @override
  late final GeneratedColumn<double> memberDiscount = GeneratedColumn<double>(
    'member_discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseSaleModeMeta = const VerificationMeta(
    'purchaseSaleMode',
  );
  @override
  late final GeneratedColumn<String> purchaseSaleMode = GeneratedColumn<String>(
    'purchase_sale_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookmarkMeta = const VerificationMeta(
    'bookmark',
  );
  @override
  late final GeneratedColumn<String> bookmark = GeneratedColumn<String>(
    'bookmark',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packagingMeta = const VerificationMeta(
    'packaging',
  );
  @override
  late final GeneratedColumn<String> packaging = GeneratedColumn<String>(
    'packaging',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _properityMeta = const VerificationMeta(
    'properity',
  );
  @override
  late final GeneratedColumn<String> properity = GeneratedColumn<String>(
    'properity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statisticalClassMeta = const VerificationMeta(
    'statisticalClass',
  );
  @override
  late final GeneratedColumn<String> statisticalClass = GeneratedColumn<String>(
    'statistical_class',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operatorMeta = const VerificationMeta(
    'operator',
  );
  @override
  late final GeneratedColumn<String> operator = GeneratedColumn<String>(
    'operator',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  VerificationContext validateIntegrity(
    Insertable<Book> instance, {
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
    } else if (isInserting) {
      context.missing(_isbnMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    } else if (isInserting) {
      context.missing(_publisherMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('internal_pricing')) {
      context.handle(
        _internalPricingMeta,
        internalPricing.isAcceptableOrUnknown(
          data['internal_pricing']!,
          _internalPricingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_internalPricingMeta);
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
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('publication_year')) {
      context.handle(
        _publicationYearMeta,
        publicationYear.isAcceptableOrUnknown(
          data['publication_year']!,
          _publicationYearMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publicationYearMeta);
    }
    if (data.containsKey('retail_discount')) {
      context.handle(
        _retailDiscountMeta,
        retailDiscount.isAcceptableOrUnknown(
          data['retail_discount']!,
          _retailDiscountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_retailDiscountMeta);
    }
    if (data.containsKey('wholesale_discount')) {
      context.handle(
        _wholesaleDiscountMeta,
        wholesaleDiscount.isAcceptableOrUnknown(
          data['wholesale_discount']!,
          _wholesaleDiscountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wholesaleDiscountMeta);
    }
    if (data.containsKey('wholesale_price')) {
      context.handle(
        _wholesalePriceMeta,
        wholesalePrice.isAcceptableOrUnknown(
          data['wholesale_price']!,
          _wholesalePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wholesalePriceMeta);
    }
    if (data.containsKey('member_discount')) {
      context.handle(
        _memberDiscountMeta,
        memberDiscount.isAcceptableOrUnknown(
          data['member_discount']!,
          _memberDiscountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_memberDiscountMeta);
    }
    if (data.containsKey('purchase_sale_mode')) {
      context.handle(
        _purchaseSaleModeMeta,
        purchaseSaleMode.isAcceptableOrUnknown(
          data['purchase_sale_mode']!,
          _purchaseSaleModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseSaleModeMeta);
    }
    if (data.containsKey('bookmark')) {
      context.handle(
        _bookmarkMeta,
        bookmark.isAcceptableOrUnknown(data['bookmark']!, _bookmarkMeta),
      );
    } else if (isInserting) {
      context.missing(_bookmarkMeta);
    }
    if (data.containsKey('packaging')) {
      context.handle(
        _packagingMeta,
        packaging.isAcceptableOrUnknown(data['packaging']!, _packagingMeta),
      );
    } else if (isInserting) {
      context.missing(_packagingMeta);
    }
    if (data.containsKey('properity')) {
      context.handle(
        _properityMeta,
        properity.isAcceptableOrUnknown(data['properity']!, _properityMeta),
      );
    } else if (isInserting) {
      context.missing(_properityMeta);
    }
    if (data.containsKey('statistical_class')) {
      context.handle(
        _statisticalClassMeta,
        statisticalClass.isAcceptableOrUnknown(
          data['statistical_class']!,
          _statisticalClassMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statisticalClassMeta);
    }
    if (data.containsKey('operator')) {
      context.handle(
        _operatorMeta,
        operator.isAcceptableOrUnknown(data['operator']!, _operatorMeta),
      );
    } else if (isInserting) {
      context.missing(_operatorMeta);
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
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
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
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
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
  const Book({
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

  factory Book.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
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

  Book copyWith({
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
  }) => Book(
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
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
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
    return (StringBuffer('Book(')
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
      (other is Book &&
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

class BooksCompanion extends UpdateCompanion<Book> {
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
  static Insertable<Book> custom({
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
    defaultValue: const Constant(0),
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final BookDao bookDao = BookDao(this as AppDatabase);
  late final UserDao userDao = UserDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [books, users];
}

typedef $$BooksTableCreateCompanionBuilder =
    BooksCompanion Function({
      Value<int> id,
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
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$BooksTableUpdateCompanionBuilder =
    BooksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> author,
      Value<String> isbn,
      Value<String> category,
      Value<double> price,
      Value<String> publisher,
      Value<String> bookId,
      Value<double> internalPricing,
      Value<String> selfEncoding,
      Value<double> purchasePrice,
      Value<int> publicationYear,
      Value<double> retailDiscount,
      Value<double> wholesaleDiscount,
      Value<double> wholesalePrice,
      Value<double> memberDiscount,
      Value<String> purchaseSaleMode,
      Value<String> bookmark,
      Value<String> packaging,
      Value<String> properity,
      Value<String> statisticalClass,
      Value<String> operator,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
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

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get internalPricing => $composableBuilder(
    column: $table.internalPricing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selfEncoding => $composableBuilder(
    column: $table.selfEncoding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get publicationYear => $composableBuilder(
    column: $table.publicationYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get retailDiscount => $composableBuilder(
    column: $table.retailDiscount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wholesaleDiscount => $composableBuilder(
    column: $table.wholesaleDiscount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get memberDiscount => $composableBuilder(
    column: $table.memberDiscount,
    builder: (column) => ColumnFilters(column),
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

  ColumnFilters<String> get operator => $composableBuilder(
    column: $table.operator,
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

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
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

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get internalPricing => $composableBuilder(
    column: $table.internalPricing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selfEncoding => $composableBuilder(
    column: $table.selfEncoding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get publicationYear => $composableBuilder(
    column: $table.publicationYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get retailDiscount => $composableBuilder(
    column: $table.retailDiscount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wholesaleDiscount => $composableBuilder(
    column: $table.wholesaleDiscount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get memberDiscount => $composableBuilder(
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

  ColumnOrderings<String> get operator => $composableBuilder(
    column: $table.operator,
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

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
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

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<double> get internalPricing => $composableBuilder(
    column: $table.internalPricing,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selfEncoding => $composableBuilder(
    column: $table.selfEncoding,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get publicationYear => $composableBuilder(
    column: $table.publicationYear,
    builder: (column) => column,
  );

  GeneratedColumn<double> get retailDiscount => $composableBuilder(
    column: $table.retailDiscount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wholesaleDiscount => $composableBuilder(
    column: $table.wholesaleDiscount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get memberDiscount => $composableBuilder(
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

  GeneratedColumn<String> get operator =>
      $composableBuilder(column: $table.operator, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          Book,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (Book, BaseReferences<_$AppDatabase, $BooksTable, Book>),
          Book,
          PrefetchHooks Function()
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> isbn = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> publisher = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<double> internalPricing = const Value.absent(),
                Value<String> selfEncoding = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<int> publicationYear = const Value.absent(),
                Value<double> retailDiscount = const Value.absent(),
                Value<double> wholesaleDiscount = const Value.absent(),
                Value<double> wholesalePrice = const Value.absent(),
                Value<double> memberDiscount = const Value.absent(),
                Value<String> purchaseSaleMode = const Value.absent(),
                Value<String> bookmark = const Value.absent(),
                Value<String> packaging = const Value.absent(),
                Value<String> properity = const Value.absent(),
                Value<String> statisticalClass = const Value.absent(),
                Value<String> operator = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BooksCompanion(
                id: id,
                title: title,
                author: author,
                isbn: isbn,
                category: category,
                price: price,
                publisher: publisher,
                bookId: bookId,
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
                operator: operator,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
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
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BooksCompanion.insert(
                id: id,
                title: title,
                author: author,
                isbn: isbn,
                category: category,
                price: price,
                publisher: publisher,
                bookId: bookId,
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
                operator: operator,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      Book,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (Book, BaseReferences<_$AppDatabase, $BooksTable, Book>),
      Book,
      PrefetchHooks Function()
    >;
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
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UsersTableAnnotationComposer($db: db, $table: table),
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
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
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
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
