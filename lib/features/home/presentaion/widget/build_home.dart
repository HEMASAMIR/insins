import 'package:flutter/material.dart';
import 'package:insins/core/animation/scroll_reveal.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/presentaion/widget/about_scetion.dart';
import 'package:insins/features/home/presentaion/widget/categories_section.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/custom_hero.dart';
import 'package:insins/features/home/presentaion/widget/kalam_omala.dart';

class HomeContentWidget extends StatelessWidget {
  final Function(CategoryModel) onCategorySelected;
  final ScrollController? scrollController;
  final GlobalKey? aboutKey;
  final VoidCallback? onShopTap;
  final VoidCallback? onShopHome;

  const HomeContentWidget(
      {super.key,
      required this.onCategorySelected,
      this.scrollController,
      this.aboutKey,
      this.onShopTap,
      this.onShopHome});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      key: const PageStorageKey('home'),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          HeroBannerWidget(
            onShopTap: onShopTap,
          ),
          ScrollReveal(
            key: aboutKey,
            delay: 200,
            child: const AboutSection(),
          ),
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
