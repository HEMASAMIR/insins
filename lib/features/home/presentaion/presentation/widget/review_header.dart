import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewHeader extends StatelessWidget {
  final double averageRating;
  final int reviewsCount;

  const ReviewHeader({
    super.key,
    required this.averageRating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          const Icon(Icons.star, color: Colors.amber, size: 18),
          Text(
            " $averageRating ($reviewsCount)",
            style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
          ),
        ]),
        Text(
          "آراء العملاء",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
