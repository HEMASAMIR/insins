import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/presentaion/widget/categorey_card.dart';
import 'package:insins/features/home/presentaion/widget/section_header.dart';
// تأكد من استيراد الويجت التي تعتمد عليها هذه الصفحة
// import 'section_header.dart';
// import 'luxury_category_card.dart';

class LuxuryCategoriesSection extends StatelessWidget {
  final Color goldColor;
  final Color darkBg;

  const LuxuryCategoriesSection({
    super.key,
    required this.goldColor,
    required this.darkBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      color: const Color(0xFFF9F9F9), // خلفية فاتحة لتمييز القسم عن غيره
      child: Column(
        children: [
          // 1. عنوان القسم (باستخدام الويدجت المنفصلة)
          SectionHeader(
            lightText: "مجموعاتنا",
            goldText: "الفاخرة",
            goldColor: goldColor,
          ),

          SizedBox(height: 10.h),

          // 2. وصف قصير تحت العنوان
          Text(
            "اكتشف تشكيلتنا المختارة من العطور والجمال والعود",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
              fontFamily: 'Cairo',
            ),
          ),

          SizedBox(height: 30.h),

          // 3. قائمة المجموعات (كروت الأقسام)
          _buildCategoryList(),
        ],
      ),
    );
  }

  // ميثود داخلية لتنظيم الكروت بشكل رأسي
  Widget _buildCategoryList() {
    return Column(
      children: [
        LuxuryCategoryCard(
          title: "مجموعة العطور",
          details: const ["عطور رجالية ونسائية", "عطور الجسم والشعر"],
          img:
              "https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?q=80&w=1000",
          goldColor: goldColor,
          darkBg: darkBg,
          onTap: () {
            // هنا تضع وظيفة التنقل لصفحة العطور
          },
        ),

        SizedBox(height: 25.h),

        LuxuryCategoryCard(
          title: "قسم الجمال",
          details: const ["المكياج والعناية بالبشرة", "العناية بالشعر والجسم"],
          img:
              "https://images.unsplash.com/photo-1596462502278-27bfdc4033c8?q=80&w=1000",
          goldColor: goldColor,
          darkBg: darkBg,
          onTap: () {
            // هنا تضع وظيفة التنقل لصفحة الجمال
          },
        ),

        SizedBox(height: 25.h),

        LuxuryCategoryCard(
          title: "العود الأصيل",
          details: const ["العود الطبيعي", "العود المحسن"],
          img:
              "https://images.unsplash.com/photo-1588449668365-d15e397f6787?q=80&w=1000",
          goldColor: goldColor,
          darkBg: darkBg,
          onTap: () {
            // هنا تضع وظيفة التنقل لصفحة العود
          },
        ),
      ],
    );
  }
}
