import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchProductUsecase implements UseCase<Product, String> {
  final ProductRepository productRepository;

  SearchProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, Product>> call(String isbn) async {
    return await productRepository.searchByISBN(isbn);
  }
}
