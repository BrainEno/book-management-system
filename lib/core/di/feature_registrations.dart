import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/database/database.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/features/auth/core/error/auth_exceptions.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:bookstore_management_system/features/auth/data/datasources/local/user_dao.dart';
import 'package:bookstore_management_system/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookstore_management_system/features/auth/domain/repository/auth_repository.dart';
import 'package:bookstore_management_system/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:bookstore_management_system/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_dao.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_local_datasource.dart';
import 'package:bookstore_management_system/features/inventory/data/datasources/local/inventory_local_datasource_impl.dart';
import 'package:bookstore_management_system/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:bookstore_management_system/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:bookstore_management_system/features/master_data/data/datasources/local/master_data_lookup_dao.dart';
import 'package:bookstore_management_system/features/master_data/data/datasources/local/master_data_lookup_local_datasource.dart';
import 'package:bookstore_management_system/features/master_data/data/datasources/local/master_data_lookup_local_datasource_impl.dart';
import 'package:bookstore_management_system/features/master_data/data/repositories/master_data_lookup_repository_impl.dart';
import 'package:bookstore_management_system/features/master_data/domain/repositories/master_data_lookup_repository.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_dao.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_local_datasource.dart';
import 'package:bookstore_management_system/features/product/data/datasources/local/product_local_datasource_impl.dart';
import 'package:bookstore_management_system/features/product/data/repositories/product_repository_impl.dart';
import 'package:bookstore_management_system/features/product/domain/repositories/product_repository.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/add_product_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/delete_product_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/get_all_products_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/search_product_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/update_product_usecase.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/purchase/data/datasources/local/purchase_dao.dart';
import 'package:bookstore_management_system/features/purchase/data/datasources/local/purchase_local_datasource.dart';
import 'package:bookstore_management_system/features/purchase/data/datasources/local/purchase_local_datasource_impl.dart';
import 'package:bookstore_management_system/features/purchase/data/repositories/purchase_repository_impl.dart';
import 'package:bookstore_management_system/features/purchase/domain/repositories/purchase_repository.dart';
import 'package:hive/hive.dart';

void registerFeatureDependencies() {
  _registerAuthDependencies();
  _registerMasterDataDependencies();
  _registerProductDependencies();
  _registerInventoryDependencies();
  _registerPurchaseDependencies();
}

Future<void> seedDefaultAdminUser(String defaultPassword) async {
  try {
    final authDataSource = sl<AuthLocalDataSource>();

    await authDataSource.createUser(
      username: 'admin',
      password: defaultPassword,
      role: 'admin',
    );
  } on AuthException catch (error) {
    AppLogger.logger.i('WARN: Creating user: ${error.message}');
  } catch (error) {
    AppLogger.logger.e('Error: initializing database: $error');
  }
}

void _registerAuthDependencies() {
  sl
    ..registerFactory(() => UserDao(sl<AppDatabase>()))
    ..registerFactory<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<AppDatabase>(), sl<Box<String>>()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthLocalDataSource>()),
    )
    ..registerFactory(() => LoginUsecase(sl<AuthRepository>()))
    ..registerFactory(() => GetCurrentUserUseCase(sl<AuthRepository>()))
    ..registerLazySingleton(
      () => AuthBloc(sl<LoginUsecase>(), sl<GetCurrentUserUseCase>()),
    );
}

void _registerProductDependencies() {
  sl
    ..registerFactory(() => ProductDao(sl<AppDatabase>()))
    ..registerFactory<ProductLocalDataSource>(
      () => BookLocalDataSourceImpl(sl<AppDatabase>()),
    )
    ..registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductLocalDataSource>()),
    )
    ..registerFactory(() => AddProductUsecase(sl<ProductRepository>()))
    ..registerFactory(() => UpdateProductUsecase(sl<ProductRepository>()))
    ..registerFactory(() => GetAllProductsUsecase(sl<ProductRepository>()))
    ..registerFactory(() => DeleteProductUsecase(sl<ProductRepository>()))
    ..registerFactory(() => SearchProductUsecase(sl<ProductRepository>()))
    ..registerLazySingleton(
      () => ProductBloc(
        addProductUsecase: sl<AddProductUsecase>(),
        updateProductUsecase: sl<UpdateProductUsecase>(),
        deleteProductUsecase: sl<DeleteProductUsecase>(),
        getAllProductsUsecase: sl<GetAllProductsUsecase>(),
      ),
    );
}

void _registerMasterDataDependencies() {
  sl
    ..registerFactory(() => MasterDataLookupDao(sl<AppDatabase>()))
    ..registerFactory<MasterDataLookupLocalDataSource>(
      () => MasterDataLookupLocalDataSourceImpl(sl<MasterDataLookupDao>()),
    )
    ..registerFactory<MasterDataLookupRepository>(
      () => MasterDataLookupRepositoryImpl(
        sl<MasterDataLookupLocalDataSource>(),
      ),
    );
}

void _registerInventoryDependencies() {
  sl
    ..registerFactory(() => InventoryDao(sl<AppDatabase>()))
    ..registerFactory<InventoryLocalDataSource>(
      () => InventoryLocalDataSourceImpl(
        sl<AppDatabase>(),
        sl<InventoryDao>(),
      ),
    )
    ..registerFactory<InventoryRepository>(
      () => InventoryRepositoryImpl(sl<InventoryLocalDataSource>()),
    );
}

void _registerPurchaseDependencies() {
  sl
    ..registerFactory(() => PurchaseDao(sl<AppDatabase>()))
    ..registerFactory<PurchaseLocalDataSource>(
      () => PurchaseLocalDataSourceImpl(
        sl<AppDatabase>(),
        sl<PurchaseDao>(),
        sl<InventoryDao>(),
      ),
    )
    ..registerFactory<PurchaseRepository>(
      () => PurchaseRepositoryImpl(sl<PurchaseLocalDataSource>()),
    );
}
