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
      // 🔥 السر هنا: لو الحالة "تحميل" بس إحنا معانا داتا قديمة (Loaded)، متخليش الشاشة ترعش وتظهر Loading
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

                if (state is ProductsLoading)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 100.h),
                    child: const Center(
                        child: CircularProgressIndicator(color: Colors.black)),
                  ),

                if (state is ProductsError)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(state.message),
                    ),
                  ),

                // حالة نجاح التحميل
                if (state is ProductsLoaded) ...[
                  // 1. هيدر المنتجات (العدد والعنوان)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${state.products.length} منتج",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "جميع المنتجات",
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Divider(color: Colors.grey[200], thickness: 1),
                  ),

                  // 2. ليستة المنتجات (واحدة فقط ومنظمة)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    itemCount: state.products.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 15.h),
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return VerticalProductCard(
                        product: product,
                        onTap: () => onProductSelected(product),
                        onAdd: () => _handleAddToCart(context, product),
                      );
                    },
                  ),
                ],
                const ScrollReveal(delay: 600, child: FooterWidget()),
              ],
            ),
          ),
        );
      },
    );
  }

  // دالة الإضافة للسلة عشان الكود ميبقاش طويل جوه الـ Builder
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
