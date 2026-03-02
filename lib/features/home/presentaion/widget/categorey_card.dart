import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LuxuryCategoryCard extends StatelessWidget {
  final String title;
  final List<String> details;
  final String img;
  final Color goldColor;
  final Color darkBg;
  final VoidCallback? onTap;

  const LuxuryCategoryCard({
    super.key,
    required this.title,
    required this.details,
    required this.img,
    required this.goldColor,
    required this.darkBg,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border(
          bottom: BorderSide(
            color: goldColor,
            width: 5.h,
          ), // الحد الذهبي السفلي المميز
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // قسم الصورة المنحني من الأعلى
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Image.network(
              img,
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
              // معالجة الخطأ في حال لم تتحمل الصورة
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200.h,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),

          // قسم النصوص والأزرار
          Padding(
            padding: EdgeInsets.all(25.w),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.sp,
                    color: darkBg,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 10.h),

                // قائمة التفاصيل (المنتجات الفرعية)
                Column(
                  children: details
                      .map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Text(
                            item,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13.sp,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

                SizedBox(height: 20.h),

                // زر "تسوق الآن" العريض
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onTap ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBg,
                      foregroundColor: goldColor,
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      elevation: 0,
                    ),
                    child: Text(
                      "تسوق الآن",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
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
