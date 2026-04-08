import 'package:flutter/material.dart';
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
      // ── الصفحة الرئيسية ──────────────────────────────────────────
      GoRoute(
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: sl<ProductsCubit>()..fetchProducts()),
            BlocProvider.value(value: sl<CategorieCubit>()..fetchCategories()),
            BlocProvider.value(value: sl<CartCubit>()..loadCart()),
          ],
          child: const LuxuryHomePage(),
        ),
      ),

      // ── صفحة تفاصيل المنتج (تم تعديل الـ Providers هنا) ───────────────
      GoRoute(
        name: AppRoutes.productDetailsScreen,
        path: AppRoutes.productDetailsScreen,
        builder: (context, state) {
          final product = state.extra as ProductDetailsModel;
          return MultiBlocProvider(
            providers: [
              // ✅ استخدم .value للـ Cubits الثابتة عشان متقفلش لما ترجع
              BlocProvider.value(value: sl<ProductDetailsCubit>()),
              BlocProvider.value(value: sl<CartCubit>()),
              // factory cubits ممكن نستخدم create عادي
              BlocProvider(create: (_) => sl<AddReviewCubit>()),
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

      // ── صفحة تفاصيل القسم (Category) ─────────────────────────────
      GoRoute(
        name: AppRoutes.categoryDetails,
        path: AppRoutes.categoryDetails,
        builder: (context, state) {
          final category = state.extra as CategoryModel;
          // ✅ استخدمنا .value وجبنا الـ instance من GetIt مباشرة
          // ده بيضمن إن الـ BlocBuilder اللي جوه الصفحة هيشوف دايما النسخة "الحية"
          return BlocProvider.value(
            value: sl<ProductDetailsCubit>(),
            child: CategoryDetailsPage(
              category: category,
              onProductTap: (p) {},
              onBack: () => context.pop(),
            ),
          );
        },
      ),
      // ── صفحة السلة ─────────────────────────────────────────────
      GoRoute(
        name: AppRoutes.cartScreen,
        path: AppRoutes.cartScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: sl<CartCubit>()),
            BlocProvider(create: (_) => sl<ShippingCubit>()..fetchCities()),
          ],
          child: CartScreen(
            onBackToShop: () => context.go(AppRoutes.homeScreen),
          ),
        ),
      ),

      // ── صفحة السياسات ──────────────────────────────────────────
      GoRoute(
        name: AppRoutes.policyScreen,
        path: AppRoutes.policyScreen,
        builder: (context, state) {
          // لو الـ cartCubit مبعوث في الـ extra بنستخدمه، وإلا بنجيبه من sl
          final cartCubit = state.extra is CartCubit
              ? state.extra as CartCubit
              : sl<CartCubit>();
          return BlocProvider.value(
            value: cartCubit,
            child: const PolicyScreen(),
          );
        },
      ),
    ],
  );
}
