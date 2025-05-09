// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookModel _$BookModelFromJson(Map<String, dynamic> json) => _BookModel(
  bookId: json['bookId'] as String,
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  author: json['author'] as String,
  isbn: json['isbn'] as String,
  price: (json['price'] as num).toDouble(),
  category: json['category'] as String,
  publisher: json['publisher'] as String,
  selfEncoding: json['selfEncoding'] as String,
  internalPricing: (json['internalPricing'] as num?)?.toDouble() ?? 0.0,
  purchasePrice: (json['purchasePrice'] as num?)?.toDouble() ?? 0.0,
  publicationYear: (json['publicationYear'] as num?)?.toInt() ?? 2025,
  retailDiscount: (json['retailDiscount'] as num?)?.toDouble() ?? 100,
  wholesaleDiscount: (json['wholesaleDiscount'] as num?)?.toDouble() ?? 100,
  wholesalePrice: (json['wholesalePrice'] as num?)?.toDouble() ?? 0,
  memberDiscount: (json['memberDiscount'] as num?)?.toDouble() ?? 100,
  purchaseSaleMode: json['purchaseSaleMode'] as String? ?? '不区分',
  bookmark: json['bookmark'] as String? ?? '不区分',
  packaging: json['packaging'] as String? ?? '不区分',
  properity: json['properity'] as String? ?? '不区分',
  statisticalClass: json['statisticalClass'] as String? ?? '不区分',
  operator: json['operator'] as String,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  additionalField: json['additionalField'] as String? ?? '',
);

Map<String, dynamic> _$BookModelToJson(_BookModel instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'isbn': instance.isbn,
      'price': instance.price,
      'category': instance.category,
      'publisher': instance.publisher,
      'selfEncoding': instance.selfEncoding,
      'operator': instance.operator,
      'internalPricing': instance.internalPricing,
      'purchasePrice': instance.purchasePrice,
      'publicationYear': instance.publicationYear,
      'retailDiscount': instance.retailDiscount,
      'wholesaleDiscount': instance.wholesaleDiscount,
      'wholesalePrice': instance.wholesalePrice,
      'memberDiscount': instance.memberDiscount,
      'purchaseSaleMode': instance.purchaseSaleMode,
      'bookmark': instance.bookmark,
      'packaging': instance.packaging,
      'properity': instance.properity,
      'statisticalClass': instance.statisticalClass,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'additionalField': instance.additionalField,
    };
