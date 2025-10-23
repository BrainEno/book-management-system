import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/add_product_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/delete_product_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/get_all_products_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/update_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProductUsecase addProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  final GetAllProductsUsecase getAllProductsUsecase;

  ProductBloc({
    required this.addProductUsecase,
    required this.updateProductUsecase,
    required this.deleteProductUsecase,
    required this.getAllProductsUsecase,
  }) : super(ProductInitial()) {
    on<AddBookEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await addProductUsecase(event.product);
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (product) => emit(ProductAdded(product)),
      );
    });

    on<UpdateBookEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await updateProductUsecase(event.product);
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (_) => emit(ProductUpdated()),
      );
    });

    on<DeleteBookEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await deleteProductUsecase(event.id);
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (_) => emit(ProductDeleted()),
      );
    });

    on<GetAllBooksEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await getAllProductsUsecase(NoParams());
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (products) => emit(ProductsLoaded(products)),
      );
    });
  }
}
