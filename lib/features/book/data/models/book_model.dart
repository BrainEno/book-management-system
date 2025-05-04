import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
sealed class BookModel with _$BookModel {
  const factory BookModel({
    required String bookId,
    required int id,
    required String title,
    required String author,
    required String isbn,
    required double price,
    required String category,
    required String publisher,
    required String internalPricing,
    required String selfEncoding,
    required double purchasePrice,
    required int publicationYear,
    required int retailDiscount,
    required int wholesaleDiscount,
    required int wholesalePrice,
    required int memberDiscount,
    required String purchaseSaleMode,
    required String bookmark,
    required String packaging,
    required String properity,
    required String statisticalClass,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}
