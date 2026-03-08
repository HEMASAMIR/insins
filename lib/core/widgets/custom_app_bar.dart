import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:insins/core/widgets/custom_drawer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  static const double _topBarHeight = 28;
  static const double _mainBarHeight = 100;

  @override
  Size get preferredSize =>
      const Size.fromHeight(_topBarHeight + _mainBarHeight);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;

    final double iconSize = screenWidth < 360 ? 20.0 : 24.0;
    final double cartSize = screenWidth < 360 ? 18.0 : 22.0;
    final double logoHeight = screenWidth < 360 ? 28.0 : 36.0;
    final double socialIconSize = screenWidth < 360 ? 14.0 : 16.0;
    final double fontSize = screenWidth < 360 ? 10.0 : 11.0;

    return SizedBox(
      height: statusBarHeight + _topBarHeight + _mainBarHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── TOP BAR
          Container(
            color: const Color(0xFF0D0500),
            height: statusBarHeight + _topBarHeight,
            padding: EdgeInsets.only(
              top: statusBarHeight,
              left: 14,
              right: 14,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [
                  Icon(Icons.phone,
                      color: const Color(0xFFD4A96A), size: socialIconSize + 1),
                  const SizedBox(width: 5),
                  Text(
                    '0503606971',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: fontSize,
                      color: const Color(0xFFD4A96A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
                Row(children: [
                  _SocialBtn(
                      icon: FontAwesomeIcons.tiktok, size: socialIconSize),
                  const SizedBox(width: 12),
                  _SocialBtn(
                      icon: FontAwesomeIcons.instagram, size: socialIconSize),
                  const SizedBox(width: 12),
                  _SocialBtn(
                      icon: FontAwesomeIcons.snapchat, size: socialIconSize),
                ]),
              ],
            ),
          ),

          // ── MAIN BAR
          Container(
            height: _mainBarHeight,
            color: AppColors.mainGray,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ يسار: Menu + Cart
                Row(children: [
                  Builder(
                    builder: (ctx) => IconButton(
                      icon:
                          Icon(Icons.menu, color: Colors.white, size: iconSize),
                      onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.shopping_cart_outlined,
                        color: const Color(0xFFD4A96A), size: cartSize),
                  ),
                ]),

                // ✅ يمين: Logo
                Image.network(
                  'https://incense-sa.com/images/logo.png',
                  height: logoHeight,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Text(
                    'إنسينس | Incense',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: screenWidth < 360 ? 13 : 15,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD4A96A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final IconData icon;
  final double size;
  const _SocialBtn({required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: FaIcon(icon, color: const Color(0xFFD4A96A), size: size),
    );
  }
}
