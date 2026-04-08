import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/constants/app_constants.dart';

class ProductCardWidget extends StatelessWidget {
  final dynamic product; // نمرر الموديل بالكامل لسهولة الaوصول للبيانات
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // 1. منطق إصلاح الرابط وتنظيفه من أي مشاكل (عشان الـ Host Error)
    String imagePath = product.imageUrl ?? '';
    if (imagePath.startsWith('/')) {
      imagePath = imagePath.substring(1);
    }

    // دمج الـ Base URL مع المسار المنظف
    final String fullImageUrl = "${AppConstants.baseUrl}/$imagePath";

    return Container(
      margin: EdgeInsets.only(bottom: 30.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── منطقة الصورة (قابلة للضغط) ──
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: fullImageUrl,
                    height: 380.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 380.h,
                      color: const Color(0xFFF5F0EB),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 380.h,
                      color: Colors.grey[100],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                  // تصنيف القسم فوق الصورة
                  Positioned(
                    top: 20.h,
                    right: 20.w,
                    child: Text(
                      product.nameAr ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── منطقة البيانات ──
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            child: Column(
              children: [
                // اسم المنتج
                Text(
                  product.nameAr ?? 'بدون عنوان',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Cairo',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.h),

                // الأسطر الثابتة (العود الطبيعي / المحسن)
                Text(
                  'العود الطبيعي',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[500],
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'العود المحسن',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[500],
                    fontFamily: 'Cairo',
                  ),
                ),

                SizedBox(height: 30.h),

                // زرار تسوق الآن
                SizedBox(
                  width: 190.w,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF111111),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.r),
                      ),
                    ),
                    child: Text(
                      'تسوق الآن',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
