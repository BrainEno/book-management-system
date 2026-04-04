import 'package:bookstore_management_system/core/database/bookstore_tables.dart'
    show
        ProductCategories,
        Publishers,
        PurchaseSaleModes,
        Suppliers,
        Warehouses;
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/features/master_data/domain/entities/master_data_option.dart';
import 'package:drift/drift.dart';

part 'master_data_lookup_dao.g.dart';

@DriftAccessor(
  tables: [
    ProductCategories,
    Publishers,
    PurchaseSaleModes,
    Suppliers,
    Warehouses,
  ],
)
class MasterDataLookupDao extends DatabaseAccessor<AppDatabase>
    with _$MasterDataLookupDaoMixin {
  MasterDataLookupDao(super.db);

  Future<List<MasterDataOption>> getActiveCategories() async {
    final rows =
        await (select(productCategories)
              ..where((tbl) => tbl.status.equals(1))
              ..orderBy([
                (tbl) => OrderingTerm.asc(tbl.sortOrder),
                (tbl) => OrderingTerm.asc(tbl.name),
              ]))
            .get();

    return rows
        .map(
          (row) => MasterDataOption(
            id: row.id,
            code: row.code,
            name: row.name,
            status: row.status,
          ),
        )
        .toList(growable: false);
  }

  Future<List<MasterDataOption>> getActivePublishers() async {
    final rows =
        await (select(publishers)
              ..where((tbl) => tbl.status.equals(1))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
            .get();

    return rows
        .map(
          (row) => MasterDataOption(
            id: row.id,
            code: row.code ?? row.name,
            name: row.name,
            status: row.status,
          ),
        )
        .toList(growable: false);
  }

  Future<List<MasterDataOption>> getActivePurchaseSaleModes() async {
    final rows =
        await (select(purchaseSaleModes)
              ..where((tbl) => tbl.status.equals(1))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
            .get();

    return rows
        .map(
          (row) => MasterDataOption(
            id: row.id,
            code: row.code,
            name: row.name,
            status: row.status,
          ),
        )
        .toList(growable: false);
  }

  Future<List<MasterDataOption>> getActiveSuppliers() async {
    final rows =
        await (select(suppliers)
              ..where((tbl) => tbl.status.equals(1))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
            .get();

    return rows
        .map(
          (row) => MasterDataOption(
            id: row.id,
            code: row.code,
            name: row.name,
            status: row.status,
          ),
        )
        .toList(growable: false);
  }

  Future<List<MasterDataOption>> getActiveWarehouses() async {
    final rows =
        await (select(warehouses)
              ..where((tbl) => tbl.status.equals(1))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
            .get();

    return rows
        .map(
          (row) => MasterDataOption(
            id: row.id,
            code: row.code,
            name: row.name,
            status: row.status,
          ),
        )
        .toList(growable: false);
  }
}
