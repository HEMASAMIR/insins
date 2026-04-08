import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewEmptyState extends StatelessWidget {
  final int reviewsCount;

  const ReviewEmptyState({
    super.key,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    if (reviewsCount > 0)
      return const SizedBox.shrink(); // ✅ لو في تقييمات متظهرش

    return Center(
      child: Column(
        children: [
          Icon(Icons.chat_bubble_outline, color: Colors.grey[300], size: 40),
          SizedBox(height: 10.h),
          Text("لا توجد تقييمات بعد",
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold)),
          Text("كن أول من يشاركنا رأيه في هذا المنتج المميز",
              style: TextStyle(
                  fontFamily: 'Cairo', fontSize: 12.sp, color: Colors.grey)),
        ],
      ),
    );
  }
}
