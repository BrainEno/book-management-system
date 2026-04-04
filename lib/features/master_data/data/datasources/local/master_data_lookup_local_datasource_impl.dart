import 'package:bookstore_management_system/features/master_data/data/datasources/local/master_data_lookup_dao.dart';
import 'package:bookstore_management_system/features/master_data/data/datasources/local/master_data_lookup_local_datasource.dart';
import 'package:bookstore_management_system/features/master_data/domain/entities/master_data_option.dart';

class MasterDataLookupLocalDataSourceImpl
    implements MasterDataLookupLocalDataSource {
  const MasterDataLookupLocalDataSourceImpl(this._dao);

  final MasterDataLookupDao _dao;

  @override
  Future<List<MasterDataOption>> getCategories() => _dao.getActiveCategories();

  @override
  Future<List<MasterDataOption>> getPublishers() => _dao.getActivePublishers();

  @override
  Future<List<MasterDataOption>> getPurchaseSaleModes() =>
      _dao.getActivePurchaseSaleModes();

  @override
  Future<List<MasterDataOption>> getSuppliers() => _dao.getActiveSuppliers();

  @override
  Future<List<MasterDataOption>> getWarehouses() => _dao.getActiveWarehouses();
}
