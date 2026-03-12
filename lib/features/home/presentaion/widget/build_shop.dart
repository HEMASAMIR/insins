import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/animation/scroll_reveal.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:insins/features/home/logic/cubit/homecubit_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_state.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/custom_product_card.dart';
import 'package:insins/features/home/presentaion/widget/custom_row.dart';
import 'package:insins/features/home/presentaion/widget/kalam_omala.dart';
import 'package:insins/features/home/presentaion/widget/shiping_section.dart';
import 'package:insins/features/home/presentaion/widget/shop_header.dart';

class ShopContentWidget extends StatelessWidget {
  const ShopContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          key: const PageStorageKey('shop'),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight + 40.h),
              const ShopHeaderWidget(),

              // ── Loading ──────────────────────────────
              if (state is ProductsLoading)
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(child: CircularProgressIndicator()),
                ),

              // ── Error ────────────────────────────────
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

              // ── Loaded ───────────────────────────────
              if (state is ProductsLoaded) ...[
                ShopCountBar(totalCount: state.products.length),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    children: state.products
                        .map(
                          (p) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            child: ProductCardWidget(
                              imageUrl: p.imageUrl!,
                              category: p.categoryName!,
                              name: p.nameAr,
                              price: p.price,
                              onAddToCart: () {},
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],

              const ScrollReveal(
                delay: 400,
                child: ShippingSection(
                  goldColor: AppColors.gold,
                  darkBg: AppColors.darkGrey,
                ),
              ),
              const ScrollReveal(
                delay: 600,
                child: TestimonialsSection(goldColor: AppColors.gold),
              ),
              const ScrollReveal(delay: 800, child: FooterWidget()),
            ],
          ),
        );
      },
    );
  }
}
