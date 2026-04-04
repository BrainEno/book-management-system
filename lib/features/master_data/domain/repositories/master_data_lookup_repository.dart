import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/master_data/domain/entities/master_data_option.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MasterDataLookupRepository {
  Future<Either<Failure, List<MasterDataOption>>> getCategories();
  Future<Either<Failure, List<MasterDataOption>>> getPublishers();
  Future<Either<Failure, List<MasterDataOption>>> getPurchaseSaleModes();
  Future<Either<Failure, List<MasterDataOption>>> getSuppliers();
  Future<Either<Failure, List<MasterDataOption>>> getWarehouses();
}
