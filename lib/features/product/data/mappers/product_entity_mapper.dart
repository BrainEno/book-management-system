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
    internalPricing: product.internalPricing ?? 0,
    purchasePrice: product.purchasePrice ?? 0,
    publicationYear: product.publicationYear ?? 2025,
    retailDiscount: product.retailDiscount ?? 100,
    wholesaleDiscount: product.wholesaleDiscount ?? 100,
    wholesalePrice: product.wholesalePrice ?? 0,
    memberDiscount: product.memberDiscount ?? 100,
    purchaseSaleMode: product.purchaseSaleMode ?? '不区分',
    bookmark: product.bookmark ?? '不区分',
    packaging: product.packaging ?? '不区分',
    properity: product.properity ?? '不区分',
    statisticalClass: product.statisticalClass ?? '不区分',
    operator: product.operator,
    createdAt: product.createdAt,
    updatedAt: product.updatedAt,
  );
}
