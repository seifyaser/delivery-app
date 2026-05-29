import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:project/features/home/presentation/cubit/location/location_cubit.dart';

import '../network/api_service.dart';
import '../network/dio_factory.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../storage/secure_storage_service.dart';
import '../storage/token_service.dart';

import '../../features/auth/data/datasource/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

import '../../features/categories/data/datasource/categories_remote_data_source.dart';
import '../../features/categories/data/repositories/categories_repository.dart';
import '../../features/categories/presentation/cubit/categories_cubit.dart';

import '../../features/products/data/datasource/products_remote_data_source.dart';
import '../../features/products/data/repositories/products_repository.dart';
import '../../features/products/presentation/cubit/products_cubit.dart';
import '../../features/products/presentation/cubit/product_details_cubit.dart';

import '../../features/cart/data/datasource/cart_remote_data_source.dart';
import '../../features/cart/data/repositories/cart_repository.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';

import '../../features/orders/data/datasource/orders_remote_data_source.dart';
import '../../features/orders/data/repositories/orders_repository.dart';
import '../../features/orders/presentation/cubit/orders_cubit.dart';
import '../../features/orders/presentation/cubit/order_details_cubit.dart';

/// Global service locator instance.
final GetIt getIt = GetIt.instance;

/// Registers all dependencies before [runApp].
///
/// Registration strategy:
///  - Core → singletons
///  - Repositories/Datasources → lazy singletons
///  - Cubits → factory (new instance per screen, owns UI state)
void setupLocator() {
  // ── Core Layer ──────────────────────────────────────────────────────────────
  
  // Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(getIt()),
  );
  getIt.registerLazySingleton<TokenService>(
    () => TokenService(getIt()),
  );

  // Network
  getIt.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(getIt()),
  );
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(DioFactory.createDio(getIt())),
  );

  // ── Data Sources ────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(getIt()),
  );

  // ── Repositories ────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(getIt()),
  );

  // ── Presentation Layer ──────────────────────────────────────────────────────
  // Factory: each screen gets its own cubit instance.
  getIt.registerFactory<LocationCubit>(() => LocationCubit());
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt(), getIt()));
  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit(getIt()));
  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));
  getIt.registerFactory<ProductDetailsCubit>(() => ProductDetailsCubit(getIt()));
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt()));
  getIt.registerFactory<OrdersCubit>(() => OrdersCubit(getIt()));
  getIt.registerFactory<OrderDetailsCubit>(() => OrderDetailsCubit(getIt()));
}
