import 'package:flutter/material.dart';
import 'package:insins/core/widgets/custom_app_bar.dart';
import 'package:insins/core/widgets/custom_drawer.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/presentaion/view/estekshaf_catregory.dart';
import 'package:insins/features/home/presentaion/view/prodcut_details.dart';
import 'package:insins/features/home/presentaion/widget/build_home.dart';
import 'package:insins/features/home/presentaion/widget/build_shop.dart';
import 'package:insins/features/home/presentaion/widget/custom_contact_button.dart';

class LuxuryHomePage extends StatefulWidget {
  const LuxuryHomePage({super.key});

  @override
  State<LuxuryHomePage> createState() => _LuxuryHomePageState();
}

class _LuxuryHomePageState extends State<LuxuryHomePage> {
  int _currentIndex = 0;
  CategoryModel? _selectedCategory;
  dynamic _selectedProduct;

  // العودة للرئيسية وتصفير كل الحالات
  void _goToHome() => setState(() {
        _currentIndex = 0;
        _selectedCategory = null;
        _selectedProduct = null;
      });

  // الانتقال للمتجر العام
  void _goToShop() => setState(() {
        _currentIndex = 1;
        _selectedCategory = null;
        _selectedProduct = null;
      });

  // الانتقال لمنتجات قسم معين
  void _onCategorySelected(CategoryModel category) {
    setState(() {
      _selectedCategory = category;
      _currentIndex = 2;
      _selectedProduct = null; // عشان لو كان فيه منتج مفتوح قبل كدة
    });
  }

  // الانتقال لتفاصيل منتج محدد ✅
  void _onProductSelected(dynamic product) {
    setState(() {
      _selectedProduct = product;
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
        // الـ AppBar هيفضل منور في صفحة المتجر أو الأقسام أو التفاصيل
        currentIndex: _currentIndex >= 1 ? 1 : _currentIndex,
      ),
      endDrawer: CustomDrawer(
        onClose: () => Navigator.of(context).pop(),
        onHomeTap: _goToHome,
        onShopTap: _goToShop,
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              // 0: الصفحة الرئيسية
              HomeContentWidget(onCategorySelected: _onCategorySelected),

              // 1: المتجر العام
              const ShopContentWidget(),

              // 2: تفاصيل المجموعة (قائمة منتجات القسم)
              _selectedCategory == null
                  ? const SizedBox()
                  : CategoryDetailsPage(
                      category: _selectedCategory!,
                      onProductTap: _onProductSelected, // ✅ ربطنا الدالة هنا
                    ),

              // 3: تفاصيل المنتج المختار
              _selectedProduct == null
                  ? const SizedBox()
                  : ProductDetailsView(
                      product: _selectedProduct!,
                      onTap: (p1) {
                        setState(() {
                          _selectedProduct = null;
                          _currentIndex = 3;
                        });
                      },
                    ),
            ],
          ),

          // أزرار التواصل الثابتة
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
