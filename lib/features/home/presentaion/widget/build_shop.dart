import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/animation/scroll_reveal.dart';
import 'package:insins/features/home/data/cart_model/cart_model.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_state.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/custom_product_list.dart';
import 'package:insins/features/home/presentaion/widget/shop_header.dart';

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
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) {
        if (current is ProductsLoading && previous is ProductsLoaded) {
          return false;
        }
        return true;
      },
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

                SizedBox(height: 8.h),

                // ─── Loading ────────────────────────────────────────
                if (state is ProductsLoading)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 100.h),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    ),
                  ),

                // ─── Error ──────────────────────────────────────────
                if (state is ProductsError)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
                    child: Center(
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14.sp,
                          color: Colors.red[400],
                        ),
                      ),
                    ),
                  ),

                // ─── Loaded ─────────────────────────────────────────
                if (state is ProductsLoaded) ...[
                  // هيدر القسم والعدد
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${state.products.length} منتج",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey[500],
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          state.selectedCategoryName,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0xFF4A1D1D),
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Divider(color: Colors.grey[200], thickness: 1),
                  ),

                  SizedBox(height: 4.h),

                  // ─── Empty State ─────────────────────────────────
                  if (state.products.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.w, vertical: 60.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 90.w,
                            height: 90.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F0EC),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 42.sp,
                              color: const Color(0xFF4A1D1D),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'لا توجد منتجات في هذا القسم',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4A1D1D),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'جرّب اختيار قسم آخر أو تصفح جميع المنتجات',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13.sp,
                              color: Colors.grey[500],
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // ─── Products List ───────────────────────────────
                  if (state.products.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                      itemCount: state.products.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return VerticalProductCard(
                          product: product,
                          onTap: () => onProductSelected(product),
                          onAdd: () => _handleAddToCart(context, product),
                        );
                      },
                    ),

                  SizedBox(height: 16.h),
                ],

                const ScrollReveal(delay: 600, child: FooterWidget()),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleAddToCart(BuildContext context, dynamic product) {
    final cartItem = CartItemModel(
      id: product.id?.toString() ?? DateTime.now().toString(),
      name: product.nameAr ?? 'منتج بدون اسم',
      price: (product.price ?? 0).toDouble(),
      image: product.imageUrl ?? '',
      quantity: 1,
    );

    context.read<CartCubit>().addToCart(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'تمت إضافة ${product.nameAr} للسلة بنجاح',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2DBB54),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
