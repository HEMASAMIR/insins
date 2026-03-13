import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/presentaion/widget/details_bottom_actions.dart';
import 'package:insins/features/home/presentaion/widget/details_header.dart';
import 'package:insins/features/home/presentaion/widget/details_product_image.dart';
import 'package:insins/features/home/presentaion/widget/details_product_info.dart';
import 'package:insins/features/home/presentaion/widget/details_reviews_section.dart';
import '../../data/home_model/product_details_model.dart';

class DetailsProductCard extends StatelessWidget {
  final ProductDetailsModel product;
  final VoidCallback onBack;
  final Function(ProductDetailsModel) onTap;

  const DetailsProductCard({
    super.key,
    required this.product,
    required this.onBack,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          DetailsHeader(onBack: onBack),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  DetailsProductImage(imageUrl: product.imageUrl ?? ""),
                  DetailsProductInfo(
                    name: product.nameAr,
                    price: product.price.toString(),
                    description: product.descriptionAr,
                  ),
                  const DetailsReviewsSection(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          DetailsBottomActions(
            onAddToCart: () => onTap(product),
            onWhatsApp: () {
              // أكشن الواتساب هنا
            },
          ),
        ],
      ),
    );
  }
}
