import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/widgets/cart_dialog.dart';
import 'package:insins/core/widgets/whatsapp_helper.dart';
import 'package:insins/features/home/data/cart_model/cart_model.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/presentaion/widget/details_bottom_actions.dart';
import 'package:insins/features/home/presentaion/widget/details_product_image.dart';
import 'package:insins/features/home/presentaion/widget/details_product_info.dart';
import 'package:insins/features/home/presentaion/presentation/view/details_reviews_section.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import '../../data/home_model/product_details_model.dart';

class DetailsProductCard extends StatelessWidget {
  final ProductDetailsModel product;
  final VoidCallback onBack;
  final Function(ProductDetailsModel) onTap;
  final VoidCallback onGoToShop;
  final VoidCallback onGoToCart;

  const DetailsProductCard({
    super.key,
    required this.product,
    required this.onBack,
    required this.onTap,
    required this.onGoToShop,
    required this.onGoToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          // 1. شيلنا DetailsHeader خالص عشان زرار الرجوع يختفي تماماً
          SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // 2. عرض الصورة مباشرة
                  DetailsProductImage(imageUrl: product.imageUrl ?? ""),

                  DetailsProductInfo(
                    name: product.nameAr,
                    price: product.price.toString(),
                    description: product.descriptionAr,
                  ),

                  DetailsReviewsSection(
                    productId: product.id,
                    averageRating: product.averageRating,
                    reviewsCount: product.reviewsCount,
                  ),

                  SizedBox(height: 40.h),
                  const FooterWidget(),
                ],
              ),
            ),
          ),

          DetailsBottomActions(
            onAddToCart: () {
              context.read<CartCubit>().addToCart(
                    CartItemModel(
                      id: product.id.toString(),
                      name: product.nameAr,
                      price: product.price,
                      image: product.imageUrl ?? '',
                      quantity: 1,
                    ),
                  );

              CartDialogs.showAddedToCart(
                context,
                productName: product.nameAr,
                price: product.price,
                onContinueShopping: () => onGoToShop(),
                onGoToCart: () async {
                  await Future.delayed(const Duration(milliseconds: 300));
                  onGoToCart();
                },
              );
            },
            onWhatsApp: () => WhatsAppHelper.sendMessage(
              productName: product.nameAr,
              price: product.price,
            ),
          ),
        ],
      ),
    );
  }
}
