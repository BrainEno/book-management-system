import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_local_datasource.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource productLocalDataSource;

  const ProductRepositoryImpl(this.productLocalDataSource);

  @override
  Future<Either<Failure, Product>> newProduct(ProductModel productModel) async {
    try {
      final product = await productLocalDataSource.addProduct(productModel);
      return Right(product);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final products = await productLocalDataSource.getAllProducts();
      return Right(products);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductModel productModel) async {
    try {
      await productLocalDataSource.updateProduct(productModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await productLocalDataSource.deleteProduct(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> searchByISBN(String isbn) async {
    try {
      final product = await productLocalDataSource.searchByISBN(isbn);
      return Right(product);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> searchByTitle(String title) async {
    try {
      final product = await productLocalDataSource.searchByTitle(title);
      return Right(product);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
