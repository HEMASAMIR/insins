import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeroSection extends StatelessWidget {
  final Color goldColor;

  const HeroSection({super.key, required this.goldColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      // تحديد ارتفاع السكشن (مثلاً 80% من ارتفاع الشاشة)
      height: 0.8.sh,
      width: double.infinity,
      decoration: const BoxDecoration(
        // وضع صورة الخلفية الفاخرة
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc', // رابط الصورة
          ),
          fit: BoxFit.cover,
        ),
      ),
      // طبقة فوق الصورة لجعل النص واضحاً (Overlay)
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        color: Colors.black.withOpacity(0.5), // تعتيم الخلفية بنسبة 50%
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // العنوان الرئيسي الكبير
            Text(
              "عنوان الفخامة والتميّز",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.w900,
                fontFamily: 'Cairo', // تأكد من إضافة الخط في pubspec
              ),
            ),

            SizedBox(height: 15.h),

            // الوصف الفرعي
            Text(
              "أرقى أنواع العطور والبخور ومنتجات التجميل المستوحاة من أصالة التراث العربي.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16.sp,
                fontFamily: 'Cairo',
              ),
            ),

            SizedBox(height: 35.h),

            // أزرار الأكشن
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // زر "تسوق العطور" الذهبي
                _actionButton("تسوق العطور", goldColor, true),

                SizedBox(width: 10.w),

                // زر "اكتشف العود" الشفاف بحدود بيضاء
                _actionButton("اكتشف العود", Colors.transparent, false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ميثود مساعدة لبناء الأزرار داخل الويدجت
  Widget _actionButton(String label, Color color, bool filled) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: filled
            ? color
            : Colors.transparent, // اللون الخلفي إذا كان ممتلئاً
        borderRadius: BorderRadius.circular(
          50.r,
        ), // زوايا منحنية بالكامل (Stadium)
        border: Border.all(color: filled ? color : Colors.white), // الحدود
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
