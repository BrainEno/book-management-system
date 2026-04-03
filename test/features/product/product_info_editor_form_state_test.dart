import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('buildProduct preserves existing product id when editing', () {
    final controllers = ProductInfoEditorFormControllers();
    addTearDown(controllers.dispose);

    final existingProduct = ProductModel(
      productId: 'A-001',
      id: 42,
      title: '旧书名',
      author: '旧作者',
      isbn: '9787300000042',
      price: 58,
      category: '文学',
      publisher: '测试出版社',
      selfEncoding: 'SE-42',
      operator: 'admin',
    );

    controllers.idController.text = '';
    controllers.bookIdController.text = 'A-001';
    controllers.titleController.text = '新书名';
    controllers.authorController.text = '新作者';
    controllers.isbnController.text = '9787300000042';
    controllers.priceController.text = '60';
    controllers.categoryController.text = '文学';
    controllers.publisherController.text = '测试出版社';
    controllers.selfEncodingController.text = 'SE-42';
    controllers.operatorController.text = 'admin';

    final product = controllers.buildProduct(existingProduct: existingProduct);

    expect(product.id, 42);
    expect(product.title, '新书名');
  });

  test('buildProduct falls back to isbn when self encoding is blank', () {
    final controllers = ProductInfoEditorFormControllers();
    addTearDown(controllers.dispose);

    controllers.idController.text = '0';
    controllers.bookIdController.text = 'A-002';
    controllers.titleController.text = 'ISBN 回填图书';
    controllers.authorController.text = '新作者';
    controllers.isbnController.text = '9787300000043';
    controllers.priceController.text = '60';
    controllers.categoryController.text = '文学';
    controllers.publisherController.text = '测试出版社';
    controllers.selfEncodingController.text = '   ';
    controllers.operatorController.text = 'admin';

    final product = controllers.buildProduct();

    expect(product.selfEncoding, '9787300000043');
  });

  test(
    'resetForNewEntry clears prior values and keeps operator when provided',
    () {
      final controllers = ProductInfoEditorFormControllers();
      addTearDown(controllers.dispose);

      controllers.bookIdController.text = 'A-003';
      controllers.titleController.text = '待清空图书';
      controllers.authorController.text = '作者';
      controllers.isbnController.text = '9787300000044';
      controllers.priceController.text = '88';
      controllers.categoryController.text = '文学';
      controllers.publisherController.text = '测试出版社';
      controllers.packagingController.text = '精装';
      controllers.operatorController.text = 'old-user';

      controllers.resetForNewEntry(operatorUsername: 'tester');

      expect(controllers.bookIdController.text, isEmpty);
      expect(controllers.titleController.text, isEmpty);
      expect(controllers.authorController.text, isEmpty);
      expect(controllers.isbnController.text, isEmpty);
      expect(controllers.priceController.text, isEmpty);
      expect(controllers.categoryController.text, '不区分');
      expect(controllers.publisherController.text, '不区分');
      expect(controllers.packagingController.text, '不区分');
      expect(controllers.operatorController.text, 'tester');
    },
  );
}
