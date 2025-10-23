part of 'product_bloc.dart';

abstract class ProductEvent {}

class AddBookEvent extends ProductEvent {
  final ProductModel product;

  AddBookEvent(this.product);
}

class UpdateBookEvent extends ProductEvent {
  final ProductModel product;

  UpdateBookEvent(this.product);
}

class DeleteBookEvent extends ProductEvent {
  final int id;

  DeleteBookEvent(this.id);
}

class GetAllBooksEvent extends ProductEvent {}
