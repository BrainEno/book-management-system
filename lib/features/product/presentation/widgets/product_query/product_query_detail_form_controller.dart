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
      publisherController = TextEditingController(),
      categoryController = TextEditingController(),
      selfEncodingController = TextEditingController();

  final TextEditingController titleController;
  final TextEditingController productIdController;
  final TextEditingController isbnController;
  final TextEditingController authorController;
  final TextEditingController priceController;
  final TextEditingController publisherController;
  final TextEditingController categoryController;
  final TextEditingController selfEncodingController;

  void populate(ProductModel? product) {
    if (product == null) {
      clear();
      return;
    }

    titleController.text = product.title;
    productIdController.text = product.productId;
    isbnController.text = product.isbn;
    authorController.text = product.author;
    priceController.text = formatProductPrice(product.price);
    publisherController.text = product.publisher;
    categoryController.text = product.category;
    selfEncodingController.text = product.selfEncoding;
  }

  void clear() {
    titleController.clear();
    productIdController.clear();
    isbnController.clear();
    authorController.clear();
    priceController.clear();
    publisherController.clear();
    categoryController.clear();
    selfEncodingController.clear();
  }

  double? parsePrice() {
    return double.tryParse(priceController.text.trim());
  }

  ProductModel buildUpdatedProduct(ProductModel selectedProduct) {
    return selectedProduct.copyWith(
      title: titleController.text.trim(),
      productId: productIdController.text.trim(),
      isbn: isbnController.text.trim(),
      author: authorController.text.trim(),
      price: parsePrice() ?? selectedProduct.price,
      publisher: publisherController.text.trim(),
      category: categoryController.text.trim(),
      selfEncoding: selfEncodingController.text.trim(),
      updatedAt: DateTime.now(),
    );
  }

  void dispose() {
    titleController.dispose();
    productIdController.dispose();
    isbnController.dispose();
    authorController.dispose();
    priceController.dispose();
    publisherController.dispose();
    categoryController.dispose();
    selfEncodingController.dispose();
  }
}
