import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteProductUsecase implements UseCase<void, int> {
  final ProductRepository productRepository;

  DeleteProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await productRepository.deleteProduct(id);
  }
}
