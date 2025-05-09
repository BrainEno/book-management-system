import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/core/usecases/usecase.dart';
import 'package:bookstore_management_system/features/book/domain/entities/book.dart';
import 'package:bookstore_management_system/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBooksUsecase implements UseCase<List<Book>, NoParams> {
  final BookRepository bookRepository;

  GetAllBooksUsecase(this.bookRepository);

  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) async {
    return await bookRepository.getAllBooks();
  }
}
