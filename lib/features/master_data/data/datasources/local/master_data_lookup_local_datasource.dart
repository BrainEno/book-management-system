import 'package:bookstore_management_system/features/master_data/domain/entities/master_data_option.dart';

abstract interface class MasterDataLookupLocalDataSource {
  Future<List<MasterDataOption>> getCategories();
  Future<List<MasterDataOption>> getPublishers();
  Future<List<MasterDataOption>> getPurchaseSaleModes();
  Future<List<MasterDataOption>> getSuppliers();
  Future<List<MasterDataOption>> getWarehouses();
}
