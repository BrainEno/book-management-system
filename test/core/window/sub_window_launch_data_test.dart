import 'package:bookstore_management_system/app/bootstrap/app_startup.dart';
import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';
import 'package:bookstore_management_system/core/window/sub_window_launch_data.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SubWindowLaunchData encodes and decodes payload and bounds', () {
    final payload = AppWindowPayload(
      initialProduct: ProductModel(
        productId: 'P-001',
        id: 7,
        title: '测试图书',
        author: '作者甲',
        isbn: '9787300000001',
        price: 59.8,
        category: '文学',
        publisher: '测试出版社',
        selfEncoding: 'SE-7',
        operator: 'admin',
      ),
    );
    final launchData = SubWindowLaunchData(
      page: 'product-editor',
      title: '编辑商品资料',
      hostWindowId: 'window-7',
      state: payload.toJson(),
      bounds: const SubWindowBounds(
        left: 120,
        top: 80,
        width: 900,
        height: 640,
      ),
    );

    final decoded = SubWindowLaunchData.decode(launchData.encode());

    expect(decoded.page, 'product-editor');
    expect(decoded.title, '编辑商品资料');
    expect(decoded.hostWindowId, 'window-7');
    expect(decoded.bounds?.width, 900);
    expect(
      AppWindowPayload.fromJson(decoded.state).initialProduct?.title,
      '测试图书',
    );
  });

  test('startup helpers resolve title and sub-window launch data', () {
    const launchData = SubWindowLaunchData(
      page: 'product',
      title: '商品资料',
      hostWindowId: 'window-1',
    );

    expect(isSubWindowLaunch(launchData.encode()), isTrue);
    expect(resolveSubWindowTitle(launchData.encode()), '商品资料');
    expect(
      resolveSubWindowLaunchData(launchData.encode())?.hostWindowId,
      'window-1',
    );
  });

  test('AppWindowPayload keeps editor draft through json conversion', () {
    const payload = AppWindowPayload(
      productEditorDraft: {'title': '草稿标题', 'price': '68.5'},
    );

    final decoded = AppWindowPayload.fromJson(payload.toJson());

    expect(decoded.productEditorDraft?['title'], '草稿标题');
    expect(decoded.productEditorDraft?['price'], '68.5');
  });

  test('AppWindowPayload keeps current operator username through json conversion', () {
    const payload = AppWindowPayload(currentOperatorUsername: 'tester');

    final decoded = AppWindowPayload.fromJson(payload.toJson());

    expect(decoded.currentOperatorUsername, 'tester');
  });
}
