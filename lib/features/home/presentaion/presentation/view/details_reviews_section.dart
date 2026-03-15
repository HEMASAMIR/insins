import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/presentaion/presentation/widget/add_review_form.dart';
import 'package:insins/features/home/presentaion/presentation/widget/review_empty_state.dart';
import 'package:insins/features/home/presentaion/presentation/widget/review_header.dart';

class DetailsReviewsSection extends StatelessWidget {
  final int productId;
  final double averageRating;
  final int reviewsCount;

  const DetailsReviewsSection({
    super.key,
    required this.productId,
    required this.averageRating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ReviewHeader(
            averageRating: averageRating,
            reviewsCount: reviewsCount,
          ),
          Divider(height: 30.h),
          ReviewEmptyState(reviewsCount: reviewsCount),
          SizedBox(height: 30.h),
          AddReviewForm(productId: productId),
        ],
      ),
    );
  }
}
