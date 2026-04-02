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
}
