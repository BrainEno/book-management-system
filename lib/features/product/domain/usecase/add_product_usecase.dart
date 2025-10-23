import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddProductUsecase implements UseCase<Product, ProductModel> {
  final ProductRepository productRepository;

  AddProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, Product>> call(ProductModel product) async {
    return await productRepository.newProduct(product);
  }
}
