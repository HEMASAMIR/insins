import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: const Icon(Icons.menu, color: Colors.white),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "إنسينس",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
              fontFamily: 'Cairo', // تأكد من إضافة الخط في pubspec
            ),
          ),
          Text(
            "INCENSE",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10.sp,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
        ),
      ],
    );
  }

  // هذا السطر ضروري جداً عند فصل الـ AppBar في ملف خارجي
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10.h);
}
