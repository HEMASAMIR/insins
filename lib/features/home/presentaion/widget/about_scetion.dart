import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      child: Column(
        children: [
          // 1. زر "من نحن" (Rounded Tag)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF9E9E9E), // نفس درجة الرمادي في الصورة
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Text(
              "من نحن",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 25.h),

          // 2. العنوان (Centered with Maroon Color)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                fontFamily: 'Cairo',
                color: Colors.black,
              ),
              children: const [
                TextSpan(text: 'قصة إبداع '),
                TextSpan(
                  text: 'إنسينس',
                  style: TextStyle(
                      color: Color(0xFF8B1A1A)), // اللون المارون المميز
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),

          // 3. النص الوصفي (Centered & Balanced)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              'نحن إنسينس للعطور متخصصين في تقديم أرقى أنواع العطور والبخور ومنتجات التجميل، نسعى لنكون الخيار الأول لعشاق الفخامة والتميّز. نفتخر بجذورنا العربية وبتراثنا العطري الغني، ونحرص على تقديم منتجات تجمع بين الأصالة والجودة العالية، لتلبي أذواق عملائنا داخل المملكة وخارجها.',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                height: 1.8,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          SizedBox(height: 40.h),

          // 4. قسم الصورة مع الـ Shadow Effect (اللي تحتها)
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // الطبقة الرمادية (الخيال اللي تحت يمين)
              Container(
                width: 0.9.sw,
                height: 230.h,
                transform: Matrix4.translationValues(10, 15, 0), // تحريك الظل
                decoration: BoxDecoration(
                  color: const Color(0xFF93908B).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              // كارت الصورة الرئيسي
              Container(
                width: 0.9.sw,
                height: 230.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?q=80&w=1000'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
