import 'package:flutter/material.dart';
import 'package:insins/core/animation/scroll_reveal.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart'; // تأكد من وجود هذا الـ import
import 'package:insins/features/home/presentaion/widget/about_scetion.dart';
import 'package:insins/features/home/presentaion/widget/categories_section.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/custom_hero.dart';
import 'package:insins/features/home/presentaion/widget/kalam_omala.dart';

class HomeContentWidget extends StatelessWidget {
  // 1. أضفنا هذا السطر لاستقبال الدالة من الصفحة الرئيسية
  final Function(CategoryModel) onCategorySelected;

  // 2. حدثنا الـ Constructor عشان يطلبها
  const HomeContentWidget({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    // شيلنا الـ const من هنا عشان الدالة حاجة متغيرة
    return SingleChildScrollView(
      key: const PageStorageKey('home'),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const HeroBannerWidget(),
          const ScrollReveal(delay: 200, child: AboutSection()),

          // 3. هنا بعتنا الدالة لـ CategoriesSection وكده الـ Error هيختفي
          ScrollReveal(
            delay: 400,
            child: CategoriesSection(onCategoryTap: onCategorySelected),
          ),

          const ScrollReveal(
            delay: 800,
            child: TestimonialsSection(goldColor: AppColors.gold),
          ),
          const ScrollReveal(delay: 1000, child: FooterWidget()),
        ],
      ),
    );
  }
}
