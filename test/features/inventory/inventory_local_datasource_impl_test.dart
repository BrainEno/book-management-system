import 'package:bookstore_management_system/core/database/bookstore_codes.dart';
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_dao.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_local_datasource_impl.dart';
import 'package:bookstore_management_system/features/inventory/domain/entities/inventory_records.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late InventoryLocalDataSourceImpl dataSource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dataSource = InventoryLocalDataSourceImpl(database, InventoryDao(database));
  });

  tearDown(() async {
    await database.close();
  });

  Future<(int userId, int warehouseId, int productId)> seedBaseData() async {
    final userId = await database
        .into(database.users)
        .insert(
          UsersCompanion.insert(
            username: 'admin',
            password: 'hashed',
            role: 'admin',
            salt: 'salt',
          ),
        );
    final warehouseId = await database
        .into(database.warehouses)
        .insert(WarehousesCompanion.insert(code: 'WH-001', name: '主仓'));
    final productId = await database
        .into(database.products)
        .insert(
          ProductsCompanion.insert(
            title: '库存测试图书',
            author: '测试作者',
            price: 58.0,
            productId: 'SKU-INV-001',
            selfEncoding: 'SELF-INV-001',
            stockUnit: const Value('册'),
          ),
        );
    return (userId, warehouseId, productId);
  }

  test('applyStockMovement writes balances and movement history', () async {
    final seeded = await seedBaseData();

    await dataSource.applyStockMovement(
      StockMovementDraft(
        movementNo: 'MV-INV-001',
        movementType: StockMovementTypes.adjustIn,
        warehouseId: seeded.$2,
        productId: seeded.$3,
        qtyDelta: 5,
        occurredAt: DateTime(2026, 4, 4, 11),
        operatorUserId: seeded.$1,
        shelfCode: 'B-02',
      ),
    );

    final snapshots = await dataSource.getInventorySnapshots();
    expect(snapshots, hasLength(1));
    expect(snapshots.single.onHandQty, 5);
    expect(snapshots.single.availableQty, 5);
    expect(snapshots.single.shelfCode, 'B-02');

    final movements = await dataSource.getStockMovements(productId: seeded.$3);
    expect(movements, hasLength(1));
    expect(movements.single.movementType, StockMovementTypes.adjustIn);
    expect(movements.single.qtyDelta, 5);
  });

  test('applyStockMovement blocks negative inventory', () async {
    final seeded = await seedBaseData();

    expect(
      () => dataSource.applyStockMovement(
        StockMovementDraft(
          movementNo: 'MV-INV-002',
          movementType: StockMovementTypes.adjustOut,
          warehouseId: seeded.$2,
          productId: seeded.$3,
          qtyDelta: -1,
          occurredAt: DateTime(2026, 4, 4, 11, 30),
          operatorUserId: seeded.$1,
        ),
      ),
      throwsA(
        isA<ServerException>().having(
          (error) => error.message,
          'message',
          contains('没有库存记录'),
        ),
      ),
    );
  });
}
