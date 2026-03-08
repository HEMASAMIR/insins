import 'package:get_it/get_it.dart';

import '../network/api_client.dart';

final sl = GetIt.instance;

Future<void> setupDI() async {
  // ── Network ──────────────────────────────────────────────
  sl.registerLazySingleton(() => ApiClient.instance);

  // ── Repositories ─────────────────────────────────────────
  // sl.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl(sl()));
  // sl.registerLazySingleton<ShopRepoImpl>(() => ShopRepoImpl(sl()));
  // sl.registerLazySingleton<CartRepoImpl>(() => CartRepoImpl());
  // sl.registerLazySingleton<ProductDetailsRepoImpl>(
  //   () => ProductDetailsRepoImpl(sl()),
  // );

  // ── Cubits ───────────────────────────────────────────────
  // sl.registerFactory(() => HomeCubit(sl()));
  // sl.registerFactory(() => ShopCubit(sl()));
  // sl.registerLazySingleton(() => CartCubit(sl()));
  // sl.registerFactory(() => ProductDetailsCubit(sl()));
}
