import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/animation/scroll_reveal.dart';
import 'package:insins/features/home/presentaion/widget/about_scetion.dart';
import 'package:insins/features/home/presentaion/widget/categories_section.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/custom_hero.dart';

class HomeContentWidget extends StatelessWidget {
  /// الدالة التي تستقبل القسم المختار (سواء كائن Category أو SubCategory)
  final Function(dynamic) onCategorySelected;
  final ScrollController? scrollController;
  final GlobalKey? aboutKey;
  final VoidCallback? onShopTap;
  final VoidCallback? onShopHome;

  const HomeContentWidget({
    super.key,
    required this.onCategorySelected,
    this.scrollController,
    this.aboutKey,
    this.onShopTap,
    this.onShopHome,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      key: const PageStorageKey('home'),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // 1. الـ Banner الرئيسي (Hero)

          HeroBannerWidget(
            onShopTap: onShopTap,
          ),

          // 2. قسم "عن إنسينس" مع أنيميشن الظهور
          ScrollReveal(
            key: aboutKey,
            delay: 200,
            child: const AboutSection(),
          ),

          // 3. قسم المجموعات (الرئيسية + كروت التسوق للفرعية)
          ScrollReveal(
            delay: 400,
            child: CategoriesSection(
              // عند الضغط على المجموعة الرئيسية (استكشف المجموعة)
              onCategoryTap: (category) {
                onCategorySelected(category);
              },
              // عند الضغط على "تسوق الآن" في القسم الفرعي
              onSubCategoryTap: (subCategory) {
                onCategorySelected(subCategory);
              },
            ),
          ),

          // 4. الفوتر النهائي
          const ScrollReveal(
            delay: 500, // سرعنا الـ delay شوية لراحة المستخدم
            child: FooterWidget(),
          ),
        ],
      ),
    );
  }
}
