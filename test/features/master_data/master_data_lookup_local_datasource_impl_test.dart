import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/master_data/data/datasources/local/master_data_lookup_dao.dart';
import 'package:bookstore_management_system/features/master_data/data/datasources/local/master_data_lookup_local_datasource_impl.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late MasterDataLookupLocalDataSourceImpl dataSource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dataSource = MasterDataLookupLocalDataSourceImpl(
      MasterDataLookupDao(database),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'lookup datasource exposes active master data and seeded sale modes',
    () async {
      await database
          .into(database.productCategories)
          .insert(ProductCategoriesCompanion.insert(code: 'BOOK', name: '图书'));
      await database
          .into(database.publishers)
          .insert(
            PublishersCompanion.insert(
              name: '测试出版社',
              code: const Value('PUB-001'),
            ),
          );
      await database
          .into(database.suppliers)
          .insert(SuppliersCompanion.insert(code: 'SUP-001', name: '测试供应商'));
      await database
          .into(database.warehouses)
          .insert(WarehousesCompanion.insert(code: 'WH-001', name: '主仓'));

      final categories = await dataSource.getCategories();
      final publishers = await dataSource.getPublishers();
      final suppliers = await dataSource.getSuppliers();
      final warehouses = await dataSource.getWarehouses();
      final saleModes = await dataSource.getPurchaseSaleModes();

      expect(categories.single.name, '图书');
      expect(publishers.single.name, '测试出版社');
      expect(suppliers.single.name, '测试供应商');
      expect(warehouses.single.name, '主仓');
      expect(saleModes.map((mode) => mode.code), contains('retail'));
      expect(saleModes.map((mode) => mode.name), contains('普通零售'));
    },
  );
}
