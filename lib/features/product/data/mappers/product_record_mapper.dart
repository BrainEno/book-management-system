import 'package:bookstore_management_system/core/database/database.dart'
    show Product;
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';

ProductModel mapProductRecordToModel(
  Product product, {
  String? createdByUsername,
  String? updatedByUsername,
}) {
  return ProductModel(
    productId: product.productId,
    id: product.id,
    title: product.title,
    author: product.author,
    isbn: product.isbn,
    price: product.price,
    category: product.category,
    publisher: product.publisher,
    selfEncoding: product.selfEncoding,
    createdBy: product.createdBy,
    updatedBy: product.updatedBy,
    internalPricing: product.internalPricing,
    purchasePrice: product.purchasePrice,
    publicationYear: product.publicationYear,
    retailDiscount: product.retailDiscount,
    wholesaleDiscount: product.wholesaleDiscount,
    wholesalePrice: product.wholesalePrice,
    memberDiscount: product.memberDiscount,
    purchaseSaleMode: product.purchaseSaleMode,
    bookmark: product.bookmark,
    packaging: product.packaging,
    properity: product.properity,
    statisticalClass: product.statisticalClass,
    operator: updatedByUsername ?? createdByUsername,
    createdAt: product.createdAt,
    updatedAt: product.updatedAt,
  );
}
