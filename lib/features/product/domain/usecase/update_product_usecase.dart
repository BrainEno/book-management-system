import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateProductUsecase implements UseCase<void, ProductModel> {
  final ProductRepository productRepository;

  UpdateProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, void>> call(ProductModel product) async {
    return await productRepository.updateProduct(product);
  }
}
