import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/book/data/models/book_model.dart';
import 'package:bookstore_management_system/features/book/domain/entities/book.dart';
import 'package:bookstore_management_system/features/book/domain/usecase/add_book_usecase.dart';
import 'package:bookstore_management_system/features/book/domain/usecase/delete_book_usecase.dart';
import 'package:bookstore_management_system/features/book/domain/usecase/get_all_books_usecase.dart';
import 'package:bookstore_management_system/features/book/domain/usecase/update_book_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final AddBookUsecase addBookUsecase;
  final UpdateBookUsecase updateBookUsecase;
  final DeleteBookUsecase deleteBookUsecase;
  final GetAllBooksUsecase getAllBooksUsecase;

  BookBloc({
    required this.addBookUsecase,
    required this.updateBookUsecase,
    required this.deleteBookUsecase,
    required this.getAllBooksUsecase,
  }) : super(BookInitial()) {
    on<AddBookEvent>((event, emit) async {
      emit(BookLoading());
      final result = await addBookUsecase(event.book);
      result.fold(
        (failure) => emit(BookError(failure.message)),
        (book) => emit(BookAdded(book)),
      );
    });

    on<UpdateBookEvent>((event, emit) async {
      emit(BookLoading());
      final result = await updateBookUsecase(event.book);
      result.fold(
        (failure) => emit(BookError(failure.message)),
        (_) => emit(BookUpdated()),
      );
    });

    on<DeleteBookEvent>((event, emit) async {
      emit(BookLoading());
      final result = await deleteBookUsecase(event.id);
      result.fold(
        (failure) => emit(BookError(failure.message)),
        (_) => emit(BookDeleted()),
      );
    });

    on<GetAllBooksEvent>((event, emit) async {
      emit(BookLoading());
      final result = await getAllBooksUsecase(NoParams());
      result.fold(
        (failure) => emit(BookError(failure.message)),
        (books) => emit(BooksLoaded(books)),
      );
    });
  }
}
