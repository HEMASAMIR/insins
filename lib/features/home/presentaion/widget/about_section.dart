import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/presentaion/widget/section_header.dart';

class AboutSection extends StatelessWidget {
  final Color goldColor;

  const AboutSection({super.key, required this.goldColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
      child: Column(
        children: [
          // استخدام الويدجت المنفصلة للهيدر
          SectionHeader(
            lightText: "قصة إبداع",
            goldText: "إنسينس",
            goldColor: goldColor,
          ),

          SizedBox(height: 15.h),

          Text(
            "نحن متخصصون في تقديم أرقى أنواع العطور والبخور، نسعى لنكون الخيار الأول لعشاق الفخامة والتميّز. نفتخر بجذورنا العربية وبتراثنا العطري الغني.",
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.6,
              fontSize: 14.sp,
              color: Colors.black87,
              fontFamily: 'Cairo', // للحفاظ على الهوية البصرية العربية
            ),
          ),
        ],
      ),
    );
  }
}
