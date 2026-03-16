import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insins/core/widgets/custom_drawer.dart';
import 'package:insins/core/widgets/whatsapp_helper.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_state.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuOpen;
  final VoidCallback? onHomeTap;
  final VoidCallback? onShopTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onCartTap;
  final int currentIndex;

  const CustomAppBar({
    super.key,
    this.onMenuOpen,
    this.onHomeTap,
    this.onShopTap,
    this.onAboutTap,
    this.onCartTap,
    this.currentIndex = 0,
  });

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }

  static const double _topBarHeight = 45;
  static const double _mainBarHeight = 100;

  @override
  Size get preferredSize =>
      const Size.fromHeight(_topBarHeight + _mainBarHeight);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: statusBarHeight + _topBarHeight + _mainBarHeight,
      child: Column(
        children: [
          Container(
            color: const Color(0xFF0D0500),
            height: statusBarHeight + _topBarHeight,
            padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => WhatsAppHelper.call(),
                  child: Row(
                    children: [
                      Icon(Icons.phone_outlined,
                          color: AppColors.goldIconColor, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "0503606971",
                        style: TextStyle(
                          color: AppColors.goldIconColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _topNavIcon(FontAwesomeIcons.tiktok,
                        () => _launchURL('https://www.tiktok.com/@incense_sa')),
                    const SizedBox(width: 18),
                    _topNavIcon(
                        FontAwesomeIcons.instagram,
                        () =>
                            _launchURL('https://www.instagram.com/incense.a')),
                    const SizedBox(width: 18),
                    _topNavIcon(
                        FontAwesomeIcons.snapchat,
                        () => _launchURL(
                            'https://www.snapchat.com/add/incense-s')),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: _mainBarHeight,
            color: AppColors.mainGray,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.menu, color: Colors.white, size: 30),
                      onPressed: onMenuOpen ??
                          () {
                            // ✅ احفظ الـ Cubit قبل الـ push
                            final cubit = context.read<CategorieCubit>();

                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (_, __, ___) => BlocProvider.value(
                                  value: cubit, // ✅ مرره للـ route الجديد
                                  child: Material(
                                    color: Colors.transparent,
                                    child: CustomDrawer(
                                      onClose: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop(),
                                      onHomeTap: onHomeTap,
                                      onShopTap: onShopTap,
                                      onAboutTap: onAboutTap,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                    ),
                    const SizedBox(width: 10),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        int count = 0;
                        if (state is CartLoaded) count = state.items.length;

                        return SizedBox(
                          width: 45.w,
                          height: 45.w,
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.shopping_cart_rounded,
                                  color: Colors.grey,
                                  size: 26,
                                ),
                                onPressed: onCartTap,
                              ),
                              if (count > 0)
                                Positioned(
                                  top: 6.h,
                                  right: 4.w,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF3131),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.8,
                                      ),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 14.w,
                                      minHeight: 14.w,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$count',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Arial',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Image.network(
                  'https://incense-sa.com/images/logo.png',
                  height: 42,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topNavIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: AppColors.goldIconColor, size: 20),
    );
  }
}
