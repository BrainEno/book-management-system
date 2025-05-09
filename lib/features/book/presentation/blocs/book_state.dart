part of 'book_bloc.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookAdded extends BookState {
  final Book book;

  BookAdded(this.book);
}

class BookUpdated extends BookState {}

class BookDeleted extends BookState {}

class BooksLoaded extends BookState {
  final List<Book> books;

  BooksLoaded(this.books);
}

class BookError extends BookState {
  final String message;

  BookError(this.message);
}
