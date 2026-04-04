import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_local_datasource.dart';
import 'package:bookstore_management_system/features/inventory/domain/entities/inventory_records.dart';
import 'package:bookstore_management_system/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:fpdart/fpdart.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  const InventoryRepositoryImpl(this._localDataSource);

  final InventoryLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<InventoryStockSnapshot>>> getInventorySnapshots({
    int? warehouseId,
    String? keyword,
  }) async {
    try {
      return Right(
        await _localDataSource.getInventorySnapshots(
          warehouseId: warehouseId,
          keyword: keyword,
        ),
      );
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<InventoryMovementEntry>>> getStockMovements({
    int? productId,
    int? warehouseId,
    int limit = 200,
  }) async {
    try {
      return Right(
        await _localDataSource.getStockMovements(
          productId: productId,
          warehouseId: warehouseId,
          limit: limit,
        ),
      );
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, void>> applyStockMovement(
    StockMovementDraft movementDraft,
  ) async {
    try {
      await _localDataSource.applyStockMovement(movementDraft);
      return const Right(null);
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }
}
