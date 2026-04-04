import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_dao.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_local_datasource.dart';
import 'package:bookstore_management_system/features/inventory/domain/entities/inventory_records.dart';
import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

class InventoryLocalDataSourceImpl implements InventoryLocalDataSource {
  const InventoryLocalDataSourceImpl(this._database, this._inventoryDao);

  final AppDatabase _database;
  final InventoryDao _inventoryDao;

  String _movementConstraintMessage(SqliteException error) {
    final message = error.message.toLowerCase();
    if (message.contains('stock_movements.movement_no')) {
      return '库存流水号重复，请重试。';
    }
    if (message.contains('qty_delta')) {
      return '库存变动数量不能为 0。';
    }
    if (message.contains('movement_type')) {
      return '库存流水类型无效。';
    }
    return '库存变更失败：${error.message}';
  }

  @override
  Future<List<InventoryStockSnapshot>> getInventorySnapshots({
    int? warehouseId,
    String? keyword,
  }) {
    return _inventoryDao.getInventorySnapshots(
      warehouseId: warehouseId,
      keyword: keyword,
    );
  }

  @override
  Future<List<InventoryMovementEntry>> getStockMovements({
    int? productId,
    int? warehouseId,
    int limit = 200,
  }) {
    return _inventoryDao.getStockMovements(
      productId: productId,
      warehouseId: warehouseId,
      limit: limit,
    );
  }

  @override
  Future<void> applyStockMovement(StockMovementDraft movementDraft) async {
    try {
      await _database.transaction(() async {
        final existingBalance = await _inventoryDao.getStockBalance(
          movementDraft.warehouseId,
          movementDraft.productId,
        );

        final now = DateTime.now();
        if (existingBalance == null) {
          if (movementDraft.qtyDelta < 0) {
            throw const ServerException('当前商品还没有库存记录，无法直接扣减库存。');
          }

          await _inventoryDao.insertStockBalance(
            StockBalancesCompanion.insert(
              warehouseId: movementDraft.warehouseId,
              productId: movementDraft.productId,
              onHandQty: Value(movementDraft.qtyDelta),
              shelfCode: Value(movementDraft.shelfCode),
              updatedAt: Value(now),
            ),
          );
        } else {
          final nextOnHandQty = existingBalance.onHandQty + movementDraft.qtyDelta;
          if (nextOnHandQty < 0) {
            throw const ServerException('库存不足，当前操作会导致库存变成负数。');
          }

          await _inventoryDao.updateStockBalanceById(
            existingBalance.id,
            StockBalancesCompanion(
              onHandQty: Value(nextOnHandQty),
              shelfCode: movementDraft.shelfCode == null
                  ? const Value.absent()
                  : Value(movementDraft.shelfCode),
              updatedAt: Value(now),
            ),
          );
        }

        await _inventoryDao.insertStockMovement(
          StockMovementsCompanion.insert(
            movementNo: movementDraft.movementNo.trim(),
            movementType: movementDraft.movementType.trim(),
            refType: Value(movementDraft.refType),
            refId: Value(movementDraft.refId),
            warehouseId: movementDraft.warehouseId,
            productId: movementDraft.productId,
            qtyDelta: movementDraft.qtyDelta,
            unitCostCent: Value(movementDraft.unitCostCent),
            amountCent: Value(movementDraft.amountCent),
            occurredAt: movementDraft.occurredAt,
            operatorUserId: Value(movementDraft.operatorUserId),
            note: Value(movementDraft.note),
            createdAt: Value(now),
          ),
        );
      });
    } on ServerException {
      rethrow;
    } on SqliteException catch (error) {
      throw ServerException(_movementConstraintMessage(error));
    }
  }
}
