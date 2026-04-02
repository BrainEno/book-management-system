import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ProductModel buildProduct({
    required String productId,
    required String title,
    String author = '作者',
    String isbn = '9787300000000',
    String publisher = '测试出版社',
    String category = '文学',
    String selfEncoding = '',
    double price = 39,
    int id = 1,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      productId: productId,
      id: id,
      title: title,
      author: author,
      isbn: isbn,
      price: price,
      category: category,
      publisher: publisher,
      selfEncoding: selfEncoding,
      internalPricing: 25.5,
      purchasePrice: 20,
      publicationYear: 2024,
      retailDiscount: 90,
      wholesaleDiscount: 82.5,
      wholesalePrice: 32,
      memberDiscount: 88,
      purchaseSaleMode: '零售',
      bookmark: '08/404',
      packaging: '平装',
      properity: '普通图书',
      statisticalClass: '小说',
      operator: 'tester',
      createdAt: createdAt,
      updatedAt: updatedAt,
      additionalField: '备注信息',
    );
  }

  group('product query utils', () {
    test('filters products by selected query mode', () {
      final products = [
        buildProduct(productId: 'A-001', title: '时间之书', author: '陈晨', id: 1),
        buildProduct(productId: 'B-002', title: '河流手记', author: '王平', id: 2),
        buildProduct(productId: 'C-003', title: '夜航船', author: '李四', id: 3),
      ];

      final results = filterAndSortProducts(
        products,
        mode: ProductQueryMode.author,
        query: '王平',
      );

      expect(results, hasLength(1));
      expect(results.first.productId, 'B-002');
    });

    test('sorts products by product code before title fallback', () {
      final products = [
        buildProduct(productId: 'C-003', title: '第三本', id: 3),
        buildProduct(productId: 'A-001', title: '第一本', id: 1),
        buildProduct(productId: 'B-002', title: '第二本', id: 2),
      ];

      final results = filterAndSortProducts(
        products,
        mode: ProductQueryMode.title,
        query: '',
      );

      expect(results.map((product) => product.productId), [
        'A-001',
        'B-002',
        'C-003',
      ]);
    });

    test('returns selected products for export in visible order', () {
      final visibleProducts = [
        buildProduct(productId: 'A-001', title: '第一本', id: 1),
        buildProduct(productId: 'B-002', title: '第二本', id: 2),
        buildProduct(productId: 'C-003', title: '第三本', id: 3),
      ];

      final results = resolveProductsForExport(
        visibleProducts: visibleProducts,
        selectedProductIds: {3, 1},
      );

      expect(results.map((product) => product.id), [1, 3]);
    });

    test('returns visible products when nothing is selected', () {
      final visibleProducts = [
        buildProduct(productId: 'A-001', title: '第一本', id: 1),
        buildProduct(productId: 'B-002', title: '第二本', id: 2),
      ];

      final results = resolveProductsForExport(
        visibleProducts: visibleProducts,
        selectedProductIds: const <int>{},
      );

      expect(results.map((product) => product.id), [1, 2]);
    });

    test('builds chinese headers and default inventory rows for export', () {
      final createdAt = DateTime(2026, 4, 3, 10, 30, 5);
      final updatedAt = DateTime(2026, 4, 3, 12, 40, 10);
      final product = buildProduct(
        productId: 'A-001',
        title: '时间之书',
        id: 1,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      final headers = buildProductExportHeaders();
      final rows = buildProductExportDataRows([product]);

      expect(headers.first, '记录ID');
      expect(headers, containsAll(['商品名', '商品编码', 'ISBN码', '库存', '附加信息']));
      expect(rows, hasLength(1));
      expect(rows.first[1], '时间之书');
      expect(rows.first[7], '0');
      expect(rows.first[23], '2026-04-03 10:30:05');
      expect(rows.first[24], '2026-04-03 12:40:10');
      expect(rows.first.last, '备注信息');
    });

    test('builds csv with utf8 bom and escaped content', () {
      final product = buildProduct(
        productId: 'A-001',
        title: '时间,之书',
        author: '王"平',
        id: 1,
      );

      final csv = buildProductExportCsv([product]);

      expect(csv.startsWith('\uFEFF'), isTrue);
      expect(csv, contains('商品名,商品编码'));
      expect(csv, contains('"时间,之书"'));
      expect(csv, contains('"王""平"'));
    });

    test('ensures csv extension when missing', () {
      expect(ensureCsvExtension('/tmp/products'), '/tmp/products.csv');
      expect(ensureCsvExtension('/tmp/products.csv'), '/tmp/products.csv');
    });

    test('builds suggested export file name with date and query info', () {
      final fileName = suggestedProductExportFileName(
        now: DateTime(2026, 4, 3, 11, 22, 33),
        queryMode: ProductQueryMode.title,
        query: '时间之书',
      );

      expect(fileName, '商品信息导出_20260403_商品名_时间之书.csv');
    });

    test('sanitizes invalid characters in export query descriptor', () {
      final descriptor = buildProductExportQueryDescriptor(
        queryMode: ProductQueryMode.isbn,
        query: '978/7300:001?*"',
      );

      expect(descriptor, 'ISBN_978_7300_001');
    });

    test('uses all products descriptor when query is empty', () {
      final descriptor = buildProductExportQueryDescriptor(
        queryMode: ProductQueryMode.author,
        query: '   ',
      );

      expect(descriptor, '全部商品');
    });
  });
}
