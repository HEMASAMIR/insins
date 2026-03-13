import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insins/core/di/injection.dart';
import 'package:insins/core/router/routes.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_cubit.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_cubit.dart';
import 'package:insins/features/home/presentaion/view/home.dart';
import 'package:insins/features/home/presentaion/view/policy_page.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.homeScreen,
    routes: [
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
            BlocProvider(
              create: (_) => sl<ProductDetailsCubit>(),
            ),
            // ✅ CartCubit هنا عشان يكون متاح في كل الـ app
            BlocProvider(
              create: (_) => sl<CartCubit>()..loadCart(),
            ),
          ],
          child: const LuxuryHomePage(),
        ),
      ),
      GoRoute(
        name: AppRoutes.policyScreen,
        path: AppRoutes.policyScreen,
        builder: (context, state) {
          // بناخد الـ Cubit اللي جاي في الـ extra
          final cartCubit = state.extra as CartCubit;
          return BlocProvider.value(
            value: cartCubit,
            child: const PolicyScreen(),
          );
        },
      ),
    ],
  );
}
