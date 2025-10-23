import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllProductsUsecase implements UseCase<List<Product>, NoParams> {
  final ProductRepository productRepository;

  GetAllProductsUsecase(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await productRepository.getAllProducts();
  }
}
