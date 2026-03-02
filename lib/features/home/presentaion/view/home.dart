import 'package:flutter/material.dart';
import 'package:insins/core/animation/scroll_reveal.dart';
import 'package:insins/core/colors/app_colors.dart';
import 'package:insins/core/widgets/custom_app_bar.dart';
import 'package:insins/core/widgets/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/about_section.dart';
import 'package:insins/features/home/presentaion/widget/custom_contact_button.dart';
import 'package:insins/features/home/presentaion/widget/custom_hero.dart';
import 'package:insins/features/home/presentaion/widget/kalam_omala.dart';
import 'package:insins/features/home/presentaion/widget/luxary_categorey.dart';
import 'package:insins/features/home/presentaion/widget/shiping_section.dart';

class LuxuryHomePage extends StatefulWidget {
  const LuxuryHomePage({super.key});

  @override
  State<LuxuryHomePage> createState() => _LuxuryHomePageState();
}

class _LuxuryHomePageState extends State<LuxuryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),

      floatingActionButton: const QuickContactButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Hero Section
            const ScrollReveal(
              delay: 0,
              child: HeroSection(goldColor: AppColors.gold),
            ),

            // 2. About Section
            ScrollReveal(
              delay: 200,
              child: AboutSection(goldColor: AppColors.gold),
            ),

            // 3. Categories Section
            ScrollReveal(
              delay: 400,
              child: LuxuryCategoriesSection(
                goldColor: AppColors.gold,
                darkBg: AppColors.darkGrey,
              ),
            ),

            // 4. Shipping Section
            ScrollReveal(
              delay: 600,
              child: ShippingSection(
                goldColor: AppColors.gold,
                darkBg: AppColors.darkGrey,
              ),
            ),

            // 5. Testimonials Section
            ScrollReveal(
              delay: 800,
              child: TestimonialsSection(goldColor: AppColors.gold),
            ),

            // 6. Footer (الرابط موجود هنا بالداخل)
            ScrollReveal(
              delay: 1000,
              child: CustomFooter(
                darkBg: AppColors.darkGrey,
                goldColor: AppColors.gold,
                // يمكنك إضافة callback هنا إذا كنت مبرمج الفوتر ليدعم ذلك
              ),
            ),
          ],
        ),
      ),
    );
  }
}
