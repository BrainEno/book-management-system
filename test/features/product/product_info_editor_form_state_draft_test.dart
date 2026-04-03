import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('applyDraftData restores form controllers from draft snapshot', () {
    final controllers = ProductInfoEditorFormControllers();
    addTearDown(controllers.dispose);

    controllers.applyDraftData(const {
      'productId': 'B-100',
      'id': '18',
      'title': '浮动中的草稿书名',
      'author': '测试作者',
      'isbn': '9787300000088',
      'price': '88.0',
      'category': '科技',
      'publisher': '人民出版社',
      'selfEncoding': 'SELF-18',
      'internalPricing': '70',
      'purchasePrice': '60',
      'publicationYear': '2025',
      'retailDiscount': '0.9',
      'wholesaleDiscount': '0.8',
      'wholesalePrice': '66',
      'memberDiscount': '0.85',
      'purchaseSaleMode': '零售',
      'bookmark': 'A3',
      'packaging': '精装',
      'properity': '新书',
      'statisticalClass': '历史',
      'operator': 'cashier-1',
    });

    expect(controllers.bookIdController.text, 'B-100');
    expect(controllers.titleController.text, '浮动中的草稿书名');
    expect(controllers.isbnController.text, '9787300000088');
    expect(controllers.categoryController.text, '科技');
    expect(controllers.packagingController.text, '精装');
    expect(controllers.operatorController.text, 'cashier-1');
  });
}
