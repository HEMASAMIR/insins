import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeaderSection extends StatelessWidget {
  const CustomHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade600,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            "من نحن",
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
