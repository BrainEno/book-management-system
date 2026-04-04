import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_detail_form_controller.dart';
import 'package:flutter_test/flutter_test.dart';

ProductModel _buildProduct() {
  return ProductModel(
    id: 1,
    productId: 'book-001',
    title: '等待戈多',
    author: '贝克特',
    isbn: '9787540475277',
    price: 36,
    publisher: '上海译文出版社',
    category: '戏剧',
    selfEncoding: '9787540475277',
    publicationYear: 2021,
    purchaseSaleMode: '购销',
    packaging: '平装',
    statisticalClass: '文学',
  );
}

void main() {
  test(
    'buildUpdatedProduct preserves sensitive fields when admin mode is off',
    () {
      final controller = ProductQueryDetailFormController();
      addTearDown(controller.dispose);

      final original = _buildProduct();
      controller.populate(original);
      controller.isbnController.text = '9787300000001';
      controller.priceController.text = '88';
      controller.publicationYearController.text = '2025';
      controller.packagingController.text = '精装';

      final updated = controller.buildUpdatedProduct(
        original,
        allowSensitiveFieldUpdates: false,
      );

      expect(updated.isbn, original.isbn);
      expect(updated.price, original.price);
      expect(updated.publicationYear, 2025);
      expect(updated.packaging, '精装');
    },
  );

  test(
    'buildUpdatedProduct applies sensitive fields when admin mode is on',
    () {
      final controller = ProductQueryDetailFormController();
      addTearDown(controller.dispose);

      final original = _buildProduct();
      controller.populate(original);
      controller.isbnController.text = '9787300000001';
      controller.priceController.text = '88';

      final updated = controller.buildUpdatedProduct(
        original,
        allowSensitiveFieldUpdates: true,
      );

      expect(updated.isbn, '9787300000001');
      expect(updated.price, 88);
    },
  );
}
