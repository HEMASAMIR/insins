import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/animation/scroll_reveal.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:insins/core/widgets/cart_dialog.dart';
import 'package:insins/features/home/data/cart_model/cart_model.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_state.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/custom_product_card.dart';
import 'package:insins/features/home/presentaion/widget/custom_row.dart';
import 'package:insins/features/home/presentaion/widget/kalam_omala.dart';
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
      builder: (context, state) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
            ),
          ),
          child: SingleChildScrollView(
            key: const PageStorageKey('shop'),
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
            ),
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight + 40.h),
                ShopHeaderWidget(
                  onHomeTap: onHomeTap,
                  onShopTap: null,
                ),
                if (state is ProductsLoading)
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (state is ProductsError)
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    ),
                  ),
                if (state is ProductsLoaded) ...[
                  ShopCountBar(totalCount: state.products.length),
                  ListView.builder(
                    // ✅ بدل Column + map
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final p = state.products[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: GestureDetector(
                          onTap: () => onProductSelected(p),
                          child: ProductCardWidget(
                            imageUrl: p.imageUrl!,
                            category: p.categoryName!,
                            name: p.nameAr,
                            price: p.price,
                            onTap: () => onProductSelected(p),
                            onAddToCart: () async {
                              context.read<CartCubit>().addToCart(
                                    CartItemModel(
                                      id: p.id.toString(),
                                      name: p.nameAr,
                                      price: p.price.toDouble(),
                                      image: p.imageUrl ?? '',
                                    ),
                                  );
                              if (context.mounted) {
                                await CartDialogs.showAddedToCart(
                                  context,
                                  productName: p.nameAr,
                                  price: p.price.toDouble(),
                                  onContinueShopping: () {},
                                  onGoToCart: () => onGoToCart?.call(),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
                const ScrollReveal(
                  delay: 600,
                  child: TestimonialsSection(goldColor: AppColors.gold),
                ),
                const ScrollReveal(delay: 800, child: FooterWidget()),
              ],
            ),
          ),
        );
      },
    );
  }
}
