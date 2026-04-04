import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:flutter/material.dart';

class ProductQueryDetailFormController {
  ProductQueryDetailFormController()
    : titleController = TextEditingController(),
      productIdController = TextEditingController(),
      isbnController = TextEditingController(),
      authorController = TextEditingController(),
      priceController = TextEditingController(),
      publicationYearController = TextEditingController(),
      purchaseSaleModeController = TextEditingController(),
      packagingController = TextEditingController(),
      statisticalClassController = TextEditingController(),
      publisherController = TextEditingController(),
      categoryController = TextEditingController(),
      selfEncodingController = TextEditingController();

  final TextEditingController titleController;
  final TextEditingController productIdController;
  final TextEditingController isbnController;
  final TextEditingController authorController;
  final TextEditingController priceController;
  final TextEditingController publicationYearController;
  final TextEditingController purchaseSaleModeController;
  final TextEditingController packagingController;
  final TextEditingController statisticalClassController;
  final TextEditingController publisherController;
  final TextEditingController categoryController;
  final TextEditingController selfEncodingController;

  String? _normalizeOptionalText(
    String value, {
    Set<String> nullPlaceholders = const {'不区分'},
  }) {
    final normalized = value.trim();
    if (normalized.isEmpty || nullPlaceholders.contains(normalized)) {
      return null;
    }
    return normalized;
  }

  void populate(ProductModel? product) {
    if (product == null) {
      clear();
      return;
    }

    titleController.text = product.title;
    productIdController.text = product.productId;
    isbnController.text = product.isbn ?? '';
    authorController.text = product.author;
    priceController.text = formatProductPrice(product.price);
    publicationYearController.text = product.publicationYear?.toString() ?? '';
    purchaseSaleModeController.text = product.purchaseSaleMode ?? '';
    packagingController.text = product.packaging ?? '';
    statisticalClassController.text = product.statisticalClass ?? '';
    publisherController.text = product.publisher ?? '不区分';
    categoryController.text = product.category ?? '不区分';
    selfEncodingController.text = product.selfEncoding;
  }

  void clear() {
    titleController.clear();
    productIdController.clear();
    isbnController.clear();
    authorController.clear();
    priceController.clear();
    publicationYearController.clear();
    purchaseSaleModeController.clear();
    packagingController.clear();
    statisticalClassController.clear();
    publisherController.clear();
    categoryController.clear();
    selfEncodingController.clear();
  }

  double? parsePrice() {
    return double.tryParse(priceController.text.trim());
  }

  int? parsePublicationYear() {
    return int.tryParse(publicationYearController.text.trim());
  }

  ProductModel buildUpdatedProduct(
    ProductModel selectedProduct, {
    required bool allowSensitiveFieldUpdates,
  }) {
    final normalizedIsbn = _normalizeOptionalText(
      isbnController.text,
      nullPlaceholders: const {},
    );
    final effectiveIsbn = allowSensitiveFieldUpdates
        ? normalizedIsbn
        : selectedProduct.isbn;
    final normalizedSelfEncoding = selfEncodingController.text.trim().isEmpty
        ? (effectiveIsbn ?? productIdController.text.trim())
        : selfEncodingController.text.trim();

    return selectedProduct.copyWith(
      title: titleController.text.trim(),
      productId: productIdController.text.trim(),
      isbn: effectiveIsbn,
      author: authorController.text.trim(),
      price: allowSensitiveFieldUpdates
          ? (parsePrice() ?? selectedProduct.price)
          : selectedProduct.price,
      publicationYear: parsePublicationYear(),
      purchaseSaleMode: _normalizeOptionalText(
        purchaseSaleModeController.text,
        nullPlaceholders: const {},
      ),
      packaging: _normalizeOptionalText(
        packagingController.text,
        nullPlaceholders: const {},
      ),
      statisticalClass: _normalizeOptionalText(
        statisticalClassController.text,
        nullPlaceholders: const {},
      ),
      publisher: _normalizeOptionalText(publisherController.text),
      category: _normalizeOptionalText(categoryController.text),
      selfEncoding: normalizedSelfEncoding,
      updatedAt: DateTime.now(),
    );
  }

  void dispose() {
    titleController.dispose();
    productIdController.dispose();
    isbnController.dispose();
    authorController.dispose();
    priceController.dispose();
    publicationYearController.dispose();
    purchaseSaleModeController.dispose();
    packagingController.dispose();
    statisticalClassController.dispose();
    publisherController.dispose();
    categoryController.dispose();
    selfEncodingController.dispose();
  }
}
