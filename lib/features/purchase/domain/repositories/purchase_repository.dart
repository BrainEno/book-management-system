import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/purchase/domain/entities/purchase_records.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PurchaseRepository {
  Future<Either<Failure, int>> saveDraft(PurchaseOrderDraft draft);
  Future<Either<Failure, PurchaseOrderDetail>> getPurchaseOrderDetail(int id);
  Future<Either<Failure, void>> postPurchaseOrder(
    int id, {
    required int operatorUserId,
    DateTime? postedAt,
  });
}
