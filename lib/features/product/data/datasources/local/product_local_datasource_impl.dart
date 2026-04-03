import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_local_datasource.dart';
import 'package:bookstore_management_system/features/product/data/mappers/product_record_mapper.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

class BookLocalDataSourceImpl implements ProductLocalDataSource {
  final AppDatabase database;

  BookLocalDataSourceImpl(this.database);

  String _normalizeRequiredText(String value) => value.trim();

  String _resolveSelfEncoding(ProductModel productModel) {
    final selfEncoding = productModel.selfEncoding.trim();
    if (selfEncoding.isNotEmpty) {
      return selfEncoding;
    }
    return productModel.isbn.trim();
  }

  String _productConstraintMessage(SqliteException error) {
    final message = error.message.toLowerCase();
    if (message.contains('products.product_id')) {
      return '商品编码已存在，请使用新的商品编码。';
    }
    if (message.contains('products.self_encoding')) {
      return '自编码已存在，请检查是否重复录入。';
    }
    if (message.contains('products.price')) {
      return '商品价格必须是大于等于 0 的有效数值。';
    }
    if (message.contains('products.retail_discount') ||
        message.contains('products.wholesale_discount') ||
        message.contains('products.member_discount')) {
      return '折扣必须在 0 到 100 之间。';
    }
    return '保存商品资料失败：${error.message}';
  }

  @override
  Future<ProductModel> addProduct(ProductModel productModel) async {
    try {
      final productDao = database.productDao;
      final ProductsCompanion newProduct = ProductsCompanion(
        id: productModel.id > 0 ? Value(productModel.id) : const Value.absent(),
        title: Value(_normalizeRequiredText(productModel.title)),
        author: Value(_normalizeRequiredText(productModel.author)),
        isbn: Value(_normalizeRequiredText(productModel.isbn)),
        category: Value(_normalizeRequiredText(productModel.category)),
        price: Value(productModel.price),
        publisher: Value(_normalizeRequiredText(productModel.publisher)),
        productId: Value(_normalizeRequiredText(productModel.productId)),
        internalPricing: Value(productModel.internalPricing),
        selfEncoding: Value(_resolveSelfEncoding(productModel)),
        purchasePrice: Value(productModel.purchasePrice),
        publicationYear: Value(productModel.publicationYear),
        retailDiscount: Value(productModel.retailDiscount),
        wholesaleDiscount: Value(productModel.wholesaleDiscount),
        wholesalePrice: Value(productModel.wholesalePrice),
        memberDiscount: Value(productModel.memberDiscount),
        purchaseSaleMode: Value(
          _normalizeRequiredText(productModel.purchaseSaleMode),
        ),
        bookmark: Value(_normalizeRequiredText(productModel.bookmark)),
        packaging: Value(_normalizeRequiredText(productModel.packaging)),
        properity: Value(_normalizeRequiredText(productModel.properity)),
        statisticalClass: Value(
          _normalizeRequiredText(productModel.statisticalClass),
        ),
        operator: Value(_normalizeRequiredText(productModel.operator)),
        createdAt: Value(productModel.createdAt ?? DateTime.now()),
        updatedAt: Value(productModel.updatedAt ?? DateTime.now()),
      );
      final insertedId = await productDao.insertProduct(newProduct);
      return productModel.copyWith(
        id: insertedId,
        selfEncoding: _resolveSelfEncoding(productModel),
      );
    } on SqliteException catch (error) {
      throw ServerException(_productConstraintMessage(error));
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final productDao = database.productDao;
    final products = await productDao.getAllProducts();
    return products.map(mapProductRecordToModel).toList();
  }

  @override
  Future<void> updateProduct(ProductModel productModel) async {
    try {
      final productDao = database.productDao;
      final product = Product(
        id: productModel.id,
        title: _normalizeRequiredText(productModel.title),
        author: _normalizeRequiredText(productModel.author),
        isbn: _normalizeRequiredText(productModel.isbn),
        category: _normalizeRequiredText(productModel.category),
        price: productModel.price,
        publisher: _normalizeRequiredText(productModel.publisher),
        productId: _normalizeRequiredText(productModel.productId),
        internalPricing: productModel.internalPricing,
        selfEncoding: _resolveSelfEncoding(productModel),
        purchasePrice: productModel.purchasePrice,
        publicationYear: productModel.publicationYear,
        retailDiscount: productModel.retailDiscount,
        wholesaleDiscount: productModel.wholesaleDiscount,
        wholesalePrice: productModel.wholesalePrice,
        memberDiscount: productModel.memberDiscount,
        purchaseSaleMode: _normalizeRequiredText(productModel.purchaseSaleMode),
        bookmark: _normalizeRequiredText(productModel.bookmark),
        packaging: _normalizeRequiredText(productModel.packaging),
        properity: _normalizeRequiredText(productModel.properity),
        statisticalClass: _normalizeRequiredText(productModel.statisticalClass),
        operator: _normalizeRequiredText(productModel.operator),
        createdAt: productModel.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await productDao.updateProduct(product);
    } on SqliteException catch (error) {
      throw ServerException(_productConstraintMessage(error));
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    final productDao = database.productDao;
    await productDao.deleteProduct(id);
  }

  @override
  Future<ProductModel> searchByISBN(String isbn) async {
    final productDao = database.productDao;
    final product = await productDao.searchByISBN(isbn);
    return mapProductRecordToModel(product);
  }

  @override
  Future<ProductModel> searchByTitle(String title) async {
    final productDao = database.productDao;
    final product = await productDao.searchByTitle(title);
    return mapProductRecordToModel(product);
  }
}
