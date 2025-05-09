import 'package:bookstore_management_system/features/book/domain/entities/book.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
abstract class BookModel extends Book with _$BookModel {
  // ignore: use_super_parameters
  BookModel._({
    required String bookId,
    required int id,
    required String title,
    required String author,
    required String isbn,
    required double price,
    required String category,
    required String publisher,
    required String selfEncoding,
    required String operator,
  }) : super(
         bookId: bookId,
         id: id,
         title: title,
         author: author,
         isbn: isbn,
         price: price,
         category: category,
         publisher: publisher,
         selfEncoding: selfEncoding,
         operator: operator,
       );

  factory BookModel({
    required String bookId,
    required int id,
    required String title,
    required String author,
    required String isbn,
    required double price,
    required String category,
    required String publisher,
    required String selfEncoding,
    @Default(0.0) double internalPricing,
    @Default(0.0) double purchasePrice,
    @Default(2025) int publicationYear,
    @Default(100) double retailDiscount,
    @Default(100) double wholesaleDiscount,
    @Default(0) double wholesalePrice,
    @Default(100) double memberDiscount,
    @Default('不区分') String purchaseSaleMode,
    @Default('不区分') String bookmark,
    @Default('不区分') String packaging,
    @Default('不区分') String properity,
    @Default('不区分') String statisticalClass,
    required String operator,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Example additional field
    @Default('') String additionalField,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}
