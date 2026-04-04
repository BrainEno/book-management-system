import 'package:bookstore_management_system/core/database/bookstore_tables.dart'
    show PurchaseOrderItems, PurchaseOrders, Suppliers, Warehouses;
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_dao.dart'
    show Products;
import 'package:bookstore_management_system/features/purchase/domain/entities/purchase_records.dart';
import 'package:drift/drift.dart';

part 'purchase_dao.g.dart';

@DriftAccessor(
  tables: [PurchaseOrders, PurchaseOrderItems, Suppliers, Warehouses, Products],
)
class PurchaseDao extends DatabaseAccessor<AppDatabase>
    with _$PurchaseDaoMixin {
  PurchaseDao(super.db);

  DateTime? _readDateTime(QueryRow row, String columnName) {
    final rawValue = row.data[columnName];
    if (rawValue == null) {
      return null;
    }
    if (rawValue is DateTime) {
      return rawValue;
    }
    if (rawValue is int) {
      return DateTime.fromMillisecondsSinceEpoch(rawValue * 1000);
    }
    return DateTime.tryParse(rawValue.toString());
  }

  Future<PurchaseOrder?> getPurchaseOrderById(int id) {
    return (select(
      purchaseOrders,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertPurchaseOrder(PurchaseOrdersCompanion companion) {
    return into(purchaseOrders).insert(companion);
  }

  Future<void> updatePurchaseOrder(int id, PurchaseOrdersCompanion companion) {
    return (update(
      purchaseOrders,
    )..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  Future<void> deleteItemsByOrderId(int purchaseOrderId) {
    return (delete(
      purchaseOrderItems,
    )..where((tbl) => tbl.purchaseOrderId.equals(purchaseOrderId))).go();
  }

  Future<int> insertPurchaseOrderItem(PurchaseOrderItemsCompanion companion) {
    return into(purchaseOrderItems).insert(companion);
  }

  Future<PurchaseOrderDetail?> getPurchaseOrderDetail(int id) async {
    final header = await customSelect(
      '''
      SELECT
        po.id,
        po.order_no,
        po.supplier_id,
        s.name AS supplier_name,
        po.warehouse_id,
        w.name AS warehouse_name,
        po.status,
        po.ordered_at,
        po.expected_at,
        po.total_amount_cent,
        po.paid_amount_cent,
        po.created_by,
        po.approved_by,
        po.posted_by,
        po.posted_at,
        po.note
      FROM purchase_orders po
      INNER JOIN suppliers s ON s.id = po.supplier_id
      INNER JOIN warehouses w ON w.id = po.warehouse_id
      WHERE po.id = ?
      LIMIT 1
      ''',
      variables: [Variable.withInt(id)],
    ).getSingleOrNull();

    if (header == null) {
      return null;
    }

    final itemRows = await customSelect(
      '''
      SELECT
        poi.id,
        poi.line_no,
        poi.product_id,
        p.product_id AS product_code,
        p.title AS product_title,
        poi.qty,
        poi.unit_price_cent,
        poi.discount_bp,
        poi.line_amount_cent,
        poi.received_qty,
        poi.shelf_code,
        poi.note
      FROM purchase_order_items poi
      INNER JOIN products p ON p.id = poi.product_id
      WHERE poi.purchase_order_id = ?
      ORDER BY poi.line_no ASC, poi.id ASC
      ''',
      variables: [Variable.withInt(id)],
    ).get();

    final items = itemRows
        .map(
          (row) => PurchaseOrderLine(
            id: row.read<int>('id'),
            lineNo: row.read<int>('line_no'),
            productId: row.read<int>('product_id'),
            productCode: row.read<String>('product_code'),
            productTitle: row.read<String>('product_title'),
            qty: row.read<int>('qty'),
            unitPriceCent: row.read<int>('unit_price_cent'),
            discountBp: row.read<int>('discount_bp'),
            lineAmountCent: row.read<int>('line_amount_cent'),
            receivedQty: row.read<int>('received_qty'),
            shelfCode: row.data['shelf_code']?.toString(),
            note: row.data['note']?.toString(),
          ),
        )
        .toList(growable: false);

    return PurchaseOrderDetail(
      id: header.read<int>('id'),
      orderNo: header.read<String>('order_no'),
      supplierId: header.read<int>('supplier_id'),
      supplierName: header.read<String>('supplier_name'),
      warehouseId: header.read<int>('warehouse_id'),
      warehouseName: header.read<String>('warehouse_name'),
      status: header.read<int>('status'),
      orderedAt:
          _readDateTime(header, 'ordered_at') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      expectedAt: _readDateTime(header, 'expected_at'),
      totalAmountCent: header.read<int>('total_amount_cent'),
      paidAmountCent: header.read<int>('paid_amount_cent'),
      createdBy: header.data['created_by'] as int?,
      approvedBy: header.data['approved_by'] as int?,
      postedBy: header.data['posted_by'] as int?,
      postedAt: _readDateTime(header, 'posted_at'),
      note: header.data['note']?.toString(),
      items: items,
    );
  }
}
