import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_local_datasource.dart';
import 'package:bookstore_management_system/features/product/data/mappers/product_record_mapper.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

class BookLocalDataSourceImpl implements ProductLocalDataSource {
  final AppDatabase database;
  static const Set<String> _nullPlaceholders = {'不区分'};

  BookLocalDataSourceImpl(this.database);

  String _normalizeRequiredText(String value) => value.trim();

  String? _normalizeOptionalText(
    String? value, {
    Set<String> nullPlaceholders = _nullPlaceholders,
  }) {
    final normalized = value?.trim();
    if (normalized == null ||
        normalized.isEmpty ||
        nullPlaceholders.contains(normalized)) {
      return null;
    }
    return normalized;
  }

  String _resolveSelfEncoding(ProductModel productModel) {
    final selfEncoding = productModel.selfEncoding.trim();
    if (selfEncoding.isNotEmpty) {
      return selfEncoding;
    }
    final isbn = productModel.isbn?.trim();
    if (isbn != null && isbn.isNotEmpty) {
      return isbn;
    }
    return productModel.productId.trim();
  }

  String _resolveStockUnit(String? stockUnit) {
    final normalized = stockUnit?.trim();
    if (normalized == null || normalized.isEmpty) {
      return '册';
    }
    return normalized;
  }

  Future<int?> _resolveOperatorUserId(String? username) async {
    final normalized = _normalizeOptionalText(username, nullPlaceholders: {});
    if (normalized == null) {
      return null;
    }

    final user = await database.userDao.getUserByUsername(normalized);
    return user?.id;
  }

  Future<int?> _resolveMasterDataId({
    required int? explicitId,
    required String? rawValue,
    required String tableName,
  }) async {
    if (explicitId != null && explicitId > 0) {
      return explicitId;
    }

    final normalized = _normalizeOptionalText(rawValue);
    if (normalized == null) {
      return null;
    }

    final row = await database.customSelect(
      '''
      SELECT id
      FROM $tableName
      WHERE code = ?
         OR name = ?
      ORDER BY CASE WHEN code = ? THEN 0 ELSE 1 END
      LIMIT 1
      ''',
      variables: [
        Variable.withString(normalized),
        Variable.withString(normalized),
        Variable.withString(normalized),
      ],
    ).getSingleOrNull();

    return row?.read<int>('id');
  }

  String _productConstraintMessage(SqliteException error) {
    final message = error.message.toLowerCase();
    if (message.contains('products.isbn')) {
      return 'ISBN 已存在，请检查是否重复建档。';
    }
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
    if (message.contains('products.status')) {
      return '商品状态无效，请检查启用、停用或作废状态。';
    }
    return '保存商品资料失败：${error.message}';
  }

  @override
  Future<ProductModel> addProduct(ProductModel productModel) async {
    try {
      final productDao = database.productDao;
      final operatorUserId = await _resolveOperatorUserId(
        productModel.operator,
      );
      final categoryId = await _resolveMasterDataId(
        explicitId: productModel.categoryId,
        rawValue: productModel.category,
        tableName: 'product_categories',
      );
      final publisherId = await _resolveMasterDataId(
        explicitId: productModel.publisherId,
        rawValue: productModel.publisher,
        tableName: 'publishers',
      );
      final purchaseSaleModeId = await _resolveMasterDataId(
        explicitId: productModel.purchaseSaleModeId,
        rawValue: productModel.purchaseSaleMode,
        tableName: 'purchase_sale_modes',
      );
      final normalizedOperator = _normalizeOptionalText(
        productModel.operator,
        nullPlaceholders: {},
      );
      final ProductsCompanion newProduct = ProductsCompanion(
        id: productModel.id > 0 ? Value(productModel.id) : const Value.absent(),
        title: Value(_normalizeRequiredText(productModel.title)),
        author: Value(_normalizeRequiredText(productModel.author)),
        isbn: Value(
          _normalizeOptionalText(productModel.isbn, nullPlaceholders: {}),
        ),
        category: Value(_normalizeOptionalText(productModel.category)),
        categoryId: Value(categoryId),
        price: Value(productModel.price),
        publisher: Value(_normalizeOptionalText(productModel.publisher)),
        publisherId: Value(publisherId),
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
          _normalizeOptionalText(productModel.purchaseSaleMode),
        ),
        purchaseSaleModeId: Value(purchaseSaleModeId),
        bookmark: Value(_normalizeOptionalText(productModel.bookmark)),
        packaging: Value(_normalizeOptionalText(productModel.packaging)),
        properity: Value(_normalizeOptionalText(productModel.properity)),
        statisticalClass: Value(
          _normalizeOptionalText(productModel.statisticalClass),
        ),
        status: Value(productModel.status),
        stockUnit: Value(_resolveStockUnit(productModel.stockUnit)),
        minStockAlertQty: Value(productModel.minStockAlertQty),
        maxStockAlertQty: Value(productModel.maxStockAlertQty),
        createdBy: Value(productModel.createdBy ?? operatorUserId),
        updatedBy: Value(productModel.updatedBy ?? operatorUserId),
        createdAt: Value(productModel.createdAt ?? DateTime.now()),
        updatedAt: Value(productModel.updatedAt ?? DateTime.now()),
      );
      final insertedId = await productDao.insertProduct(newProduct);
      return productModel.copyWith(
        id: insertedId,
        selfEncoding: _resolveSelfEncoding(productModel),
        categoryId: categoryId,
        publisherId: publisherId,
        purchaseSaleModeId: purchaseSaleModeId,
        stockUnit: _resolveStockUnit(productModel.stockUnit),
        createdBy: productModel.createdBy ?? operatorUserId,
        updatedBy: productModel.updatedBy ?? operatorUserId,
        operator: normalizedOperator,
      );
    } on SqliteException catch (error) {
      throw ServerException(_productConstraintMessage(error));
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final productDao = database.productDao;
    final products = await productDao.getAllProducts();
    return products
        .map(
          (entry) => mapProductRecordToModel(
            entry.product,
            createdByUsername: entry.createdByUsername,
            updatedByUsername: entry.updatedByUsername,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> updateProduct(ProductModel productModel) async {
    try {
      final productDao = database.productDao;
      final operatorUserId = await _resolveOperatorUserId(
        productModel.operator,
      );
      final categoryId = await _resolveMasterDataId(
        explicitId: productModel.categoryId,
        rawValue: productModel.category,
        tableName: 'product_categories',
      );
      final publisherId = await _resolveMasterDataId(
        explicitId: productModel.publisherId,
        rawValue: productModel.publisher,
        tableName: 'publishers',
      );
      final purchaseSaleModeId = await _resolveMasterDataId(
        explicitId: productModel.purchaseSaleModeId,
        rawValue: productModel.purchaseSaleMode,
        tableName: 'purchase_sale_modes',
      );
      final product = ProductsCompanion(
        title: Value(_normalizeRequiredText(productModel.title)),
        author: Value(_normalizeRequiredText(productModel.author)),
        isbn: Value(
          _normalizeOptionalText(productModel.isbn, nullPlaceholders: {}),
        ),
        category: Value(_normalizeOptionalText(productModel.category)),
        categoryId: Value(categoryId),
        price: Value(productModel.price),
        publisher: Value(_normalizeOptionalText(productModel.publisher)),
        publisherId: Value(publisherId),
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
          _normalizeOptionalText(productModel.purchaseSaleMode),
        ),
        purchaseSaleModeId: Value(purchaseSaleModeId),
        bookmark: Value(_normalizeOptionalText(productModel.bookmark)),
        packaging: Value(_normalizeOptionalText(productModel.packaging)),
        properity: Value(_normalizeOptionalText(productModel.properity)),
        statisticalClass: Value(
          _normalizeOptionalText(productModel.statisticalClass),
        ),
        status: Value(productModel.status),
        stockUnit: Value(_resolveStockUnit(productModel.stockUnit)),
        minStockAlertQty: Value(productModel.minStockAlertQty),
        maxStockAlertQty: Value(productModel.maxStockAlertQty),
        createdBy: Value(productModel.createdBy),
        updatedBy: Value(operatorUserId ?? productModel.updatedBy),
        createdAt: Value(productModel.createdAt ?? DateTime.now()),
        updatedAt: Value(DateTime.now()),
      );
      await productDao.updateProduct(productModel.id, product);
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
    if (product == null) {
      throw const ServerException('未找到对应 ISBN 的商品。');
    }
    return mapProductRecordToModel(
      product.product,
      createdByUsername: product.createdByUsername,
      updatedByUsername: product.updatedByUsername,
    );
  }

  @override
  Future<ProductModel> searchByTitle(String title) async {
    final productDao = database.productDao;
    final product = await productDao.searchByTitle(title);
    if (product == null) {
      throw const ServerException('未找到对应名称的商品。');
    }
    return mapProductRecordToModel(
      product.product,
      createdByUsername: product.createdByUsername,
      updatedByUsername: product.updatedByUsername,
    );
  }
}
