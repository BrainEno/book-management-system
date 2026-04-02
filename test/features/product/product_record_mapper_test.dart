import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/product/data/mappers/product_record_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps drift product record to product model without json casting', () {
    final record = Product(
      id: 12,
      title: '夜航船',
      author: '张三',
      isbn: '9787300000012',
      category: '文学',
      price: 58,
      publisher: '人民出版社',
      productId: 'A-012',
      internalPricing: 45,
      selfEncoding: 'ZX-12',
      purchasePrice: 31,
      publicationYear: 2026,
      retailDiscount: 88,
      wholesaleDiscount: 75,
      wholesalePrice: 42,
      memberDiscount: 90,
      purchaseSaleMode: '零售',
      bookmark: '12/301',
      packaging: '精装',
      properity: '普通图书',
      statisticalClass: '小说',
      operator: 'tester',
      createdAt: DateTime(2026, 4, 1, 10, 0),
      updatedAt: DateTime(2026, 4, 2, 11, 30),
    );

    final model = mapProductRecordToModel(record);

    expect(model.id, 12);
    expect(model.productId, 'A-012');
    expect(model.title, '夜航船');
    expect(model.createdAt, DateTime(2026, 4, 1, 10, 0));
    expect(model.updatedAt, DateTime(2026, 4, 2, 11, 30));
  });
}
