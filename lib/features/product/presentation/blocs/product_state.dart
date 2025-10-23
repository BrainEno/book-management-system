part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductAdded extends ProductState {
  final Product product;

  ProductAdded(this.product);
}

class ProductUpdated extends ProductState {}

class ProductDeleted extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
