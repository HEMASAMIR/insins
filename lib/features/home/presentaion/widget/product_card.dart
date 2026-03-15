import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final dynamic product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
          // 1. مساحة الصورة - واخدة الـ Border العلوي بس
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
            child: Stack(
              children: [
                Image.network(
                  product.imageUrl ?? '',
                  height: 380.h, // ارتفاع طولي زي الصورة بالظبط
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 380.h,
                    color: Colors.grey[100],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
                // الكلمة الصغيرة اللي فوق ع اليمين (متغيرة حسب القسم)
                Positioned(
                  top: 20.h,
                  right: 20.w,
                  child: Text(
                    product.categoryName ?? '',
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

          // 2. منطقة البيانات (تحت الصورة مباشرة)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            child: Column(
              children: [
                // العنوان اللي أنت أكدت عليه (image_504d65.png)
                Text(
                  product.nameAr ??
                      '', // بيجيب "عطور رجالية" أو غيره من الـ API
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900, // Bold جداً زي الصورة
                    fontFamily: 'Cairo',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.h),

                // السطرين الثابتين اللي طلبتهم بالظبط
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

                // زرار تسوق الآن (أسود بيضاوي)
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
