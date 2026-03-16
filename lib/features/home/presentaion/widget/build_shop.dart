import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/animation/scroll_reveal.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:insins/core/widgets/cart_dialog.dart';
import 'package:insins/features/home/data/cart_model/cart_model.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/custom_product_card.dart';
import 'package:insins/features/home/presentaion/widget/custom_row.dart';
import 'package:insins/features/home/presentaion/widget/shop_header.dart';
import 'package:insins/features/home/presentaion/widget/kalam_omala.dart';

class ShopContentWidget extends StatelessWidget {
  final Function(dynamic) onProductSelected;
  final VoidCallback? onGoToCart;
  final VoidCallback? onHomeTap;

  const ShopContentWidget({
    super.key,
    required this.onProductSelected,
    this.onGoToCart,
    this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategorieCubit, CategorieState>(
      builder: (context, state) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            physics: const BouncingScrollPhysics(),
          ),
          child: SingleChildScrollView(
            key: const PageStorageKey('shop'),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight + 40.h),
                ShopHeaderWidget(
                  onHomeTap: onHomeTap,
                  onShopTap: null,
                ),
                if (state is CategoriesLoading)
                  const Padding(
                    padding: EdgeInsets.all(100),
                    child: Center(
                        child: CircularProgressIndicator(color: Colors.black)),
                  ),
                if (state is CategorriesError)
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(state.message),
                  )),
                if (state is CategoriesLoaded) ...[
                  // دمجنا الفنكشن هنا عشان نضمن إن الـ state هي اللي بتتحكم في الظهور
                  _buildProductsList(context, state),
                ],
                const ScrollReveal(
                  delay: 400,
                  child: TestimonialsSection(goldColor: AppColors.gold),
                ),
                const ScrollReveal(delay: 600, child: FooterWidget()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsList(BuildContext context, CategoriesLoaded state) {
    // ✅ بنحول SubCategoryModel لـ ProductDetailsModel
    final allProducts = state.categories
        .expand((cat) => cat.subCategories)
        .map((sub) => ProductDetailsModel.fromProductModel(sub))
        .toList();

    debugPrint("Total Products Found: ${allProducts.length}");

    if (allProducts.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 100.h),
        child: Column(
          children: [
            Icon(Icons.shopping_bag_outlined, size: 60.sp, color: Colors.grey),
            SizedBox(height: 10.h),
            const Text("لا توجد منتجات متوفرة حالياً"),
          ],
        ),
      );
    }

    return Column(
      children: [
        ShopCountBar(totalCount: allProducts.length),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allProducts.length,
          itemBuilder: (context, index) {
            final p = allProducts[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: ProductCardWidget(
                product: p,
                onTap: () => onProductSelected(p),
                onAddToCart: () async {
                  context.read<CartCubit>().addToCart(
                        CartItemModel(
                          id: p.id.toString(),
                          name: p.nameAr,
                          price: p.price,
                          image: p.imageUrl ?? '',
                        ),
                      );
                  await CartDialogs.showAddedToCart(
                    context,
                    productName: p.nameAr,
                    price: p.price,
                    onContinueShopping: () {},
                    onGoToCart: () => onGoToCart?.call(),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
