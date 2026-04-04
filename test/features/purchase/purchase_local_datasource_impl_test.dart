import 'package:bookstore_management_system/core/database/bookstore_codes.dart';
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_dao.dart';
import 'package:bookstore_management_system/features/purchase/data/datasources/local/purchase_dao.dart';
import 'package:bookstore_management_system/features/purchase/data/datasources/local/purchase_local_datasource_impl.dart';
import 'package:bookstore_management_system/features/purchase/domain/entities/purchase_records.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late PurchaseLocalDataSourceImpl dataSource;

  Future<int> seedUser() {
    return database
        .into(database.users)
        .insert(
          UsersCompanion.insert(
            username: 'admin',
            password: 'hashed',
            role: 'admin',
            salt: 'salt',
          ),
        );
  }

  Future<int> seedSupplier() {
    return database
        .into(database.suppliers)
        .insert(SuppliersCompanion.insert(code: 'SUP-001', name: '测试供应商'));
  }

  Future<int> seedWarehouse() {
    return database
        .into(database.warehouses)
        .insert(WarehousesCompanion.insert(code: 'WH-001', name: '主仓'));
  }

  Future<int> seedProduct() {
    return database
        .into(database.products)
        .insert(
          ProductsCompanion.insert(
            title: '入库测试图书',
            author: '测试作者',
            price: 45.8,
            productId: 'SKU-001',
            selfEncoding: 'SELF-001',
            isbn: const Value('9787300001999'),
            purchasePrice: const Value(30.5),
          ),
        );
  }

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dataSource = PurchaseLocalDataSourceImpl(
      database,
      PurchaseDao(database),
      InventoryDao(database),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('saveDraft and postPurchaseOrder build inventory foundation', () async {
    final userId = await seedUser();
    final supplierId = await seedSupplier();
    final warehouseId = await seedWarehouse();
    final productId = await seedProduct();

    final draftId = await dataSource.saveDraft(
      PurchaseOrderDraft(
        orderNo: 'PO-20260404-001',
        supplierId: supplierId,
        warehouseId: warehouseId,
        orderedAt: DateTime(2026, 4, 4, 9),
        createdBy: userId,
        lines: [
          PurchaseOrderLineDraft(
            productId: productId,
            qty: 8,
            unitPriceCent: 3050,
            discountBp: 10000,
            shelfCode: 'A-01',
          ),
        ],
      ),
    );

    expect(draftId, greaterThan(0));

    final draft = await dataSource.getPurchaseOrderDetail(draftId);
    expect(draft.status, PurchaseOrderStatuses.draft);
    expect(draft.totalAmountCent, 24400);
    expect(draft.items.single.productId, productId);

    await dataSource.postPurchaseOrder(
      draftId,
      operatorUserId: userId,
      postedAt: DateTime(2026, 4, 4, 9, 30),
    );

    final posted = await dataSource.getPurchaseOrderDetail(draftId);
    expect(posted.status, PurchaseOrderStatuses.completed);
    expect(posted.postedBy, userId);
    expect(posted.items.single.receivedQty, 8);

    final balance =
        await (database.select(database.stockBalances)..where(
              (tbl) =>
                  tbl.warehouseId.equals(warehouseId) &
                  tbl.productId.equals(productId),
            ))
            .getSingle();
    expect(balance.onHandQty, 8);
    expect(balance.shelfCode, 'A-01');

    final movement = await (database.select(
      database.stockMovements,
    )..where((tbl) => tbl.refId.equals(draftId))).getSingle();
    expect(movement.movementType, StockMovementTypes.purchaseIn);
    expect(movement.qtyDelta, 8);
    expect(movement.unitCostCent, 3050);
    expect(movement.amountCent, 24400);
  });

  test('postPurchaseOrder rejects duplicate posting', () async {
    final userId = await seedUser();
    final supplierId = await seedSupplier();
    final warehouseId = await seedWarehouse();
    final productId = await seedProduct();

    final draftId = await dataSource.saveDraft(
      PurchaseOrderDraft(
        orderNo: 'PO-20260404-002',
        supplierId: supplierId,
        warehouseId: warehouseId,
        orderedAt: DateTime(2026, 4, 4, 10),
        createdBy: userId,
        lines: [
          PurchaseOrderLineDraft(
            productId: productId,
            qty: 3,
            unitPriceCent: 2900,
          ),
        ],
      ),
    );

    await dataSource.postPurchaseOrder(draftId, operatorUserId: userId);

    expect(
      () => dataSource.postPurchaseOrder(draftId, operatorUserId: userId),
      throwsA(
        isA<ServerException>().having(
          (error) => error.message,
          'message',
          contains('已经过账完成'),
        ),
      ),
    );
  });
}
