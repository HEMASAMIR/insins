import 'package:flutter/material.dart';
import 'package:insins/core/animation/scroll_reveal.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:insins/core/constants/static_model.dart';
import 'package:insins/core/widgets/custom_app_bar.dart';
import 'package:insins/core/widgets/custom_drawer.dart';
import 'package:insins/features/home/presentaion/widget/custom_contact_button.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/custom_product_card.dart';
import 'package:insins/features/home/presentaion/widget/custom_row.dart';
import 'package:insins/features/home/presentaion/widget/section_header.dart';
import 'package:insins/features/home/presentaion/widget/shiping_section.dart';
import 'package:insins/features/home/presentaion/widget/kalam_omala.dart';

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
      endDrawer: const CustomDrawer(),
      body: Stack(
        children: [
          // الطبقة 1: محتوى السكرول بتاعك
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: const CustomAppBar().preferredSize.height),
                const ShopHeaderWidget(),
                ShopCountBar(totalCount: products.length),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: ProductCardWidget(
                        imageUrl: p.imageUrl,
                        category: p.category,
                        name: p.name,
                        price: p.price,
                        onAddToCart: () {},
                      ),
                    );
                  },
                ),
                const ScrollReveal(
                  delay: 600,
                  child: ShippingSection(
                      goldColor: AppColors.gold, darkBg: AppColors.darkGrey),
                ),
                const ScrollReveal(
                  delay: 800,
                  child: TestimonialsSection(goldColor: AppColors.gold),
                ),
                const ScrollReveal(
                  delay: 1000,
                  child: FooterWidget(),
                ),
              ],
            ),
          ),

          // ✅ الطبقة 2: الـ Action Button بتاعك (يظهر فوق كل حاجة)
          const Positioned(
            bottom: 20,
            right: 20,
            child: QuickContactButtons(),
          ),
        ],
      ),
    );
  }
}
