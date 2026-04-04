import 'package:bookstore_management_system/core/database/bookstore_tables.dart'
    show StockBalances, StockMovements, Warehouses;
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/user_dao.dart'
    show Users;
import 'package:bookstore_management_system/features/inventory/domain/entities/inventory_records.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_dao.dart'
    show Products;
import 'package:drift/drift.dart';

part 'inventory_dao.g.dart';

@DriftAccessor(
  tables: [StockBalances, StockMovements, Warehouses, Users, Products],
)
class InventoryDao extends DatabaseAccessor<AppDatabase>
    with _$InventoryDaoMixin {
  InventoryDao(super.db);

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

  Future<List<InventoryStockSnapshot>> getInventorySnapshots({
    int? warehouseId,
    String? keyword,
  }) async {
    final conditions = <String>[];
    final variables = <Variable<Object>>[];

    if (warehouseId != null) {
      conditions.add('w.id = ?');
      variables.add(Variable.withInt(warehouseId));
    }

    final normalizedKeyword = keyword?.trim();
    if (normalizedKeyword != null && normalizedKeyword.isNotEmpty) {
      conditions.add('''
        (
          p.title LIKE ?
          OR p.product_id LIKE ?
          OR p.isbn LIKE ?
          OR p.author LIKE ?
        )
        ''');
      final pattern = '%$normalizedKeyword%';
      variables.addAll([
        Variable.withString(pattern),
        Variable.withString(pattern),
        Variable.withString(pattern),
        Variable.withString(pattern),
      ]);
    }

    final whereClause = conditions.isEmpty
        ? ''
        : 'WHERE ${conditions.join(' AND ')}';

    final rows = await customSelect('''
      SELECT
        sb.id AS balance_id,
        p.id AS product_row_id,
        p.product_id,
        p.title,
        p.author,
        p.isbn,
        p.category,
        p.publisher,
        p.stock_unit,
        p.min_stock_alert_qty,
        p.max_stock_alert_qty,
        w.id AS warehouse_row_id,
        w.name AS warehouse_name,
        sb.on_hand_qty,
        sb.reserved_qty,
        sb.safety_stock_qty,
        sb.shelf_code,
        sb.updated_at
      FROM stock_balances sb
      INNER JOIN products p ON p.id = sb.product_id
      INNER JOIN warehouses w ON w.id = sb.warehouse_id
      $whereClause
      ORDER BY w.name ASC, p.title ASC, p.id ASC
      ''', variables: variables).get();

    return rows
        .map(
          (row) => InventoryStockSnapshot(
            balanceId: row.read<int>('balance_id'),
            productId: row.read<int>('product_row_id'),
            productCode: row.read<String>('product_id'),
            productTitle: row.read<String>('title'),
            author: row.read<String>('author'),
            isbn: row.data['isbn']?.toString(),
            category: row.data['category']?.toString(),
            publisher: row.data['publisher']?.toString(),
            warehouseId: row.read<int>('warehouse_row_id'),
            warehouseName: row.read<String>('warehouse_name'),
            onHandQty: row.read<int>('on_hand_qty'),
            reservedQty: row.read<int>('reserved_qty'),
            safetyStockQty: row.read<int>('safety_stock_qty'),
            stockUnit: row.data['stock_unit']?.toString() ?? '册',
            shelfCode: row.data['shelf_code']?.toString(),
            minStockAlertQty: row.data['min_stock_alert_qty'] as int?,
            maxStockAlertQty: row.data['max_stock_alert_qty'] as int?,
            updatedAt: _readDateTime(row, 'updated_at'),
          ),
        )
        .toList(growable: false);
  }

  Future<List<InventoryMovementEntry>> getStockMovements({
    int? productId,
    int? warehouseId,
    int limit = 200,
  }) async {
    final conditions = <String>[];
    final variables = <Variable<Object>>[];

    if (productId != null) {
      conditions.add('sm.product_id = ?');
      variables.add(Variable.withInt(productId));
    }
    if (warehouseId != null) {
      conditions.add('sm.warehouse_id = ?');
      variables.add(Variable.withInt(warehouseId));
    }

    final whereClause = conditions.isEmpty
        ? ''
        : 'WHERE ${conditions.join(' AND ')}';

    variables.add(Variable.withInt(limit));

    final rows = await customSelect('''
      SELECT
        sm.id,
        sm.movement_no,
        sm.movement_type,
        sm.ref_type,
        sm.ref_id,
        sm.qty_delta,
        sm.unit_cost_cent,
        sm.amount_cent,
        sm.occurred_at,
        sm.operator_user_id,
        sm.note,
        p.id AS product_row_id,
        p.product_id,
        p.title,
        w.id AS warehouse_row_id,
        w.name AS warehouse_name,
        u.username AS operator_username
      FROM stock_movements sm
      INNER JOIN products p ON p.id = sm.product_id
      INNER JOIN warehouses w ON w.id = sm.warehouse_id
      LEFT JOIN users u ON u.id = sm.operator_user_id
      $whereClause
      ORDER BY sm.occurred_at DESC, sm.id DESC
      LIMIT ?
      ''', variables: variables).get();

    return rows
        .map(
          (row) => InventoryMovementEntry(
            id: row.read<int>('id'),
            movementNo: row.read<String>('movement_no'),
            movementType: row.read<String>('movement_type'),
            refType: row.data['ref_type']?.toString(),
            refId: row.data['ref_id'] as int?,
            productId: row.read<int>('product_row_id'),
            productCode: row.read<String>('product_id'),
            productTitle: row.read<String>('title'),
            warehouseId: row.read<int>('warehouse_row_id'),
            warehouseName: row.read<String>('warehouse_name'),
            qtyDelta: row.read<int>('qty_delta'),
            unitCostCent: row.data['unit_cost_cent'] as int?,
            amountCent: row.data['amount_cent'] as int?,
            occurredAt:
                _readDateTime(row, 'occurred_at') ??
                DateTime.fromMillisecondsSinceEpoch(0),
            operatorUserId: row.data['operator_user_id'] as int?,
            operatorUsername: row.data['operator_username']?.toString(),
            note: row.data['note']?.toString(),
          ),
        )
        .toList(growable: false);
  }

  Future<StockBalance?> getStockBalance(int warehouseId, int productId) {
    return (select(stockBalances)..where(
          (tbl) =>
              tbl.warehouseId.equals(warehouseId) &
              tbl.productId.equals(productId),
        ))
        .getSingleOrNull();
  }

  Future<int> insertStockBalance(StockBalancesCompanion companion) {
    return into(stockBalances).insert(companion);
  }

  Future<void> updateStockBalanceById(
    int id,
    StockBalancesCompanion companion,
  ) {
    return (update(
      stockBalances,
    )..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  Future<int> insertStockMovement(StockMovementsCompanion companion) {
    return into(stockMovements).insert(companion);
  }
}
