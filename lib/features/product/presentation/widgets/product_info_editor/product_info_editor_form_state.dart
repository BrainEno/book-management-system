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
      bookmarkController = TextEditingController(text: '08/404'),
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

  void populateFromProduct(ProductModel product) {
    bookIdController.text = product.productId;
    idController.text = product.id.toString();
    titleController.text = product.title;
    authorController.text = product.author;
    isbnController.text = product.isbn;
    priceController.text = product.price.toString();
    categoryController.text = product.category;
    publisherController.text = product.publisher;
    selfEncodingController.text = product.selfEncoding;
    internalPricingController.text = product.internalPricing.toString();
    purchasePriceController.text = product.purchasePrice.toString();
    publicationYearController.text = product.publicationYear.toString();
    retailDiscountController.text = product.retailDiscount.toString();
    wholesaleDiscountController.text = product.wholesaleDiscount.toString();
    wholesalePriceController.text = product.wholesalePrice.toString();
    memberDiscountController.text = product.memberDiscount.toString();
    purchaseSaleModeController.text = product.purchaseSaleMode.isEmpty
        ? '不区分'
        : product.purchaseSaleMode;
    bookmarkController.text = product.bookmark.isEmpty
        ? '08/404'
        : product.bookmark;
    packagingController.text = product.packaging.isEmpty
        ? '不区分'
        : product.packaging;
    properityController.text = product.properity.isEmpty
        ? '不区分'
        : product.properity;
    statisticalClassController.text = product.statisticalClass.isEmpty
        ? '不区分'
        : product.statisticalClass;
  }

  void setOperator(String username) {
    operatorController.text = username;
  }

  void updateIsbn(String isbn) {
    isbnController.text = isbn;
    selfEncodingController.text = isbn;
  }

  ProductModel buildProduct({ProductModel? existingProduct}) {
    return ProductModel(
      productId: bookIdController.text,
      id: existingProduct?.id ?? (int.tryParse(idController.text) ?? 0),
      title: titleController.text,
      author: authorController.text,
      isbn: isbnController.text,
      price: double.tryParse(priceController.text) ?? 0.0,
      category: categoryController.text,
      publisher: publisherController.text,
      selfEncoding: selfEncodingController.text,
      internalPricing: double.tryParse(internalPricingController.text) ?? 0.0,
      purchasePrice: double.tryParse(purchasePriceController.text) ?? 0.0,
      publicationYear: int.tryParse(publicationYearController.text) ?? 2025,
      retailDiscount: double.tryParse(retailDiscountController.text) ?? 100.0,
      wholesaleDiscount:
          double.tryParse(wholesaleDiscountController.text) ?? 100.0,
      wholesalePrice: double.tryParse(wholesalePriceController.text) ?? 0.0,
      memberDiscount: double.tryParse(memberDiscountController.text) ?? 100.0,
      purchaseSaleMode: purchaseSaleModeController.text,
      bookmark: bookmarkController.text.isEmpty
          ? '不区分'
          : bookmarkController.text,
      packaging: packagingController.text,
      properity: properityController.text,
      statisticalClass: statisticalClassController.text,
      operator: operatorController.text,
      createdAt: existingProduct?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Map<String, String> buildDraftData() {
    return {
      'productId': bookIdController.text,
      'id': idController.text,
      'title': titleController.text,
      'author': authorController.text,
      'isbn': isbnController.text,
      'price': priceController.text,
      'category': categoryController.text,
      'publisher': publisherController.text,
      'selfEncoding': selfEncodingController.text,
      'internalPricing': internalPricingController.text,
      'purchasePrice': purchasePriceController.text,
      'publicationYear': publicationYearController.text,
      'retailDiscount': retailDiscountController.text,
      'wholesaleDiscount': wholesaleDiscountController.text,
      'wholesalePrice': wholesalePriceController.text,
      'memberDiscount': memberDiscountController.text,
      'purchaseSaleMode': purchaseSaleModeController.text,
      'bookmark': bookmarkController.text,
      'packaging': packagingController.text,
      'properity': properityController.text,
      'statisticalClass': statisticalClassController.text,
      'operator': operatorController.text,
    };
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
