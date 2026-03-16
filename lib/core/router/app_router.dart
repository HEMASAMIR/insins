import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insins/core/di/injection.dart';
import 'package:insins/core/router/routes.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_cubit.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_cubit.dart';
import 'package:insins/features/home/presentaion/add_review/logic/add_review_cubit/addreview_cubit.dart';
import 'package:insins/features/home/presentaion/view/cart_screen.dart';
import 'package:insins/features/home/presentaion/view/estekshaf_catregory.dart';
import 'package:insins/features/home/presentaion/view/home.dart';
import 'package:insins/features/home/presentaion/view/policy_page.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';
import 'package:insins/features/home/presentaion/widget/details_product_card.dart';
import 'package:insins/features/shipping/logic/shipping_cubit/cubit/shipping_cubit.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.homeScreen,
    routes: [
      GoRoute(
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<ProductsCubit>()..fetchProducts()),
            BlocProvider(
                create: (_) => sl<CategorieCubit>()..fetchCategories()),
            BlocProvider(create: (_) => sl<ProductDetailsCubit>()),
            BlocProvider(create: (_) => sl<CartCubit>()..loadCart()),
          ],
          child: const LuxuryHomePage(),
        ),
      ),
      GoRoute(
        name: AppRoutes.productDetailsScreen,
        path: AppRoutes.productDetailsScreen,
        builder: (context, state) {
          final product = state.extra as ProductDetailsModel;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<AddReviewCubit>()),
              BlocProvider(create: (_) => sl<CartCubit>()..loadCart()),
              BlocProvider(create: (_) => sl<ProductDetailsCubit>()),
              BlocProvider(create: (_) => sl<ShippingCubit>()..fetchCities()),
            ],
            child: DetailsProductCard(
              product: product,
              onBack: () => context.pop(),
              onTap: (p) {},
              onGoToShop: () => context.go(AppRoutes.homeScreen),
              onGoToCart: () => context.go(AppRoutes.cartScreen),
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.policyScreen,
        path: AppRoutes.policyScreen,
        builder: (context, state) {
          final cartCubit = state.extra as CartCubit;
          return BlocProvider.value(
            value: cartCubit,
            child: const PolicyScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.categoryDetails,
        path: AppRoutes.categoryDetails,
        builder: (context, state) {
          final category = state.extra as CategoryModel;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<ProductDetailsCubit>()),
              BlocProvider(create: (_) => sl<CartCubit>()..loadCart()),
            ],
            child: CategoryDetailsPage(
              category: category,
              onProductTap: (p) {},
              onBack: () {},
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.cartScreen,
        path: AppRoutes.cartScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: sl<CartCubit>()),
            // ✅ create مش value عشان يعمل instance جديد ويشغل fetchCities
            BlocProvider(
              create: (_) => sl<ShippingCubit>()..fetchCities(),
            ),
          ],
          child: CartScreen(
            onBackToShop: () => context.go(AppRoutes.homeScreen),
          ),
        ),
      ),
    ],
  );
}
