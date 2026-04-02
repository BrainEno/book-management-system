import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_local_datasource.dart';
import 'package:bookstore_management_system/features/product/data/mappers/product_record_mapper.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:drift/drift.dart';

class BookLocalDataSourceImpl implements ProductLocalDataSource {
  final AppDatabase database;

  BookLocalDataSourceImpl(this.database);

  @override
  Future<ProductModel> addProduct(ProductModel productModel) async {
    final productDao = database.productDao;
    final ProductsCompanion newProduct = ProductsCompanion(
      id: productModel.id > 0 ? Value(productModel.id) : const Value.absent(),
      title: Value(productModel.title),
      author: Value(productModel.author),
      isbn: Value(productModel.isbn),
      category: Value(productModel.category),
      price: Value(productModel.price),
      publisher: Value(productModel.publisher),
      productId: Value(productModel.productId),
      internalPricing: Value(productModel.internalPricing),
      selfEncoding: Value(productModel.selfEncoding),
      purchasePrice: Value(productModel.purchasePrice),
      publicationYear: Value(productModel.publicationYear),
      retailDiscount: Value(productModel.retailDiscount),
      wholesaleDiscount: Value(productModel.wholesaleDiscount),
      wholesalePrice: Value(productModel.wholesalePrice),
      memberDiscount: Value(productModel.memberDiscount),
      purchaseSaleMode: Value(productModel.purchaseSaleMode),
      bookmark: Value(productModel.bookmark),
      packaging: Value(productModel.packaging),
      properity: Value(productModel.properity),
      statisticalClass: Value(productModel.statisticalClass),
      operator: Value(productModel.operator),
      createdAt: Value(productModel.createdAt ?? DateTime.now()),
      updatedAt: Value(productModel.updatedAt ?? DateTime.now()),
    );
    final insertedId = await productDao.insertProduct(newProduct);
    return productModel.copyWith(id: insertedId);
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final productDao = database.productDao;
    final products = await productDao.getAllProducts();
    return products.map(mapProductRecordToModel).toList();
  }

  @override
  Future<void> updateProduct(ProductModel productModel) async {
    final productDao = database.productDao;
    final product = Product(
      id: productModel.id,
      title: productModel.title,
      author: productModel.author,
      isbn: productModel.isbn,
      category: productModel.category,
      price: productModel.price,
      publisher: productModel.publisher,
      productId: productModel.productId,
      internalPricing: productModel.internalPricing,
      selfEncoding: productModel.selfEncoding,
      purchasePrice: productModel.purchasePrice,
      publicationYear: productModel.publicationYear,
      retailDiscount: productModel.retailDiscount,
      wholesaleDiscount: productModel.wholesaleDiscount,
      wholesalePrice: productModel.wholesalePrice,
      memberDiscount: productModel.memberDiscount,
      purchaseSaleMode: productModel.purchaseSaleMode,
      bookmark: productModel.bookmark,
      packaging: productModel.packaging,
      properity: productModel.properity,
      statisticalClass: productModel.statisticalClass,
      operator: productModel.operator,
      createdAt: productModel.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await productDao.updateProduct(product);
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
