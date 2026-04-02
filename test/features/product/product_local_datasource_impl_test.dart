import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_local_datasource_impl.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late BookLocalDataSourceImpl dataSource;

  ProductModel buildProduct({
    required String productId,
    required String title,
    required String isbn,
    int id = 0,
  }) {
    return ProductModel(
      productId: productId,
      id: id,
      title: title,
      author: '测试作者',
      isbn: isbn,
      price: 35,
      category: '不区分',
      publisher: '不区分',
      selfEncoding: isbn,
      operator: 'admin',
    );
  }

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dataSource = BookLocalDataSourceImpl(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('addProduct uses database auto increment id for new products', () async {
    final first = await dataSource.addProduct(
      buildProduct(productId: 'qhwxdl', title: '奇幻文学导论', isbn: '9787561492031'),
    );
    final second = await dataSource.addProduct(
      buildProduct(productId: 'yhch', title: '夜航船', isbn: '9787300000012'),
    );

    expect(first.id, greaterThan(0));
    expect(second.id, greaterThan(first.id));

    final savedProducts = await dataSource.getAllProducts();
    expect(savedProducts, hasLength(2));
    expect(savedProducts.map((product) => product.id), [first.id, second.id]);
  });

  test(
    'addProduct keeps explicit positive id when importing legacy rows',
    () async {
      final saved = await dataSource.addProduct(
        buildProduct(
          productId: 'legacy-01',
          title: '旧版导入图书',
          isbn: '9787300000099',
          id: 99,
        ),
      );

      expect(saved.id, 99);
      final products = await dataSource.getAllProducts();
      expect(products.single.id, 99);
    },
  );
}
