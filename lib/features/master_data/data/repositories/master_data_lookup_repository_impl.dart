import 'package:bookstore_management_system/core/error/exceptions.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/master_data/data/datasources/local/master_data_lookup_local_datasource.dart';
import 'package:bookstore_management_system/features/master_data/domain/entities/master_data_option.dart';
import 'package:bookstore_management_system/features/master_data/domain/repositories/master_data_lookup_repository.dart';
import 'package:fpdart/fpdart.dart';

class MasterDataLookupRepositoryImpl implements MasterDataLookupRepository {
  const MasterDataLookupRepositoryImpl(this._localDataSource);

  final MasterDataLookupLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<MasterDataOption>>> getCategories() async {
    try {
      return Right(await _localDataSource.getCategories());
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<MasterDataOption>>> getPublishers() async {
    try {
      return Right(await _localDataSource.getPublishers());
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<MasterDataOption>>> getPurchaseSaleModes() async {
    try {
      return Right(await _localDataSource.getPurchaseSaleModes());
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<MasterDataOption>>> getSuppliers() async {
    try {
      return Right(await _localDataSource.getSuppliers());
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<MasterDataOption>>> getWarehouses() async {
    try {
      return Right(await _localDataSource.getWarehouses());
    } on ServerException catch (error) {
      return Left(Failure(error.message));
    }
  }
}
