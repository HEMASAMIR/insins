import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  // يفضل دائماً تحديد النوع بدلاً من dynamic لتجنب الأخطاء مستقبلاً
  final dynamic product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // التعديل الجوهري هنا: الوصول للقيم عبر الخاصية مباشرة
    // تأكد أن أسماء المتغيرات (imageUrl, nameAr) هي نفس الأسماء الموجودة داخل ProductDetailsModel
    String imageUrl = product.imageUrl ?? '';
    String title = product.nameAr ?? 'بدون عنوان';
    String category = product.categoryName ?? '';

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
          // 1. مساحة الصورة
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: 380.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 380.h,
                    color: Colors.grey[100],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
                // التصنيف العلوي
                Positioned(
                  top: 20.h,
                  right: 20.w,
                  child: Text(
                    category,
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

          // 2. منطقة البيانات
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Cairo',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.h),

                // الأسطر الثابتة
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
