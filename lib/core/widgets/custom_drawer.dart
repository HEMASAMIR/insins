import 'package:flutter/material.dart';
import 'package:insins/core/animation/slide_reveal_animation.dart';
import 'package:insins/core/widgets/drawer_item_widget.dart';
import 'package:insins/core/widgets/language_selector_widget.dart';
import 'package:insins/features/home/presentaion/widget/custom_contact_button.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback? onHomeTap;
  final VoidCallback? onShopTap;

  final GlobalKey<SlideRevealAnimationState> _animationKey = GlobalKey();

  CustomDrawer({
    super.key,
    required this.onClose,
    this.onHomeTap,
    this.onShopTap,
  });

  Future<void> _handleClose() async {
    await _animationKey.currentState?.reverse();
    await Future.delayed(const Duration(milliseconds: 100));
    onClose();
  }

  // ✅ إغلاق الدرور + تنفيذ الأكشن
  Future<void> _navigate(VoidCallback? action) async {
    await _animationKey.currentState?.reverse();
    await Future.delayed(const Duration(milliseconds: 100));
    onClose();
    action?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SlideRevealAnimation(
      key: _animationKey,
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.white, size: 30),
                        onPressed: _handleClose,
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),

                  // ✅ الرئيسية - بيروح للـ Home
                  DrawerItemWidget(
                    title: 'الرئيسية',
                    onTap: () => _navigate(onHomeTap),
                  ),

                  DrawerItemWidget(
                    title: 'من نحن',
                    onTap: _handleClose,
                  ),

                  DrawerItemWidget(
                    title: 'قسم العطور',
                    onTap: _handleClose,
                    hasArrow: true,
                  ),

                  // ✅ المتجر - بيروح للـ Shop
                  DrawerItemWidget(
                    title: 'المتجر',
                    onTap: () => _navigate(onShopTap),
                  ),

                  DrawerItemWidget(
                    title: 'تواصل معنا',
                    onTap: _handleClose,
                  ),

                  const Spacer(flex: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LanguageSelectorWidget(onTap: () {}),
                  ),
                  const Spacer(flex: 2),
                  const SizedBox(height: 80),
                ],
              ),
              const Positioned(
                bottom: 20,
                right: 20,
                child: QuickContactButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
