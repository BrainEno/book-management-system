// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_data_lookup_dao.dart';

// ignore_for_file: type=lint
mixin _$MasterDataLookupDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductCategoriesTable get productCategories =>
      attachedDatabase.productCategories;
  $PublishersTable get publishers => attachedDatabase.publishers;
  $PurchaseSaleModesTable get purchaseSaleModes =>
      attachedDatabase.purchaseSaleModes;
  $SuppliersTable get suppliers => attachedDatabase.suppliers;
  $UsersTable get users => attachedDatabase.users;
  $WarehousesTable get warehouses => attachedDatabase.warehouses;
  MasterDataLookupDaoManager get managers => MasterDataLookupDaoManager(this);
}

class MasterDataLookupDaoManager {
  final _$MasterDataLookupDaoMixin _db;
  MasterDataLookupDaoManager(this._db);
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
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db.attachedDatabase, _db.suppliers);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$WarehousesTableTableManager get warehouses =>
      $$WarehousesTableTableManager(_db.attachedDatabase, _db.warehouses);
}
