part of 'book_bloc.dart';

abstract class BookEvent {}

class AddBookEvent extends BookEvent {
  final BookModel book;

  AddBookEvent(this.book);
}

class UpdateBookEvent extends BookEvent {
  final BookModel book;

  UpdateBookEvent(this.book);
}

class DeleteBookEvent extends BookEvent {
  final int id;

  DeleteBookEvent(this.id);
}

class GetAllBooksEvent extends BookEvent {}
