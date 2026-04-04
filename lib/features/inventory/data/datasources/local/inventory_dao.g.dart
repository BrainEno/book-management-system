// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_dao.dart';

// ignore_for_file: type=lint
mixin _$InventoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $WarehousesTable get warehouses => attachedDatabase.warehouses;
  $ProductCategoriesTable get productCategories =>
      attachedDatabase.productCategories;
  $PublishersTable get publishers => attachedDatabase.publishers;
  $PurchaseSaleModesTable get purchaseSaleModes =>
      attachedDatabase.purchaseSaleModes;
  $ProductsTable get products => attachedDatabase.products;
  $StockBalancesTable get stockBalances => attachedDatabase.stockBalances;
  $StockMovementsTable get stockMovements => attachedDatabase.stockMovements;
  InventoryDaoManager get managers => InventoryDaoManager(this);
}

class InventoryDaoManager {
  final _$InventoryDaoMixin _db;
  InventoryDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$WarehousesTableTableManager get warehouses =>
      $$WarehousesTableTableManager(_db.attachedDatabase, _db.warehouses);
  $$ProductCategoriesTableTableManager get productCategories =>
      $$ProductCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.productCategories,
      );
  $$PublishersTableTableManager get publishers =>
      $$PublishersTableTableManager(_db.attachedDatabase, _db.publishers);
  $$PurchaseSaleModesTableTableManager get purchaseSaleModes =>
      $$PurchaseSaleModesTableTableManager(
        _db.attachedDatabase,
        _db.purchaseSaleModes,
      );
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$StockBalancesTableTableManager get stockBalances =>
      $$StockBalancesTableTableManager(_db.attachedDatabase, _db.stockBalances);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(
        _db.attachedDatabase,
        _db.stockMovements,
      );
}
