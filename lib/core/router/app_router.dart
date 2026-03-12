import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insins/core/di/injection.dart';
import 'package:insins/core/router/routes.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_cubit.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_cubit.dart'; // ✅ ضفنا ده
import 'package:insins/features/home/presentaion/view/home.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.homeScreen,
    routes: [
      // ── Home ─────────────────────────────────────
      GoRoute(
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<ProductsCubit>()..fetchProducts(),
            ),
            BlocProvider(
              create: (_) => sl<CategorieCubit>()..fetchCategories(),
            ),
            // ✅ هنا بنجهز الـ Cubit بس من غير ما ننادي دالة الـ get عشان لسه مش معانا ID
            BlocProvider(
              create: (_) => sl<ProductDetailsCubit>(),
            ),
          ],
          child: const LuxuryHomePage(),
        ),
      ),
    ],
  );
}
