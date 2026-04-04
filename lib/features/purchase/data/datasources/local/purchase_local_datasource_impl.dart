import 'package:bookstore_management_system/core/database/bookstore_codes.dart';
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_dao.dart';
import 'package:bookstore_management_system/features/purchase/data/datasources/local/purchase_dao.dart';
import 'package:bookstore_management_system/features/purchase/data/datasources/local/purchase_local_datasource.dart';
import 'package:bookstore_management_system/features/purchase/domain/entities/purchase_records.dart';
import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

class PurchaseLocalDataSourceImpl implements PurchaseLocalDataSource {
  const PurchaseLocalDataSourceImpl(
    this._database,
    this._purchaseDao,
    this._inventoryDao,
  );

  final AppDatabase _database;
  final PurchaseDao _purchaseDao;
  final InventoryDao _inventoryDao;

  String? _normalizeOptionalText(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      return null;
    }
    return normalized;
  }

  String _constraintMessage(SqliteException error) {
    final message = error.message.toLowerCase();
    if (message.contains('purchase_orders.order_no')) {
      return '收货单号已存在，请使用新的单号。';
    }
    if (message.contains('purchase_order_items.purchase_order_id')) {
      return '收货单明细行号重复，请检查明细顺序。';
    }
    return '保存收货单失败：${error.message}';
  }

  void _validateDraft(PurchaseOrderDraft draft) {
    if (draft.orderNo.trim().isEmpty) {
      throw const ServerException('收货单号不能为空。');
    }
    if (draft.lines.isEmpty) {
      throw const ServerException('收货单至少要有一条商品明细。');
    }
    if (draft.lines.any((line) => line.qty <= 0)) {
      throw const ServerException('收货数量必须大于 0。');
    }
    if (draft.lines.any((line) => line.unitPriceCent < 0)) {
      throw const ServerException('收货单价不能小于 0。');
    }
  }

  @override
  Future<int> saveDraft(PurchaseOrderDraft draft) async {
    _validateDraft(draft);

    try {
      return await _database.transaction(() async {
        final now = DateTime.now();
        final existingOrder = draft.id == null
            ? null
            : await _purchaseDao.getPurchaseOrderById(draft.id!);
        final companion = PurchaseOrdersCompanion(
          orderNo: Value(draft.orderNo.trim()),
          supplierId: Value(draft.supplierId),
          warehouseId: Value(draft.warehouseId),
          status: Value(draft.status),
          orderedAt: Value(draft.orderedAt),
          expectedAt: Value(draft.expectedAt),
          totalAmountCent: Value(draft.totalAmountCent),
          paidAmountCent: Value(draft.paidAmountCent),
          createdBy: Value(draft.createdBy),
          approvedBy: Value(draft.approvedBy),
          postedBy: Value(draft.postedBy),
          postedAt: Value(draft.postedAt),
          note: Value(_normalizeOptionalText(draft.note)),
          createdAt: Value(existingOrder?.createdAt ?? now),
          updatedAt: Value(now),
        );

        final orderId = draft.id == null
            ? await _purchaseDao.insertPurchaseOrder(companion)
            : draft.id!;

        if (draft.id != null) {
          await _purchaseDao.updatePurchaseOrder(orderId, companion);
          await _purchaseDao.deleteItemsByOrderId(orderId);
        }

        for (var index = 0; index < draft.lines.length; index++) {
          final line = draft.lines[index];
          await _purchaseDao.insertPurchaseOrderItem(
            PurchaseOrderItemsCompanion.insert(
              purchaseOrderId: orderId,
              lineNo: index + 1,
              productId: line.productId,
              qty: line.qty,
              unitPriceCent: line.unitPriceCent,
              discountBp: Value(line.discountBp),
              lineAmountCent: line.lineAmountCent,
              receivedQty: const Value(0),
              shelfCode: Value(_normalizeOptionalText(line.shelfCode)),
              note: Value(_normalizeOptionalText(line.note)),
            ),
          );
        }

        return orderId;
      });
    } on ServerException {
      rethrow;
    } on SqliteException catch (error) {
      throw ServerException(_constraintMessage(error));
    }
  }

  @override
  Future<PurchaseOrderDetail> getPurchaseOrderDetail(int id) async {
    final detail = await _purchaseDao.getPurchaseOrderDetail(id);
    if (detail == null) {
      throw const ServerException('未找到对应的收货单。');
    }
    return detail;
  }

  @override
  Future<void> postPurchaseOrder(
    int id, {
    required int operatorUserId,
    DateTime? postedAt,
  }) async {
    await _database.transaction(() async {
      final order = await _purchaseDao.getPurchaseOrderById(id);
      final detail = await _purchaseDao.getPurchaseOrderDetail(id);

      if (order == null || detail == null) {
        throw const ServerException('未找到对应的收货单。');
      }
      if (detail.items.isEmpty) {
        throw const ServerException('收货单没有明细，无法过账。');
      }
      if (order.status == PurchaseOrderStatuses.completed) {
        throw const ServerException('当前收货单已经过账完成，请勿重复过账。');
      }
      if (order.status == PurchaseOrderStatuses.cancelled) {
        throw const ServerException('已作废的收货单不能过账。');
      }

      final effectivePostedAt = postedAt ?? DateTime.now();
      final now = DateTime.now();

      for (final item in detail.items) {
        final balance = await _inventoryDao.getStockBalance(
          detail.warehouseId,
          item.productId,
        );
        if (balance == null) {
          await _inventoryDao.insertStockBalance(
            StockBalancesCompanion.insert(
              warehouseId: detail.warehouseId,
              productId: item.productId,
              onHandQty: Value(item.qty),
              shelfCode: Value(_normalizeOptionalText(item.shelfCode)),
              updatedAt: Value(now),
            ),
          );
        } else {
          await _inventoryDao.updateStockBalanceById(
            balance.id,
            StockBalancesCompanion(
              onHandQty: Value(balance.onHandQty + item.qty),
              shelfCode: item.shelfCode == null
                  ? const Value.absent()
                  : Value(_normalizeOptionalText(item.shelfCode)),
              updatedAt: Value(now),
            ),
          );
        }

        await _inventoryDao.insertStockMovement(
          StockMovementsCompanion.insert(
            movementNo:
                'MV-PO-${detail.id}-${item.lineNo}-${effectivePostedAt.microsecondsSinceEpoch}',
            movementType: StockMovementTypes.purchaseIn,
            refType: const Value(StockReferenceTypes.purchaseOrder),
            refId: Value(detail.id),
            warehouseId: detail.warehouseId,
            productId: item.productId,
            qtyDelta: item.qty,
            unitCostCent: Value(item.unitPriceCent),
            amountCent: Value(item.lineAmountCent),
            occurredAt: effectivePostedAt,
            operatorUserId: Value(operatorUserId),
            note: Value(_normalizeOptionalText(item.note ?? detail.note)),
            createdAt: Value(now),
          ),
        );

        await (_database.update(_database.purchaseOrderItems)
              ..where((tbl) => tbl.id.equals(item.id)))
            .write(
          PurchaseOrderItemsCompanion(
            receivedQty: Value(item.qty),
            shelfCode: item.shelfCode == null
                ? const Value.absent()
                : Value(_normalizeOptionalText(item.shelfCode)),
          ),
        );
      }

      await _purchaseDao.updatePurchaseOrder(
        detail.id,
        PurchaseOrdersCompanion(
          status: const Value(PurchaseOrderStatuses.completed),
          approvedBy: Value(detail.approvedBy ?? operatorUserId),
          postedBy: Value(operatorUserId),
          postedAt: Value(effectivePostedAt),
          updatedAt: Value(now),
        ),
      );
    });
  }
}
