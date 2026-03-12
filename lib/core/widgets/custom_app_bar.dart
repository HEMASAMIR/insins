import 'package:flutter/material.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuOpen;
  final VoidCallback? onHomeTap;
  final VoidCallback? onShopTap;
  final int currentIndex;

  const CustomAppBar({
    super.key,
    this.onMenuOpen,
    this.onHomeTap,
    this.onShopTap,
    this.currentIndex = 0,
  });

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
          // ── الشريط العلوي ──────────────────────────
          Container(
            color: const Color(0xFF0D0500),
            height: statusBarHeight + _topBarHeight,
            padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                Row(
                  children: [
                    Icon(FontAwesomeIcons.tiktok,
                        color: AppColors.goldIconColor, size: 20),
                    const SizedBox(width: 18),
                    Icon(FontAwesomeIcons.instagram,
                        color: AppColors.goldIconColor, size: 20),
                    const SizedBox(width: 18),
                    Icon(FontAwesomeIcons.snapchat,
                        color: AppColors.goldIconColor, size: 20),
                  ],
                ),
              ],
            ),
          ),

          // ── الشريط الرئيسي ─────────────────────────
          Container(
            height: _mainBarHeight,
            color: AppColors.mainGray,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // يسار: منيو + كارت بس (بدون أزرار نص)
                Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.menu, color: Colors.white, size: 30),
                      onPressed: onMenuOpen ??
                          () => Scaffold.of(context).openEndDrawer(),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.goldIconColor,
                      size: 28,
                    ),
                  ],
                ),

                // اللوجو في المنتصف/اليمين
                Image.network(
                  'https://incense-sa.com/images/logo.png',
                  height: 42,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
