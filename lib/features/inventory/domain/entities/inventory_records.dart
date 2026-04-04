import 'package:equatable/equatable.dart';

class InventoryStockSnapshot extends Equatable {
  const InventoryStockSnapshot({
    required this.productId,
    required this.productCode,
    required this.productTitle,
    required this.author,
    required this.warehouseId,
    required this.warehouseName,
    required this.onHandQty,
    required this.reservedQty,
    required this.safetyStockQty,
    required this.stockUnit,
    this.balanceId,
    this.isbn,
    this.category,
    this.publisher,
    this.shelfCode,
    this.minStockAlertQty,
    this.maxStockAlertQty,
    this.updatedAt,
  });

  final int? balanceId;
  final int productId;
  final String productCode;
  final String productTitle;
  final String author;
  final String? isbn;
  final String? category;
  final String? publisher;
  final int warehouseId;
  final String warehouseName;
  final int onHandQty;
  final int reservedQty;
  final int safetyStockQty;
  final String stockUnit;
  final String? shelfCode;
  final int? minStockAlertQty;
  final int? maxStockAlertQty;
  final DateTime? updatedAt;

  int get availableQty => onHandQty - reservedQty;

  @override
  List<Object?> get props => [
        balanceId,
        productId,
        productCode,
        productTitle,
        author,
        isbn,
        category,
        publisher,
        warehouseId,
        warehouseName,
        onHandQty,
        reservedQty,
        safetyStockQty,
        stockUnit,
        shelfCode,
        minStockAlertQty,
        maxStockAlertQty,
        updatedAt,
      ];
}

class InventoryMovementEntry extends Equatable {
  const InventoryMovementEntry({
    required this.id,
    required this.movementNo,
    required this.movementType,
    required this.productId,
    required this.productCode,
    required this.productTitle,
    required this.warehouseId,
    required this.warehouseName,
    required this.qtyDelta,
    required this.occurredAt,
    this.refType,
    this.refId,
    this.unitCostCent,
    this.amountCent,
    this.operatorUserId,
    this.operatorUsername,
    this.note,
  });

  final int id;
  final String movementNo;
  final String movementType;
  final String? refType;
  final int? refId;
  final int productId;
  final String productCode;
  final String productTitle;
  final int warehouseId;
  final String warehouseName;
  final int qtyDelta;
  final int? unitCostCent;
  final int? amountCent;
  final DateTime occurredAt;
  final int? operatorUserId;
  final String? operatorUsername;
  final String? note;

  @override
  List<Object?> get props => [
        id,
        movementNo,
        movementType,
        refType,
        refId,
        productId,
        productCode,
        productTitle,
        warehouseId,
        warehouseName,
        qtyDelta,
        unitCostCent,
        amountCent,
        occurredAt,
        operatorUserId,
        operatorUsername,
        note,
      ];
}

class StockMovementDraft extends Equatable {
  const StockMovementDraft({
    required this.movementNo,
    required this.movementType,
    required this.warehouseId,
    required this.productId,
    required this.qtyDelta,
    required this.occurredAt,
    this.refType,
    this.refId,
    this.unitCostCent,
    this.amountCent,
    this.operatorUserId,
    this.note,
    this.shelfCode,
  });

  final String movementNo;
  final String movementType;
  final String? refType;
  final int? refId;
  final int warehouseId;
  final int productId;
  final int qtyDelta;
  final int? unitCostCent;
  final int? amountCent;
  final DateTime occurredAt;
  final int? operatorUserId;
  final String? note;
  final String? shelfCode;

  @override
  List<Object?> get props => [
        movementNo,
        movementType,
        refType,
        refId,
        warehouseId,
        productId,
        qtyDelta,
        unitCostCent,
        amountCent,
        occurredAt,
        operatorUserId,
        note,
        shelfCode,
      ];
}
