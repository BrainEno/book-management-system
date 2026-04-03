import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_local_datasource_impl.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:drift/drift.dart' show Variable;
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

  test('pricing fields are stored as integer cents and basis points', () async {
    final saved = await dataSource.addProduct(
      ProductModel(
        productId: 'price-01',
        id: 0,
        title: '价格测试图书',
        author: '测试作者',
        isbn: '9787300000100',
        price: 35.55,
        category: '不区分',
        publisher: '不区分',
        selfEncoding: 'price-01',
        internalPricing: 20.1,
        purchasePrice: 18.05,
        publicationYear: 2026,
        retailDiscount: 87.5,
        wholesaleDiscount: 76.25,
        wholesalePrice: 30.4,
        memberDiscount: 91.5,
        purchaseSaleMode: '零售',
        bookmark: '08/404',
        packaging: '不区分',
        properity: '不区分',
        statisticalClass: '不区分',
        operator: 'admin',
      ),
    );

    final rawStorage = await database
        .customSelect(
          '''
      SELECT
        typeof(price) AS price_type,
        price,
        internal_pricing,
        purchase_price,
        retail_discount,
        wholesale_discount,
        wholesale_price,
        member_discount
      FROM products
      WHERE id = ?
      ''',
          variables: [Variable.withInt(saved.id)],
        )
        .getSingle();

    expect(rawStorage.read<String>('price_type'), 'integer');
    expect(rawStorage.read<int>('price'), 3555);
    expect(rawStorage.read<int>('internal_pricing'), 2010);
    expect(rawStorage.read<int>('purchase_price'), 1805);
    expect(rawStorage.read<int>('retail_discount'), 8750);
    expect(rawStorage.read<int>('wholesale_discount'), 7625);
    expect(rawStorage.read<int>('wholesale_price'), 3040);
    expect(rawStorage.read<int>('member_discount'), 9150);
  });

  test(
    'addProduct reports duplicate product codes with a readable message',
    () async {
      await dataSource.addProduct(
        buildProduct(productId: 'dup-01', title: '第一本', isbn: '9787300000111'),
      );

      expect(
        () => dataSource.addProduct(
          buildProduct(
            productId: 'dup-01',
            title: '第二本',
            isbn: '9787300000222',
          ),
        ),
        throwsA(
          isA<ServerException>().having(
            (error) => error.message,
            'message',
            contains('商品编码已存在'),
          ),
        ),
      );
    },
  );
}
