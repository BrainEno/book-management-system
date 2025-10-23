import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, Product>> newProduct(ProductModel product);
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, void>> updateProduct(ProductModel productModel);
  Future<Either<Failure, void>> deleteProduct(int id);
  Future<Either<Failure, Product>> searchByISBN(String isbn);
  Future<Either<Failure, Product>> searchByTitle(String title);
}
