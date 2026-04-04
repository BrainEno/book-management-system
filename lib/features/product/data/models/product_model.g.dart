// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      productId: json['productId'] as String,
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      isbn: json['isbn'] as String?,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      publisher: json['publisher'] as String?,
      publisherId: (json['publisherId'] as num?)?.toInt(),
      selfEncoding: json['selfEncoding'] as String,
      internalPricing: (json['internalPricing'] as num?)?.toDouble(),
      purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
      publicationYear: (json['publicationYear'] as num?)?.toInt(),
      retailDiscount: (json['retailDiscount'] as num?)?.toDouble(),
      wholesaleDiscount: (json['wholesaleDiscount'] as num?)?.toDouble(),
      wholesalePrice: (json['wholesalePrice'] as num?)?.toDouble(),
      memberDiscount: (json['memberDiscount'] as num?)?.toDouble(),
      purchaseSaleMode: json['purchaseSaleMode'] as String?,
      purchaseSaleModeId: (json['purchaseSaleModeId'] as num?)?.toInt(),
      bookmark: json['bookmark'] as String?,
      packaging: json['packaging'] as String?,
      properity: json['properity'] as String?,
      statisticalClass: json['statisticalClass'] as String?,
      status: (json['status'] as num?)?.toInt() ?? 1,
      stockUnit: json['stockUnit'] as String? ?? '册',
      minStockAlertQty: (json['minStockAlertQty'] as num?)?.toInt(),
      maxStockAlertQty: (json['maxStockAlertQty'] as num?)?.toInt(),
      createdBy: (json['createdBy'] as num?)?.toInt(),
      updatedBy: (json['updatedBy'] as num?)?.toInt(),
      operator: json['operator'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      additionalField: json['additionalField'] as String? ?? '',
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'isbn': instance.isbn,
      'price': instance.price,
      'category': instance.category,
      'categoryId': instance.categoryId,
      'publisher': instance.publisher,
      'publisherId': instance.publisherId,
      'selfEncoding': instance.selfEncoding,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'purchaseSaleModeId': instance.purchaseSaleModeId,
      'status': instance.status,
      'stockUnit': instance.stockUnit,
      'minStockAlertQty': instance.minStockAlertQty,
      'maxStockAlertQty': instance.maxStockAlertQty,
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
