import 'package:equatable/equatable.dart';

class PurchaseOrderLineDraft extends Equatable {
  const PurchaseOrderLineDraft({
    required this.productId,
    required this.qty,
    required this.unitPriceCent,
    this.discountBp = 10000,
    this.note,
    this.shelfCode,
  });

  final int productId;
  final int qty;
  final int unitPriceCent;
  final int discountBp;
  final String? note;
  final String? shelfCode;

  int get lineAmountCent => ((qty * unitPriceCent) * (discountBp / 10000)).round();

  @override
  List<Object?> get props => [
        productId,
        qty,
        unitPriceCent,
        discountBp,
        note,
        shelfCode,
      ];
}

class PurchaseOrderDraft extends Equatable {
  const PurchaseOrderDraft({
    this.id,
    required this.orderNo,
    required this.supplierId,
    required this.warehouseId,
    required this.orderedAt,
    required this.lines,
    this.expectedAt,
    this.status = 0,
    this.paidAmountCent = 0,
    this.createdBy,
    this.approvedBy,
    this.postedBy,
    this.postedAt,
    this.note,
  });

  final int? id;
  final String orderNo;
  final int supplierId;
  final int warehouseId;
  final int status;
  final DateTime orderedAt;
  final DateTime? expectedAt;
  final int paidAmountCent;
  final int? createdBy;
  final int? approvedBy;
  final int? postedBy;
  final DateTime? postedAt;
  final String? note;
  final List<PurchaseOrderLineDraft> lines;

  int get totalAmountCent =>
      lines.fold(0, (sum, line) => sum + line.lineAmountCent);

  @override
  List<Object?> get props => [
        id,
        orderNo,
        supplierId,
        warehouseId,
        status,
        orderedAt,
        expectedAt,
        paidAmountCent,
        createdBy,
        approvedBy,
        postedBy,
        postedAt,
        note,
        lines,
      ];
}

class PurchaseOrderLine extends Equatable {
  const PurchaseOrderLine({
    required this.id,
    required this.lineNo,
    required this.productId,
    required this.productCode,
    required this.productTitle,
    required this.qty,
    required this.unitPriceCent,
    required this.discountBp,
    required this.lineAmountCent,
    required this.receivedQty,
    this.note,
    this.shelfCode,
  });

  final int id;
  final int lineNo;
  final int productId;
  final String productCode;
  final String productTitle;
  final int qty;
  final int unitPriceCent;
  final int discountBp;
  final int lineAmountCent;
  final int receivedQty;
  final String? note;
  final String? shelfCode;

  @override
  List<Object?> get props => [
        id,
        lineNo,
        productId,
        productCode,
        productTitle,
        qty,
        unitPriceCent,
        discountBp,
        lineAmountCent,
        receivedQty,
        note,
        shelfCode,
      ];
}

class PurchaseOrderDetail extends Equatable {
  const PurchaseOrderDetail({
    required this.id,
    required this.orderNo,
    required this.supplierId,
    required this.supplierName,
    required this.warehouseId,
    required this.warehouseName,
    required this.status,
    required this.orderedAt,
    required this.totalAmountCent,
    required this.paidAmountCent,
    required this.items,
    this.expectedAt,
    this.createdBy,
    this.approvedBy,
    this.postedBy,
    this.postedAt,
    this.note,
  });

  final int id;
  final String orderNo;
  final int supplierId;
  final String supplierName;
  final int warehouseId;
  final String warehouseName;
  final int status;
  final DateTime orderedAt;
  final DateTime? expectedAt;
  final int totalAmountCent;
  final int paidAmountCent;
  final int? createdBy;
  final int? approvedBy;
  final int? postedBy;
  final DateTime? postedAt;
  final String? note;
  final List<PurchaseOrderLine> items;

  @override
  List<Object?> get props => [
        id,
        orderNo,
        supplierId,
        supplierName,
        warehouseId,
        warehouseName,
        status,
        orderedAt,
        expectedAt,
        totalAmountCent,
        paidAmountCent,
        createdBy,
        approvedBy,
        postedBy,
        postedAt,
        note,
        items,
      ];
}
