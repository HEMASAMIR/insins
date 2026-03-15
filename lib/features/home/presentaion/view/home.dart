import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insins/core/di/injection.dart';
import 'package:insins/core/widgets/custom_app_bar.dart';
import 'package:insins/core/widgets/custom_drawer.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';
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
  CategoryModel? _selectedCategory;
  ProductDetailsModel? _selectedProduct;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutSectionKey = GlobalKey();

  void _goToHome() {
    setState(() {
      _currentIndex = 0;
      _selectedCategory = null;
      _selectedProduct = null;
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    }
  }

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

  void _onCategorySelected(CategoryModel category) {
    setState(() {
      _selectedCategory = category;
      _currentIndex = 2;
    });
  }

  void _onProductSelected(dynamic product) {
    setState(() {
      _selectedProduct = ProductDetailsModel.fromProductModel(product);
      _currentIndex = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        onHomeTap: _goToHome,
        onShopTap: _goToShop,
        onAboutTap: _scrollToAbout,
        onCartTap: _goToCart,
        currentIndex: _currentIndex >= 1 ? 1 : _currentIndex,
      ),
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
              // 0: الرئيسية
              HomeContentWidget(
                onCategorySelected: _onCategorySelected,
                scrollController: _scrollController,
                aboutKey: _aboutSectionKey,
                onShopTap: _goToShop,
              ),

              // 1: المتجر
              ShopContentWidget(
                onProductSelected: _onProductSelected,
                onGoToCart: _goToCart,
                onHomeTap: _goToHome,
              ),

              // 2: تفاصيل التصنيف
              _selectedCategory == null
                  ? const SizedBox()
                  : CategoryDetailsPage(
                      category: _selectedCategory!,
                      onProductTap: _onProductSelected,
                      onBack: () => setState(() {
                        _currentIndex = 1;
                        _selectedCategory = null;
                      }),
                    ),

              // 3: تفاصيل المنتج ✅ بدون SingleChildScrollView
              _selectedProduct == null
                  ? const SizedBox()
                  : BlocProvider(
                      create: (_) => sl<AddReviewCubit>(),
                      child: DetailsProductCard(
                        product: _selectedProduct!,
                        onTap: (product) {},
                        onBack: () {
                          setState(() {
                            _currentIndex = _selectedCategory == null ? 1 : 2;
                          });
                        },
                        onGoToShop: () => _goToShop(),
                        onGoToCart: () => _goToCart(),
                      ),
                    ),

              // 4: سلة المشتريات
              CartScreen(
                onBackToShop: _goToShop,
              ),
            ],
          ),
          const Positioned(bottom: 20, right: 20, child: QuickContactButtons()),
        ],
      ),
    );
  }
}
