import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/purchase/data/datasources/local/purchase_local_datasource.dart';
import 'package:bookstore_management_system/features/purchase/domain/entities/purchase_records.dart';
import 'package:bookstore_management_system/features/purchase/domain/repositories/purchase_repository.dart';
import 'package:fpdart/fpdart.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  const PurchaseRepositoryImpl(this._localDataSource);

  final PurchaseLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, int>> saveDraft(PurchaseOrderDraft draft) async {
    try {
      return Right(await _localDataSource.saveDraft(draft));
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, PurchaseOrderDetail>> getPurchaseOrderDetail(
    int id,
  ) async {
    try {
      return Right(await _localDataSource.getPurchaseOrderDetail(id));
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, void>> postPurchaseOrder(
    int id, {
    required int operatorUserId,
    DateTime? postedAt,
  }) async {
    try {
      await _localDataSource.postPurchaseOrder(
        id,
        operatorUserId: operatorUserId,
        postedAt: postedAt,
      );
      return const Right(null);
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }
}
