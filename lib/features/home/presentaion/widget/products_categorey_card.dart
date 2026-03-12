import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/widgets/custom_badge.dart'; // تأكد من المسار الصح

class CategoryWidgets {
  static Widget buildStaticHeader(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
      color: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'اكتشف عبق الفخامة والأصالة في مكان واحد',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 13.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الاستدعاء الصح للـ Badge اللي أنت بعتها
              const CustomBadge(
                text: 'المتجر',
                isActive: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: const Text(
                  '/',
                  style: TextStyle(color: Colors.white30),
                ),
              ),
              const CustomBadge(
                isActive: false,
                text: 'الرئيسية',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
