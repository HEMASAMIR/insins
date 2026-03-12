import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:insins/core/networking/dio_client.dart';
import 'package:insins/features/home/data/home_repo/categories_repo/categories_repo.dart';
import 'package:insins/features/home/data/home_repo/categories_repo/categories_repo_impl.dart';
import 'package:insins/features/home/data/home_repo/product_details_repo/product_details_repo.dart';
import 'package:insins/features/home/data/home_repo/product_details_repo/product_details_repo_impl.dart';
import 'package:insins/features/home/data/home_repo/products_repo/home_repo.dart';
import 'package:insins/features/home/data/home_repo/products_repo/home_repo_impl.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_cubit.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_cubit.dart';

final sl = GetIt.instance;

Future<void> setupDI() async {
  // ── Repositories ─────────────────────────────────────
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(DioHelper.dio!),
  );

  sl.registerLazySingleton<CategoriesRepo>(
    () => CategoriesRepoImpl(DioHelper.dio!),
  );
  sl.registerLazySingleton<ProductDetailsRepo>(
    () => ProductDetailsRepoImpl(DioHelper.dio!), // تأكد إن Dio مسجل عندك برضه
  );
  // ── Cubits ───────────────────────────────────────────
  sl.registerLazySingleton(() => ProductsCubit(sl()));
  sl.registerFactory(() => CategorieCubit(sl()));
  sl.registerFactory(() => ProductDetailsCubit(sl()));
}
