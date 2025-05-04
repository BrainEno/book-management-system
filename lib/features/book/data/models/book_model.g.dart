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
  internalPricing: json['internalPricing'] as String,
  selfEncoding: json['selfEncoding'] as String,
  purchasePrice: (json['purchasePrice'] as num).toDouble(),
  publicationYear: (json['publicationYear'] as num).toInt(),
  retailDiscount: (json['retailDiscount'] as num).toInt(),
  wholesaleDiscount: (json['wholesaleDiscount'] as num).toInt(),
  wholesalePrice: (json['wholesalePrice'] as num).toInt(),
  memberDiscount: (json['memberDiscount'] as num).toInt(),
  purchaseSaleMode: json['purchaseSaleMode'] as String,
  bookmark: json['bookmark'] as String,
  packaging: json['packaging'] as String,
  properity: json['properity'] as String,
  statisticalClass: json['statisticalClass'] as String,
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
      'internalPricing': instance.internalPricing,
      'selfEncoding': instance.selfEncoding,
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
    };
