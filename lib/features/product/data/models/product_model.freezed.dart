// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {

 String get productId; int get id; String get title; String get author; String? get isbn; double get price; String? get category; int? get categoryId; String? get publisher; int? get publisherId; String get selfEncoding; double? get internalPricing; double? get purchasePrice; int? get publicationYear; double? get retailDiscount; double? get wholesaleDiscount; double? get wholesalePrice; double? get memberDiscount; String? get purchaseSaleMode; int? get purchaseSaleModeId; String? get bookmark; String? get packaging; String? get properity; String? get statisticalClass; int get status; String get stockUnit; int? get minStockAlertQty; int? get maxStockAlertQty; int? get createdBy; int? get updatedBy; String? get operator; DateTime? get createdAt; DateTime? get updatedAt;// Example additional field
 String get additionalField;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.isbn, isbn) || other.isbn == isbn)&&(identical(other.price, price) || other.price == price)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.publisherId, publisherId) || other.publisherId == publisherId)&&(identical(other.selfEncoding, selfEncoding) || other.selfEncoding == selfEncoding)&&(identical(other.internalPricing, internalPricing) || other.internalPricing == internalPricing)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.publicationYear, publicationYear) || other.publicationYear == publicationYear)&&(identical(other.retailDiscount, retailDiscount) || other.retailDiscount == retailDiscount)&&(identical(other.wholesaleDiscount, wholesaleDiscount) || other.wholesaleDiscount == wholesaleDiscount)&&(identical(other.wholesalePrice, wholesalePrice) || other.wholesalePrice == wholesalePrice)&&(identical(other.memberDiscount, memberDiscount) || other.memberDiscount == memberDiscount)&&(identical(other.purchaseSaleMode, purchaseSaleMode) || other.purchaseSaleMode == purchaseSaleMode)&&(identical(other.purchaseSaleModeId, purchaseSaleModeId) || other.purchaseSaleModeId == purchaseSaleModeId)&&(identical(other.bookmark, bookmark) || other.bookmark == bookmark)&&(identical(other.packaging, packaging) || other.packaging == packaging)&&(identical(other.properity, properity) || other.properity == properity)&&(identical(other.statisticalClass, statisticalClass) || other.statisticalClass == statisticalClass)&&(identical(other.status, status) || other.status == status)&&(identical(other.stockUnit, stockUnit) || other.stockUnit == stockUnit)&&(identical(other.minStockAlertQty, minStockAlertQty) || other.minStockAlertQty == minStockAlertQty)&&(identical(other.maxStockAlertQty, maxStockAlertQty) || other.maxStockAlertQty == maxStockAlertQty)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.additionalField, additionalField) || other.additionalField == additionalField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,productId,id,title,author,isbn,price,category,categoryId,publisher,publisherId,selfEncoding,internalPricing,purchasePrice,publicationYear,retailDiscount,wholesaleDiscount,wholesalePrice,memberDiscount,purchaseSaleMode,purchaseSaleModeId,bookmark,packaging,properity,statisticalClass,status,stockUnit,minStockAlertQty,maxStockAlertQty,createdBy,updatedBy,operator,createdAt,updatedAt,additionalField]);

@override
String toString() {
  return 'ProductModel(productId: $productId, id: $id, title: $title, author: $author, isbn: $isbn, price: $price, category: $category, categoryId: $categoryId, publisher: $publisher, publisherId: $publisherId, selfEncoding: $selfEncoding, internalPricing: $internalPricing, purchasePrice: $purchasePrice, publicationYear: $publicationYear, retailDiscount: $retailDiscount, wholesaleDiscount: $wholesaleDiscount, wholesalePrice: $wholesalePrice, memberDiscount: $memberDiscount, purchaseSaleMode: $purchaseSaleMode, purchaseSaleModeId: $purchaseSaleModeId, bookmark: $bookmark, packaging: $packaging, properity: $properity, statisticalClass: $statisticalClass, status: $status, stockUnit: $stockUnit, minStockAlertQty: $minStockAlertQty, maxStockAlertQty: $maxStockAlertQty, createdBy: $createdBy, updatedBy: $updatedBy, operator: $operator, createdAt: $createdAt, updatedAt: $updatedAt, additionalField: $additionalField)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
 String productId, int id, String title, String author, String? isbn, double price, String? category, int? categoryId, String? publisher, int? publisherId, String selfEncoding, double? internalPricing, double? purchasePrice, int? publicationYear, double? retailDiscount, double? wholesaleDiscount, double? wholesalePrice, double? memberDiscount, String? purchaseSaleMode, int? purchaseSaleModeId, String? bookmark, String? packaging, String? properity, String? statisticalClass, int status, String stockUnit, int? minStockAlertQty, int? maxStockAlertQty, int? createdBy, int? updatedBy, String? operator, DateTime? createdAt, DateTime? updatedAt, String additionalField
});




}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? id = null,Object? title = null,Object? author = null,Object? isbn = freezed,Object? price = null,Object? category = freezed,Object? categoryId = freezed,Object? publisher = freezed,Object? publisherId = freezed,Object? selfEncoding = null,Object? internalPricing = freezed,Object? purchasePrice = freezed,Object? publicationYear = freezed,Object? retailDiscount = freezed,Object? wholesaleDiscount = freezed,Object? wholesalePrice = freezed,Object? memberDiscount = freezed,Object? purchaseSaleMode = freezed,Object? purchaseSaleModeId = freezed,Object? bookmark = freezed,Object? packaging = freezed,Object? properity = freezed,Object? statisticalClass = freezed,Object? status = null,Object? stockUnit = null,Object? minStockAlertQty = freezed,Object? maxStockAlertQty = freezed,Object? createdBy = freezed,Object? updatedBy = freezed,Object? operator = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? additionalField = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,isbn: freezed == isbn ? _self.isbn : isbn // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String?,publisherId: freezed == publisherId ? _self.publisherId : publisherId // ignore: cast_nullable_to_non_nullable
as int?,selfEncoding: null == selfEncoding ? _self.selfEncoding : selfEncoding // ignore: cast_nullable_to_non_nullable
as String,internalPricing: freezed == internalPricing ? _self.internalPricing : internalPricing // ignore: cast_nullable_to_non_nullable
as double?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,publicationYear: freezed == publicationYear ? _self.publicationYear : publicationYear // ignore: cast_nullable_to_non_nullable
as int?,retailDiscount: freezed == retailDiscount ? _self.retailDiscount : retailDiscount // ignore: cast_nullable_to_non_nullable
as double?,wholesaleDiscount: freezed == wholesaleDiscount ? _self.wholesaleDiscount : wholesaleDiscount // ignore: cast_nullable_to_non_nullable
as double?,wholesalePrice: freezed == wholesalePrice ? _self.wholesalePrice : wholesalePrice // ignore: cast_nullable_to_non_nullable
as double?,memberDiscount: freezed == memberDiscount ? _self.memberDiscount : memberDiscount // ignore: cast_nullable_to_non_nullable
as double?,purchaseSaleMode: freezed == purchaseSaleMode ? _self.purchaseSaleMode : purchaseSaleMode // ignore: cast_nullable_to_non_nullable
as String?,purchaseSaleModeId: freezed == purchaseSaleModeId ? _self.purchaseSaleModeId : purchaseSaleModeId // ignore: cast_nullable_to_non_nullable
as int?,bookmark: freezed == bookmark ? _self.bookmark : bookmark // ignore: cast_nullable_to_non_nullable
as String?,packaging: freezed == packaging ? _self.packaging : packaging // ignore: cast_nullable_to_non_nullable
as String?,properity: freezed == properity ? _self.properity : properity // ignore: cast_nullable_to_non_nullable
as String?,statisticalClass: freezed == statisticalClass ? _self.statisticalClass : statisticalClass // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,stockUnit: null == stockUnit ? _self.stockUnit : stockUnit // ignore: cast_nullable_to_non_nullable
as String,minStockAlertQty: freezed == minStockAlertQty ? _self.minStockAlertQty : minStockAlertQty // ignore: cast_nullable_to_non_nullable
as int?,maxStockAlertQty: freezed == maxStockAlertQty ? _self.maxStockAlertQty : maxStockAlertQty // ignore: cast_nullable_to_non_nullable
as int?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,updatedBy: freezed == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as int?,operator: freezed == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,additionalField: null == additionalField ? _self.additionalField : additionalField // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  int id,  String title,  String author,  String? isbn,  double price,  String? category,  int? categoryId,  String? publisher,  int? publisherId,  String selfEncoding,  double? internalPricing,  double? purchasePrice,  int? publicationYear,  double? retailDiscount,  double? wholesaleDiscount,  double? wholesalePrice,  double? memberDiscount,  String? purchaseSaleMode,  int? purchaseSaleModeId,  String? bookmark,  String? packaging,  String? properity,  String? statisticalClass,  int status,  String stockUnit,  int? minStockAlertQty,  int? maxStockAlertQty,  int? createdBy,  int? updatedBy,  String? operator,  DateTime? createdAt,  DateTime? updatedAt,  String additionalField)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.productId,_that.id,_that.title,_that.author,_that.isbn,_that.price,_that.category,_that.categoryId,_that.publisher,_that.publisherId,_that.selfEncoding,_that.internalPricing,_that.purchasePrice,_that.publicationYear,_that.retailDiscount,_that.wholesaleDiscount,_that.wholesalePrice,_that.memberDiscount,_that.purchaseSaleMode,_that.purchaseSaleModeId,_that.bookmark,_that.packaging,_that.properity,_that.statisticalClass,_that.status,_that.stockUnit,_that.minStockAlertQty,_that.maxStockAlertQty,_that.createdBy,_that.updatedBy,_that.operator,_that.createdAt,_that.updatedAt,_that.additionalField);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  int id,  String title,  String author,  String? isbn,  double price,  String? category,  int? categoryId,  String? publisher,  int? publisherId,  String selfEncoding,  double? internalPricing,  double? purchasePrice,  int? publicationYear,  double? retailDiscount,  double? wholesaleDiscount,  double? wholesalePrice,  double? memberDiscount,  String? purchaseSaleMode,  int? purchaseSaleModeId,  String? bookmark,  String? packaging,  String? properity,  String? statisticalClass,  int status,  String stockUnit,  int? minStockAlertQty,  int? maxStockAlertQty,  int? createdBy,  int? updatedBy,  String? operator,  DateTime? createdAt,  DateTime? updatedAt,  String additionalField)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.productId,_that.id,_that.title,_that.author,_that.isbn,_that.price,_that.category,_that.categoryId,_that.publisher,_that.publisherId,_that.selfEncoding,_that.internalPricing,_that.purchasePrice,_that.publicationYear,_that.retailDiscount,_that.wholesaleDiscount,_that.wholesalePrice,_that.memberDiscount,_that.purchaseSaleMode,_that.purchaseSaleModeId,_that.bookmark,_that.packaging,_that.properity,_that.statisticalClass,_that.status,_that.stockUnit,_that.minStockAlertQty,_that.maxStockAlertQty,_that.createdBy,_that.updatedBy,_that.operator,_that.createdAt,_that.updatedAt,_that.additionalField);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  int id,  String title,  String author,  String? isbn,  double price,  String? category,  int? categoryId,  String? publisher,  int? publisherId,  String selfEncoding,  double? internalPricing,  double? purchasePrice,  int? publicationYear,  double? retailDiscount,  double? wholesaleDiscount,  double? wholesalePrice,  double? memberDiscount,  String? purchaseSaleMode,  int? purchaseSaleModeId,  String? bookmark,  String? packaging,  String? properity,  String? statisticalClass,  int status,  String stockUnit,  int? minStockAlertQty,  int? maxStockAlertQty,  int? createdBy,  int? updatedBy,  String? operator,  DateTime? createdAt,  DateTime? updatedAt,  String additionalField)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.productId,_that.id,_that.title,_that.author,_that.isbn,_that.price,_that.category,_that.categoryId,_that.publisher,_that.publisherId,_that.selfEncoding,_that.internalPricing,_that.purchasePrice,_that.publicationYear,_that.retailDiscount,_that.wholesaleDiscount,_that.wholesalePrice,_that.memberDiscount,_that.purchaseSaleMode,_that.purchaseSaleModeId,_that.bookmark,_that.packaging,_that.properity,_that.statisticalClass,_that.status,_that.stockUnit,_that.minStockAlertQty,_that.maxStockAlertQty,_that.createdBy,_that.updatedBy,_that.operator,_that.createdAt,_that.updatedAt,_that.additionalField);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
   _ProductModel({required final  String productId, required final  int id, required final  String title, required final  String author, final  String? isbn, required final  double price, final  String? category, final  int? categoryId, final  String? publisher, final  int? publisherId, required final  String selfEncoding, this.internalPricing, this.purchasePrice, this.publicationYear, this.retailDiscount, this.wholesaleDiscount, this.wholesalePrice, this.memberDiscount, this.purchaseSaleMode, final  int? purchaseSaleModeId, this.bookmark, this.packaging, this.properity, this.statisticalClass, final  int status = 1, final  String stockUnit = '册', final  int? minStockAlertQty, final  int? maxStockAlertQty, final  int? createdBy, final  int? updatedBy, final  String? operator, this.createdAt, this.updatedAt, this.additionalField = ''}): super._(productId: productId, id: id, title: title, author: author, isbn: isbn, price: price, category: category, categoryId: categoryId, publisher: publisher, publisherId: publisherId, selfEncoding: selfEncoding, purchaseSaleModeId: purchaseSaleModeId, status: status, stockUnit: stockUnit, minStockAlertQty: minStockAlertQty, maxStockAlertQty: maxStockAlertQty, createdBy: createdBy, updatedBy: updatedBy, operator: operator);
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override final  double? internalPricing;
@override final  double? purchasePrice;
@override final  int? publicationYear;
@override final  double? retailDiscount;
@override final  double? wholesaleDiscount;
@override final  double? wholesalePrice;
@override final  double? memberDiscount;
@override final  String? purchaseSaleMode;
@override final  String? bookmark;
@override final  String? packaging;
@override final  String? properity;
@override final  String? statisticalClass;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
// Example additional field
@override@JsonKey() final  String additionalField;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.isbn, isbn) || other.isbn == isbn)&&(identical(other.price, price) || other.price == price)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.publisherId, publisherId) || other.publisherId == publisherId)&&(identical(other.selfEncoding, selfEncoding) || other.selfEncoding == selfEncoding)&&(identical(other.internalPricing, internalPricing) || other.internalPricing == internalPricing)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.publicationYear, publicationYear) || other.publicationYear == publicationYear)&&(identical(other.retailDiscount, retailDiscount) || other.retailDiscount == retailDiscount)&&(identical(other.wholesaleDiscount, wholesaleDiscount) || other.wholesaleDiscount == wholesaleDiscount)&&(identical(other.wholesalePrice, wholesalePrice) || other.wholesalePrice == wholesalePrice)&&(identical(other.memberDiscount, memberDiscount) || other.memberDiscount == memberDiscount)&&(identical(other.purchaseSaleMode, purchaseSaleMode) || other.purchaseSaleMode == purchaseSaleMode)&&(identical(other.purchaseSaleModeId, purchaseSaleModeId) || other.purchaseSaleModeId == purchaseSaleModeId)&&(identical(other.bookmark, bookmark) || other.bookmark == bookmark)&&(identical(other.packaging, packaging) || other.packaging == packaging)&&(identical(other.properity, properity) || other.properity == properity)&&(identical(other.statisticalClass, statisticalClass) || other.statisticalClass == statisticalClass)&&(identical(other.status, status) || other.status == status)&&(identical(other.stockUnit, stockUnit) || other.stockUnit == stockUnit)&&(identical(other.minStockAlertQty, minStockAlertQty) || other.minStockAlertQty == minStockAlertQty)&&(identical(other.maxStockAlertQty, maxStockAlertQty) || other.maxStockAlertQty == maxStockAlertQty)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.additionalField, additionalField) || other.additionalField == additionalField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,productId,id,title,author,isbn,price,category,categoryId,publisher,publisherId,selfEncoding,internalPricing,purchasePrice,publicationYear,retailDiscount,wholesaleDiscount,wholesalePrice,memberDiscount,purchaseSaleMode,purchaseSaleModeId,bookmark,packaging,properity,statisticalClass,status,stockUnit,minStockAlertQty,maxStockAlertQty,createdBy,updatedBy,operator,createdAt,updatedAt,additionalField]);

@override
String toString() {
  return 'ProductModel(productId: $productId, id: $id, title: $title, author: $author, isbn: $isbn, price: $price, category: $category, categoryId: $categoryId, publisher: $publisher, publisherId: $publisherId, selfEncoding: $selfEncoding, internalPricing: $internalPricing, purchasePrice: $purchasePrice, publicationYear: $publicationYear, retailDiscount: $retailDiscount, wholesaleDiscount: $wholesaleDiscount, wholesalePrice: $wholesalePrice, memberDiscount: $memberDiscount, purchaseSaleMode: $purchaseSaleMode, purchaseSaleModeId: $purchaseSaleModeId, bookmark: $bookmark, packaging: $packaging, properity: $properity, statisticalClass: $statisticalClass, status: $status, stockUnit: $stockUnit, minStockAlertQty: $minStockAlertQty, maxStockAlertQty: $maxStockAlertQty, createdBy: $createdBy, updatedBy: $updatedBy, operator: $operator, createdAt: $createdAt, updatedAt: $updatedAt, additionalField: $additionalField)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
 String productId, int id, String title, String author, String? isbn, double price, String? category, int? categoryId, String? publisher, int? publisherId, String selfEncoding, double? internalPricing, double? purchasePrice, int? publicationYear, double? retailDiscount, double? wholesaleDiscount, double? wholesalePrice, double? memberDiscount, String? purchaseSaleMode, int? purchaseSaleModeId, String? bookmark, String? packaging, String? properity, String? statisticalClass, int status, String stockUnit, int? minStockAlertQty, int? maxStockAlertQty, int? createdBy, int? updatedBy, String? operator, DateTime? createdAt, DateTime? updatedAt, String additionalField
});




}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? id = null,Object? title = null,Object? author = null,Object? isbn = freezed,Object? price = null,Object? category = freezed,Object? categoryId = freezed,Object? publisher = freezed,Object? publisherId = freezed,Object? selfEncoding = null,Object? internalPricing = freezed,Object? purchasePrice = freezed,Object? publicationYear = freezed,Object? retailDiscount = freezed,Object? wholesaleDiscount = freezed,Object? wholesalePrice = freezed,Object? memberDiscount = freezed,Object? purchaseSaleMode = freezed,Object? purchaseSaleModeId = freezed,Object? bookmark = freezed,Object? packaging = freezed,Object? properity = freezed,Object? statisticalClass = freezed,Object? status = null,Object? stockUnit = null,Object? minStockAlertQty = freezed,Object? maxStockAlertQty = freezed,Object? createdBy = freezed,Object? updatedBy = freezed,Object? operator = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? additionalField = null,}) {
  return _then(_ProductModel(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,isbn: freezed == isbn ? _self.isbn : isbn // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String?,publisherId: freezed == publisherId ? _self.publisherId : publisherId // ignore: cast_nullable_to_non_nullable
as int?,selfEncoding: null == selfEncoding ? _self.selfEncoding : selfEncoding // ignore: cast_nullable_to_non_nullable
as String,internalPricing: freezed == internalPricing ? _self.internalPricing : internalPricing // ignore: cast_nullable_to_non_nullable
as double?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,publicationYear: freezed == publicationYear ? _self.publicationYear : publicationYear // ignore: cast_nullable_to_non_nullable
as int?,retailDiscount: freezed == retailDiscount ? _self.retailDiscount : retailDiscount // ignore: cast_nullable_to_non_nullable
as double?,wholesaleDiscount: freezed == wholesaleDiscount ? _self.wholesaleDiscount : wholesaleDiscount // ignore: cast_nullable_to_non_nullable
as double?,wholesalePrice: freezed == wholesalePrice ? _self.wholesalePrice : wholesalePrice // ignore: cast_nullable_to_non_nullable
as double?,memberDiscount: freezed == memberDiscount ? _self.memberDiscount : memberDiscount // ignore: cast_nullable_to_non_nullable
as double?,purchaseSaleMode: freezed == purchaseSaleMode ? _self.purchaseSaleMode : purchaseSaleMode // ignore: cast_nullable_to_non_nullable
as String?,purchaseSaleModeId: freezed == purchaseSaleModeId ? _self.purchaseSaleModeId : purchaseSaleModeId // ignore: cast_nullable_to_non_nullable
as int?,bookmark: freezed == bookmark ? _self.bookmark : bookmark // ignore: cast_nullable_to_non_nullable
as String?,packaging: freezed == packaging ? _self.packaging : packaging // ignore: cast_nullable_to_non_nullable
as String?,properity: freezed == properity ? _self.properity : properity // ignore: cast_nullable_to_non_nullable
as String?,statisticalClass: freezed == statisticalClass ? _self.statisticalClass : statisticalClass // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,stockUnit: null == stockUnit ? _self.stockUnit : stockUnit // ignore: cast_nullable_to_non_nullable
as String,minStockAlertQty: freezed == minStockAlertQty ? _self.minStockAlertQty : minStockAlertQty // ignore: cast_nullable_to_non_nullable
as int?,maxStockAlertQty: freezed == maxStockAlertQty ? _self.maxStockAlertQty : maxStockAlertQty // ignore: cast_nullable_to_non_nullable
as int?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,updatedBy: freezed == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as int?,operator: freezed == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,additionalField: null == additionalField ? _self.additionalField : additionalField // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
