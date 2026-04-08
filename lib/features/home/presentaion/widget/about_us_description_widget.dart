import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutDescriptionWidget extends StatelessWidget {
  const AboutDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          Text(
            "قصة إبداع إنسينس",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Cairo', // تأكد من إضافة الخط في الـ pubspec
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            "نحن إنسينس للعطور متخصصون في تقديم أرقى أنواع العطور والبخور ومستلزمات التجميل، نسعى لنكون الخيار الأول لعشاق الفخامة والتميز، نفتخر بجذورنا العربية وتراثنا العطري الغني، ونحرص على تقديم منتجات تجمع بين الأصالة والجودة العالمية لتلبي أذواق عملائنا داخل المملكة وخارجها.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade700,
              height: 1.8,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}
