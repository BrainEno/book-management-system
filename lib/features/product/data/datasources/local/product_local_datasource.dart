import 'package:bookstore_management_system/features/product/data/models/product_model.dart';

abstract interface class ProductLocalDataSource {
  Future<ProductModel> addProduct(ProductModel product);
  Future<void> deleteProduct(int id);
  Future<ProductModel> searchByISBN(String isbn);
  Future<ProductModel> searchByTitle(String title);
  Future<void> updateProduct(ProductModel productModel);
  Future<List<ProductModel>> getAllProducts();
}
