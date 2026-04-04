import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel extends Product with _$ProductModel {
  // ignore: use_super_parameters
  ProductModel._({
    required String productId,
    required int id,
    required String title,
    required String author,
    String? isbn,
    required double price,
    String? category,
    int? categoryId,
    String? publisher,
    int? publisherId,
    required String selfEncoding,
    int? purchaseSaleModeId,
    int status = 1,
    String stockUnit = '册',
    int? minStockAlertQty,
    int? maxStockAlertQty,
    int? createdBy,
    int? updatedBy,
    String? operator,
  }) : super(
         productId: productId,
         id: id,
         title: title,
         author: author,
         isbn: isbn,
         price: price,
         category: category,
         categoryId: categoryId,
         publisher: publisher,
         publisherId: publisherId,
         selfEncoding: selfEncoding,
         purchaseSaleModeId: purchaseSaleModeId,
         status: status,
         stockUnit: stockUnit,
         minStockAlertQty: minStockAlertQty,
         maxStockAlertQty: maxStockAlertQty,
         createdBy: createdBy,
         updatedBy: updatedBy,
         operator: operator,
       );

  factory ProductModel({
    required String productId,
    required int id,
    required String title,
    required String author,
    String? isbn,
    required double price,
    String? category,
    int? categoryId,
    String? publisher,
    int? publisherId,
    required String selfEncoding,
    double? internalPricing,
    double? purchasePrice,
    int? publicationYear,
    double? retailDiscount,
    double? wholesaleDiscount,
    double? wholesalePrice,
    double? memberDiscount,
    String? purchaseSaleMode,
    int? purchaseSaleModeId,
    String? bookmark,
    String? packaging,
    String? properity,
    String? statisticalClass,
    @Default(1) int status,
    @Default('册') String stockUnit,
    int? minStockAlertQty,
    int? maxStockAlertQty,
    int? createdBy,
    int? updatedBy,
    String? operator,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Example additional field
    @Default('') String additionalField,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
