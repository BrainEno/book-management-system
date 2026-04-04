import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';

const List<String> productCategoryOptions = [
  '不区分',
  '小说',
  '科技',
  '教育',
  '历史',
  '儿童',
];

const List<String> productPublisherOptions = [
  '不区分',
  '人民出版社',
  '清华大学出版社',
  '上海文艺出版社',
  '北京大学出版社',
];

const List<String> productPurchaseSaleModeOptions = ['不区分', '零售', '批发', '会员特价'];

const List<String> productPackagingOptions = ['不区分', '精装', '平装', '简装'];

const List<String> productProperityOptions = ['不区分', '普通图书', '畅销书', '新书'];

const List<String> productStatisticalClassOptions = [
  '不区分',
  '小说',
  '诗歌',
  '哲学',
  '人类学',
  '传记',
  '社会学',
  '历史',
  '非虚构',
  '其他',
];

class ProductInfoEditorFormControllers {
  ProductInfoEditorFormControllers()
    : bookIdController = TextEditingController(),
      idController = TextEditingController(),
      titleController = TextEditingController(),
      authorController = TextEditingController(),
      isbnController = TextEditingController(),
      priceController = TextEditingController(),
      categoryController = TextEditingController(text: '不区分'),
      publisherController = TextEditingController(text: '不区分'),
      selfEncodingController = TextEditingController(),
      internalPricingController = TextEditingController(),
      purchasePriceController = TextEditingController(),
      publicationYearController = TextEditingController(),
      retailDiscountController = TextEditingController(),
      wholesaleDiscountController = TextEditingController(),
      wholesalePriceController = TextEditingController(),
      memberDiscountController = TextEditingController(),
      purchaseSaleModeController = TextEditingController(text: '不区分'),
      bookmarkController = TextEditingController(),
      packagingController = TextEditingController(text: '不区分'),
      properityController = TextEditingController(text: '不区分'),
      statisticalClassController = TextEditingController(text: '不区分'),
      operatorController = TextEditingController();

  final TextEditingController bookIdController;
  final TextEditingController idController;
  final TextEditingController titleController;
  final TextEditingController authorController;
  final TextEditingController isbnController;
  final TextEditingController priceController;
  final TextEditingController categoryController;
  final TextEditingController publisherController;
  final TextEditingController selfEncodingController;
  final TextEditingController internalPricingController;
  final TextEditingController purchasePriceController;
  final TextEditingController publicationYearController;
  final TextEditingController retailDiscountController;
  final TextEditingController wholesaleDiscountController;
  final TextEditingController wholesalePriceController;
  final TextEditingController memberDiscountController;
  final TextEditingController purchaseSaleModeController;
  final TextEditingController bookmarkController;
  final TextEditingController packagingController;
  final TextEditingController properityController;
  final TextEditingController statisticalClassController;
  final TextEditingController operatorController;

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

  double? _parseOptionalDouble(TextEditingController controller) {
    final normalized = controller.text.trim();
    if (normalized.isEmpty) {
      return null;
    }
    return double.tryParse(normalized);
  }

  int? _parseOptionalInt(TextEditingController controller) {
    final normalized = controller.text.trim();
    if (normalized.isEmpty) {
      return null;
    }
    return int.tryParse(normalized);
  }

  void populateFromProduct(ProductModel product) {
    bookIdController.text = product.productId;
    idController.text = product.id.toString();
    titleController.text = product.title;
    authorController.text = product.author;
    isbnController.text = product.isbn ?? '';
    priceController.text = product.price.toString();
    categoryController.text = product.category ?? '不区分';
    publisherController.text = product.publisher ?? '不区分';
    selfEncodingController.text = product.selfEncoding;
    internalPricingController.text = product.internalPricing?.toString() ?? '';
    purchasePriceController.text = product.purchasePrice?.toString() ?? '';
    publicationYearController.text = product.publicationYear?.toString() ?? '';
    retailDiscountController.text = product.retailDiscount?.toString() ?? '';
    wholesaleDiscountController.text =
        product.wholesaleDiscount?.toString() ?? '';
    wholesalePriceController.text = product.wholesalePrice?.toString() ?? '';
    memberDiscountController.text = product.memberDiscount?.toString() ?? '';
    purchaseSaleModeController.text = product.purchaseSaleMode ?? '不区分';
    bookmarkController.text = product.bookmark ?? '';
    packagingController.text = product.packaging ?? '不区分';
    properityController.text = product.properity ?? '不区分';
    statisticalClassController.text = product.statisticalClass ?? '不区分';
    operatorController.text = product.operator ?? '';
  }

  void setOperator(String username) {
    operatorController.text = username;
  }

  void updateIsbn(String isbn) {
    isbnController.text = isbn;
    selfEncodingController.text = isbn;
  }

  ProductModel buildProduct({ProductModel? existingProduct}) {
    final normalizedIsbn = _normalizeOptionalText(
      isbnController.text,
      nullPlaceholders: const {},
    );
    final normalizedSelfEncoding = selfEncodingController.text.trim().isEmpty
        ? (normalizedIsbn ?? bookIdController.text.trim())
        : selfEncodingController.text.trim();

    return ProductModel(
      productId: bookIdController.text.trim(),
      id: existingProduct?.id ?? 0,
      title: titleController.text.trim(),
      author: authorController.text.trim(),
      isbn: normalizedIsbn,
      price: double.tryParse(priceController.text) ?? 0.0,
      category: _normalizeOptionalText(categoryController.text),
      publisher: _normalizeOptionalText(publisherController.text),
      selfEncoding: normalizedSelfEncoding,
      createdBy: existingProduct?.createdBy,
      updatedBy: existingProduct?.updatedBy,
      internalPricing: _parseOptionalDouble(internalPricingController),
      purchasePrice: _parseOptionalDouble(purchasePriceController),
      publicationYear: _parseOptionalInt(publicationYearController),
      retailDiscount: _parseOptionalDouble(retailDiscountController),
      wholesaleDiscount: _parseOptionalDouble(wholesaleDiscountController),
      wholesalePrice: _parseOptionalDouble(wholesalePriceController),
      memberDiscount: _parseOptionalDouble(memberDiscountController),
      purchaseSaleMode: _normalizeOptionalText(purchaseSaleModeController.text),
      bookmark: _normalizeOptionalText(
        bookmarkController.text,
        nullPlaceholders: const {},
      ),
      packaging: _normalizeOptionalText(packagingController.text),
      properity: _normalizeOptionalText(properityController.text),
      statisticalClass: _normalizeOptionalText(statisticalClassController.text),
      operator: _normalizeOptionalText(
        operatorController.text,
        nullPlaceholders: const {},
      ),
      createdAt: existingProduct?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  void resetForNewEntry({String? operatorUsername}) {
    bookIdController.clear();
    idController.clear();
    titleController.clear();
    authorController.clear();
    isbnController.clear();
    priceController.clear();
    categoryController.text = '不区分';
    publisherController.text = '不区分';
    selfEncodingController.clear();
    internalPricingController.clear();
    purchasePriceController.clear();
    publicationYearController.clear();
    retailDiscountController.clear();
    wholesaleDiscountController.clear();
    wholesalePriceController.clear();
    memberDiscountController.clear();
    purchaseSaleModeController.text = '不区分';
    bookmarkController.clear();
    packagingController.text = '不区分';
    properityController.text = '不区分';
    statisticalClassController.text = '不区分';
    operatorController.text = operatorUsername?.trim() ?? '';
  }

  void dispose() {
    bookIdController.dispose();
    idController.dispose();
    titleController.dispose();
    authorController.dispose();
    isbnController.dispose();
    priceController.dispose();
    categoryController.dispose();
    publisherController.dispose();
    selfEncodingController.dispose();
    internalPricingController.dispose();
    purchasePriceController.dispose();
    publicationYearController.dispose();
    retailDiscountController.dispose();
    wholesaleDiscountController.dispose();
    wholesalePriceController.dispose();
    memberDiscountController.dispose();
    purchaseSaleModeController.dispose();
    bookmarkController.dispose();
    packagingController.dispose();
    properityController.dispose();
    statisticalClassController.dispose();
    operatorController.dispose();
  }
}
