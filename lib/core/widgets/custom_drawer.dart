import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/animation/slide_reveal_animation.dart';
import 'package:insins/core/widgets/custom_menu.dart';
import 'package:insins/core/widgets/drawer_item_widget.dart';
import 'package:insins/core/widgets/language_selector_widget.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';
import 'package:insins/features/home/presentaion/widget/custom_contact_button.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback? onHomeTap;
  final VoidCallback? onShopTap;
  final VoidCallback? onAboutTap;

  final GlobalKey<SlideRevealAnimationState> _animationKey = GlobalKey();

  CustomDrawer({
    super.key,
    required this.onClose,
    this.onHomeTap,
    this.onShopTap,
    this.onAboutTap,
  });

  Future<void> _handleClose() async {
    await _animationKey.currentState?.reverse();
    await Future.delayed(const Duration(milliseconds: 30));
    onClose();
  }

  Future<void> _navigate(VoidCallback? action) async {
    await _animationKey.currentState?.reverse();
    await Future.delayed(const Duration(milliseconds: 30));
    onClose();
    if (action != null) action();
  }

  @override
  Widget build(BuildContext context) {
    return SlideRevealAnimation(
      key: _animationKey,
      duration: const Duration(milliseconds: 300),
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
                        icon:
                            Icon(Icons.close, color: Colors.white, size: 30.sp),
                        onPressed: _handleClose,
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),
                  DrawerItemWidget(
                    title: 'الرئيسية',
                    onTap: () => _navigate(onHomeTap),
                  ),
                  DrawerItemWidget(
                    title: 'من نحن',
                    onTap: () => _navigate(onAboutTap),
                  ),
                  DrawerItemWidget(
                    title: 'قسم العطور',
                    onTap: () {
                      final cubit = context.read<CategorieCubit>();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: CategoryMenuWidget(
                              onCategorySelected: (categoryId, categoryName) {
                                cubit.selectCategory(categoryId);
                                _navigate(onShopTap);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    hasArrow: true,
                  ),
                  DrawerItemWidget(
                    title: 'المتجر',
                    onTap: () => _navigate(onShopTap),
                  ),
                  const Spacer(flex: 2),
                  // ─── زر اللغة هنا ────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: const LanguageSelectorWidget(),
                    // سيبناها فاضية عشان الـ Widget جواه الـ Logic بتاعه
                  ),
                  const Spacer(flex: 2),
                  SizedBox(height: 80.h),
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
