import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_export_service.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ProductModel buildProduct() {
    return ProductModel(
      productId: 'A-001',
      id: 1,
      title: '时间之书',
      author: '陈晨',
      isbn: '9787300000000',
      price: 39,
      category: '文学',
      publisher: '测试出版社',
      selfEncoding: 'SE-001',
      operator: 'tester',
    );
  }

  test('exports csv content through injected writer', () async {
    String? writtenPath;
    String? writtenContent;
    String? suggestedName;

    final service = ProductQueryExportService(
      now: () => DateTime(2026, 4, 3, 9, 8, 7),
      pickSavePath: (name) async {
        suggestedName = name;
        return '/tmp/product_export';
      },
      writeFile: (path, content) async {
        writtenPath = path;
        writtenContent = content;
      },
    );

    final result = await service.exportProducts(
      [buildProduct()],
      queryMode: ProductQueryMode.title,
      query: '时间之书',
    );

    expect(result, '/tmp/product_export.csv');
    expect(suggestedName, '商品信息导出_20260403_商品名_时间之书.csv');
    expect(writtenPath, '/tmp/product_export.csv');
    expect(writtenContent, isNotNull);
    expect(writtenContent, contains('商品名'));
    expect(writtenContent, contains('时间之书'));
  });

  test('returns null when save dialog is cancelled', () async {
    final service = ProductQueryExportService(
      pickSavePath: (_) async => null,
      writeFile: (path, content) async {},
    );

    final result = await service.exportProducts(
      [buildProduct()],
      queryMode: ProductQueryMode.isbn,
      query: '9787300000000',
    );

    expect(result, isNull);
  });
}
