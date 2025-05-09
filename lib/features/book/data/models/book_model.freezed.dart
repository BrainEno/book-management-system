// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookModel {

 String get bookId; int get id; String get title; String get author; String get isbn; double get price; String get category; String get publisher; String get selfEncoding; double get internalPricing; double get purchasePrice; int get publicationYear; double get retailDiscount; double get wholesaleDiscount; double get wholesalePrice; double get memberDiscount; String get purchaseSaleMode; String get bookmark; String get packaging; String get properity; String get statisticalClass; String get operator; DateTime? get createdAt; DateTime? get updatedAt;// Example additional field
 String get additionalField;
/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookModelCopyWith<BookModel> get copyWith => _$BookModelCopyWithImpl<BookModel>(this as BookModel, _$identity);

  /// Serializes this BookModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookModel&&(identical(other.bookId, bookId) || other.bookId == bookId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.isbn, isbn) || other.isbn == isbn)&&(identical(other.price, price) || other.price == price)&&(identical(other.category, category) || other.category == category)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.selfEncoding, selfEncoding) || other.selfEncoding == selfEncoding)&&(identical(other.internalPricing, internalPricing) || other.internalPricing == internalPricing)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.publicationYear, publicationYear) || other.publicationYear == publicationYear)&&(identical(other.retailDiscount, retailDiscount) || other.retailDiscount == retailDiscount)&&(identical(other.wholesaleDiscount, wholesaleDiscount) || other.wholesaleDiscount == wholesaleDiscount)&&(identical(other.wholesalePrice, wholesalePrice) || other.wholesalePrice == wholesalePrice)&&(identical(other.memberDiscount, memberDiscount) || other.memberDiscount == memberDiscount)&&(identical(other.purchaseSaleMode, purchaseSaleMode) || other.purchaseSaleMode == purchaseSaleMode)&&(identical(other.bookmark, bookmark) || other.bookmark == bookmark)&&(identical(other.packaging, packaging) || other.packaging == packaging)&&(identical(other.properity, properity) || other.properity == properity)&&(identical(other.statisticalClass, statisticalClass) || other.statisticalClass == statisticalClass)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.additionalField, additionalField) || other.additionalField == additionalField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,bookId,id,title,author,isbn,price,category,publisher,selfEncoding,internalPricing,purchasePrice,publicationYear,retailDiscount,wholesaleDiscount,wholesalePrice,memberDiscount,purchaseSaleMode,bookmark,packaging,properity,statisticalClass,operator,createdAt,updatedAt,additionalField]);

@override
String toString() {
  return 'BookModel(bookId: $bookId, id: $id, title: $title, author: $author, isbn: $isbn, price: $price, category: $category, publisher: $publisher, selfEncoding: $selfEncoding, internalPricing: $internalPricing, purchasePrice: $purchasePrice, publicationYear: $publicationYear, retailDiscount: $retailDiscount, wholesaleDiscount: $wholesaleDiscount, wholesalePrice: $wholesalePrice, memberDiscount: $memberDiscount, purchaseSaleMode: $purchaseSaleMode, bookmark: $bookmark, packaging: $packaging, properity: $properity, statisticalClass: $statisticalClass, operator: $operator, createdAt: $createdAt, updatedAt: $updatedAt, additionalField: $additionalField)';
}


}

/// @nodoc
abstract mixin class $BookModelCopyWith<$Res>  {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) _then) = _$BookModelCopyWithImpl;
@useResult
$Res call({
 String bookId, int id, String title, String author, String isbn, double price, String category, String publisher, String selfEncoding, double internalPricing, double purchasePrice, int publicationYear, double retailDiscount, double wholesaleDiscount, double wholesalePrice, double memberDiscount, String purchaseSaleMode, String bookmark, String packaging, String properity, String statisticalClass, String operator, DateTime? createdAt, DateTime? updatedAt, String additionalField
});




}
/// @nodoc
class _$BookModelCopyWithImpl<$Res>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._self, this._then);

  final BookModel _self;
  final $Res Function(BookModel) _then;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookId = null,Object? id = null,Object? title = null,Object? author = null,Object? isbn = null,Object? price = null,Object? category = null,Object? publisher = null,Object? selfEncoding = null,Object? internalPricing = null,Object? purchasePrice = null,Object? publicationYear = null,Object? retailDiscount = null,Object? wholesaleDiscount = null,Object? wholesalePrice = null,Object? memberDiscount = null,Object? purchaseSaleMode = null,Object? bookmark = null,Object? packaging = null,Object? properity = null,Object? statisticalClass = null,Object? operator = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? additionalField = null,}) {
  return _then(_self.copyWith(
bookId: null == bookId ? _self.bookId : bookId // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,isbn: null == isbn ? _self.isbn : isbn // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,selfEncoding: null == selfEncoding ? _self.selfEncoding : selfEncoding // ignore: cast_nullable_to_non_nullable
as String,internalPricing: null == internalPricing ? _self.internalPricing : internalPricing // ignore: cast_nullable_to_non_nullable
as double,purchasePrice: null == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double,publicationYear: null == publicationYear ? _self.publicationYear : publicationYear // ignore: cast_nullable_to_non_nullable
as int,retailDiscount: null == retailDiscount ? _self.retailDiscount : retailDiscount // ignore: cast_nullable_to_non_nullable
as double,wholesaleDiscount: null == wholesaleDiscount ? _self.wholesaleDiscount : wholesaleDiscount // ignore: cast_nullable_to_non_nullable
as double,wholesalePrice: null == wholesalePrice ? _self.wholesalePrice : wholesalePrice // ignore: cast_nullable_to_non_nullable
as double,memberDiscount: null == memberDiscount ? _self.memberDiscount : memberDiscount // ignore: cast_nullable_to_non_nullable
as double,purchaseSaleMode: null == purchaseSaleMode ? _self.purchaseSaleMode : purchaseSaleMode // ignore: cast_nullable_to_non_nullable
as String,bookmark: null == bookmark ? _self.bookmark : bookmark // ignore: cast_nullable_to_non_nullable
as String,packaging: null == packaging ? _self.packaging : packaging // ignore: cast_nullable_to_non_nullable
as String,properity: null == properity ? _self.properity : properity // ignore: cast_nullable_to_non_nullable
as String,statisticalClass: null == statisticalClass ? _self.statisticalClass : statisticalClass // ignore: cast_nullable_to_non_nullable
as String,operator: null == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,additionalField: null == additionalField ? _self.additionalField : additionalField // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BookModel extends BookModel {
   _BookModel({required final  String bookId, required final  int id, required final  String title, required final  String author, required final  String isbn, required final  double price, required final  String category, required final  String publisher, required final  String selfEncoding, this.internalPricing = 0.0, this.purchasePrice = 0.0, this.publicationYear = 2025, this.retailDiscount = 100, this.wholesaleDiscount = 100, this.wholesalePrice = 0, this.memberDiscount = 100, this.purchaseSaleMode = '不区分', this.bookmark = '不区分', this.packaging = '不区分', this.properity = '不区分', this.statisticalClass = '不区分', required final  String operator, this.createdAt, this.updatedAt, this.additionalField = ''}): super._(bookId: bookId, id: id, title: title, author: author, isbn: isbn, price: price, category: category, publisher: publisher, selfEncoding: selfEncoding, operator: operator);
  factory _BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);

@override@JsonKey() final  double internalPricing;
@override@JsonKey() final  double purchasePrice;
@override@JsonKey() final  int publicationYear;
@override@JsonKey() final  double retailDiscount;
@override@JsonKey() final  double wholesaleDiscount;
@override@JsonKey() final  double wholesalePrice;
@override@JsonKey() final  double memberDiscount;
@override@JsonKey() final  String purchaseSaleMode;
@override@JsonKey() final  String bookmark;
@override@JsonKey() final  String packaging;
@override@JsonKey() final  String properity;
@override@JsonKey() final  String statisticalClass;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
// Example additional field
@override@JsonKey() final  String additionalField;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookModelCopyWith<_BookModel> get copyWith => __$BookModelCopyWithImpl<_BookModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookModel&&(identical(other.bookId, bookId) || other.bookId == bookId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.isbn, isbn) || other.isbn == isbn)&&(identical(other.price, price) || other.price == price)&&(identical(other.category, category) || other.category == category)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.selfEncoding, selfEncoding) || other.selfEncoding == selfEncoding)&&(identical(other.internalPricing, internalPricing) || other.internalPricing == internalPricing)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.publicationYear, publicationYear) || other.publicationYear == publicationYear)&&(identical(other.retailDiscount, retailDiscount) || other.retailDiscount == retailDiscount)&&(identical(other.wholesaleDiscount, wholesaleDiscount) || other.wholesaleDiscount == wholesaleDiscount)&&(identical(other.wholesalePrice, wholesalePrice) || other.wholesalePrice == wholesalePrice)&&(identical(other.memberDiscount, memberDiscount) || other.memberDiscount == memberDiscount)&&(identical(other.purchaseSaleMode, purchaseSaleMode) || other.purchaseSaleMode == purchaseSaleMode)&&(identical(other.bookmark, bookmark) || other.bookmark == bookmark)&&(identical(other.packaging, packaging) || other.packaging == packaging)&&(identical(other.properity, properity) || other.properity == properity)&&(identical(other.statisticalClass, statisticalClass) || other.statisticalClass == statisticalClass)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.additionalField, additionalField) || other.additionalField == additionalField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,bookId,id,title,author,isbn,price,category,publisher,selfEncoding,internalPricing,purchasePrice,publicationYear,retailDiscount,wholesaleDiscount,wholesalePrice,memberDiscount,purchaseSaleMode,bookmark,packaging,properity,statisticalClass,operator,createdAt,updatedAt,additionalField]);

@override
String toString() {
  return 'BookModel(bookId: $bookId, id: $id, title: $title, author: $author, isbn: $isbn, price: $price, category: $category, publisher: $publisher, selfEncoding: $selfEncoding, internalPricing: $internalPricing, purchasePrice: $purchasePrice, publicationYear: $publicationYear, retailDiscount: $retailDiscount, wholesaleDiscount: $wholesaleDiscount, wholesalePrice: $wholesalePrice, memberDiscount: $memberDiscount, purchaseSaleMode: $purchaseSaleMode, bookmark: $bookmark, packaging: $packaging, properity: $properity, statisticalClass: $statisticalClass, operator: $operator, createdAt: $createdAt, updatedAt: $updatedAt, additionalField: $additionalField)';
}


}

/// @nodoc
abstract mixin class _$BookModelCopyWith<$Res> implements $BookModelCopyWith<$Res> {
  factory _$BookModelCopyWith(_BookModel value, $Res Function(_BookModel) _then) = __$BookModelCopyWithImpl;
@override @useResult
$Res call({
 String bookId, int id, String title, String author, String isbn, double price, String category, String publisher, String selfEncoding, double internalPricing, double purchasePrice, int publicationYear, double retailDiscount, double wholesaleDiscount, double wholesalePrice, double memberDiscount, String purchaseSaleMode, String bookmark, String packaging, String properity, String statisticalClass, String operator, DateTime? createdAt, DateTime? updatedAt, String additionalField
});




}
/// @nodoc
class __$BookModelCopyWithImpl<$Res>
    implements _$BookModelCopyWith<$Res> {
  __$BookModelCopyWithImpl(this._self, this._then);

  final _BookModel _self;
  final $Res Function(_BookModel) _then;

/// Create a copy of BookModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookId = null,Object? id = null,Object? title = null,Object? author = null,Object? isbn = null,Object? price = null,Object? category = null,Object? publisher = null,Object? selfEncoding = null,Object? internalPricing = null,Object? purchasePrice = null,Object? publicationYear = null,Object? retailDiscount = null,Object? wholesaleDiscount = null,Object? wholesalePrice = null,Object? memberDiscount = null,Object? purchaseSaleMode = null,Object? bookmark = null,Object? packaging = null,Object? properity = null,Object? statisticalClass = null,Object? operator = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? additionalField = null,}) {
  return _then(_BookModel(
bookId: null == bookId ? _self.bookId : bookId // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,isbn: null == isbn ? _self.isbn : isbn // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,selfEncoding: null == selfEncoding ? _self.selfEncoding : selfEncoding // ignore: cast_nullable_to_non_nullable
as String,internalPricing: null == internalPricing ? _self.internalPricing : internalPricing // ignore: cast_nullable_to_non_nullable
as double,purchasePrice: null == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double,publicationYear: null == publicationYear ? _self.publicationYear : publicationYear // ignore: cast_nullable_to_non_nullable
as int,retailDiscount: null == retailDiscount ? _self.retailDiscount : retailDiscount // ignore: cast_nullable_to_non_nullable
as double,wholesaleDiscount: null == wholesaleDiscount ? _self.wholesaleDiscount : wholesaleDiscount // ignore: cast_nullable_to_non_nullable
as double,wholesalePrice: null == wholesalePrice ? _self.wholesalePrice : wholesalePrice // ignore: cast_nullable_to_non_nullable
as double,memberDiscount: null == memberDiscount ? _self.memberDiscount : memberDiscount // ignore: cast_nullable_to_non_nullable
as double,purchaseSaleMode: null == purchaseSaleMode ? _self.purchaseSaleMode : purchaseSaleMode // ignore: cast_nullable_to_non_nullable
as String,bookmark: null == bookmark ? _self.bookmark : bookmark // ignore: cast_nullable_to_non_nullable
as String,packaging: null == packaging ? _self.packaging : packaging // ignore: cast_nullable_to_non_nullable
as String,properity: null == properity ? _self.properity : properity // ignore: cast_nullable_to_non_nullable
as String,statisticalClass: null == statisticalClass ? _self.statisticalClass : statisticalClass // ignore: cast_nullable_to_non_nullable
as String,operator: null == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,additionalField: null == additionalField ? _self.additionalField : additionalField // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
