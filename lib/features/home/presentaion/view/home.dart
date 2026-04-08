import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/core/di/injection.dart';
import 'package:insins/core/widgets/custom_app_bar.dart';
import 'package:insins/core/widgets/custom_drawer.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_cubit.dart';
import 'package:insins/features/home/presentaion/add_review/logic/add_review_cubit/addreview_cubit.dart';
import 'package:insins/features/home/presentaion/view/cart_screen.dart';
import 'package:insins/features/home/presentaion/view/estekshaf_catregory.dart';
import 'package:insins/features/home/presentaion/widget/build_home.dart';
import 'package:insins/features/home/presentaion/widget/build_shop.dart';
import 'package:insins/features/home/presentaion/widget/custom_contact_button.dart';
import 'package:insins/features/home/presentaion/widget/details_product_card.dart';

class LuxuryHomePage extends StatefulWidget {
  const LuxuryHomePage({super.key});

  @override
  State<LuxuryHomePage> createState() => _LuxuryHomePageState();
}

class _LuxuryHomePageState extends State<LuxuryHomePage> {
  int _currentIndex = 0;

  // ✅ تم التغيير لـ dynamic لدعم CategoryModel أو SubCategoryModel
  dynamic _selectedCategory;
  dynamic _lastCategory;

  ProductDetailsModel? _selectedProduct;
  ProductDetailsModel? _lastProduct;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutSectionKey = GlobalKey();

  /// العودة للرئيسية مع عمل Scroll لفوق
  void _goToHome() {
    setState(() {
      _currentIndex = 0;
      _selectedCategory = null;
      _selectedProduct = null;
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  /// الانتقال لقسم "من نحن" في الصفحة الرئيسية
  void _scrollToAbout() {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
        _selectedCategory = null;
        _selectedProduct = null;
      });
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      final context = _aboutSectionKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
          alignment: 0.1,
        );
      }
    });
  }

  void _goToShop() => setState(() {
        _currentIndex = 1;
        _selectedCategory = null;
        _selectedProduct = null;
      });

  void _goToCart() => setState(() => _currentIndex = 4);

  /// دالة اختيار القسم (الرئيسي أو الفرعي من القائمة المنسدلة)
  void _onCategorySelected(dynamic category) {
    setState(() {
      _selectedCategory = category;
      _lastCategory = category; // حفظ النسخة للـ IndexedStack
      _currentIndex = 2;
    });
  }

  void _onProductSelected(dynamic product) {
    setState(() {
      _selectedProduct = ProductDetailsModel.fromProductModel(product);
      _lastProduct = _selectedProduct;
      _currentIndex = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      // ── AppBar ─────────────────────────────────────
      appBar: CustomAppBar(
        onHomeTap: _goToHome,
        onShopTap: _goToShop,
        onAboutTap: _scrollToAbout,
        onCartTap: _goToCart,
        currentIndex: _currentIndex >= 1 ? 1 : _currentIndex,
      ),
      // ── Drawer ─────────────────────────────────────
      endDrawer: CustomDrawer(
        onClose: () => Navigator.of(context).pop(),
        onHomeTap: _goToHome,
        onShopTap: _goToShop,
        onAboutTap: _scrollToAbout,
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              // 0: الرئيسية (Home)
              HomeContentWidget(
                onCategorySelected: _onCategorySelected,
                scrollController: _scrollController,
                aboutKey: _aboutSectionKey,
                onShopTap: _goToShop,
              ),

              // 1: المتجر (Shop)
              ShopContentWidget(
                onProductSelected: _onProductSelected,
                onGoToCart: _goToCart,
                onHomeTap: _goToHome,
              ),

              // 2: تفاصيل التصنيف (Category Details)
              _lastCategory == null
                  ? const SizedBox()
                  : BlocProvider.value(
                      value: sl<ProductDetailsCubit>(),
                      child: CategoryDetailsPage(
                        category: _lastCategory!,
                        onProductTap: _onProductSelected,
                        onBack: () => setState(() {
                          _currentIndex = 1;
                          _selectedCategory = null;
                        }),
                      ),
                    ),

              // 3: تفاصيل المنتج (Product Details)
              _lastProduct == null
                  ? const SizedBox()
                  : MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: sl<AddReviewCubit>()),
                        BlocProvider.value(value: sl<ProductDetailsCubit>()),
                        BlocProvider.value(value: sl<CartCubit>()),
                      ],
                      child: DetailsProductCard(
                        product: _lastProduct!,
                        onTap: (product) {},
                        onBack: () {
                          setState(() {
                            // العودة لصفحة التصنيف لو كانت مفتوحة، وإلا للمتجر
                            _currentIndex = _lastCategory == null ? 1 : 2;
                            _selectedProduct = null;
                          });
                        },
                        onGoToShop: _goToShop,
                        onGoToCart: _goToCart,
                      ),
                    ),

              // 4: سلة المشتريات (Cart)
              CartScreen(
                onBackToShop: _goToShop,
              ),
            ],
          ),
          // زر التواصل السريع
          const Positioned(
            bottom: 20,
            right: 20,
            child: QuickContactButtons(),
          ),
        ],
      ),
    );
  }
}
