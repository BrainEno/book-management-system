import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';

ProductModel ensureProductModel(Product product) {
  if (product is ProductModel) {
    return product;
  }

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
    operator: product.operator,
    createdAt: product.createdAt,
    updatedAt: product.updatedAt,
  );
}
