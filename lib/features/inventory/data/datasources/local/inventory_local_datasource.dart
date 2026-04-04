import 'package:bookstore_management_system/features/inventory/domain/entities/inventory_records.dart';

abstract interface class InventoryLocalDataSource {
  Future<List<InventoryStockSnapshot>> getInventorySnapshots({
    int? warehouseId,
    String? keyword,
  });

  Future<List<InventoryMovementEntry>> getStockMovements({
    int? productId,
    int? warehouseId,
    int limit = 200,
  });

  Future<void> applyStockMovement(StockMovementDraft movementDraft);
}
