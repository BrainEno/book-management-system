import 'package:bookstore_management_system/features/purchase/domain/entities/purchase_records.dart';

abstract interface class PurchaseLocalDataSource {
  Future<int> saveDraft(PurchaseOrderDraft draft);
  Future<PurchaseOrderDetail> getPurchaseOrderDetail(int id);
  Future<void> postPurchaseOrder(
    int id, {
    required int operatorUserId,
    DateTime? postedAt,
  });
}
