import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidgets {
  static Widget buildStaticHeader(String title, {VoidCallback? onHomeTap}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
      ),
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
              _buildBadge('المتجر', isActive: true, onTap: null),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text('/',
                    style: TextStyle(color: Colors.white30, fontSize: 16.sp)),
              ),
              _buildBadge('الرئيسية', isActive: false, onTap: onHomeTap),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildBadge(String text,
      {required bool isActive, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: isActive ? Border.all(color: Colors.white24) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white54,
            fontSize: 12.sp,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }

  static Widget buildEmptyState({bool isError = false}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isError ? Icons.wifi_off_rounded : Icons.inventory_2_outlined,
            size: 70.sp,
            color: Colors.grey[300],
          ),
          SizedBox(height: 15.h),
          Text(
            isError ? 'حدث خطأ في الاتصال' : 'عذراً، لم نجد نتائج',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo',
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
