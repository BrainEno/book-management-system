import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/inventory/domain/entities/inventory_records.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class InventoryRepository {
  Future<Either<Failure, List<InventoryStockSnapshot>>> getInventorySnapshots({
    int? warehouseId,
    String? keyword,
  });

  Future<Either<Failure, List<InventoryMovementEntry>>> getStockMovements({
    int? productId,
    int? warehouseId,
    int limit = 200,
  });

  Future<Either<Failure, void>> applyStockMovement(
    StockMovementDraft movementDraft,
  );
}
