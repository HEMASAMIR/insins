import 'dart:developer';

import 'package:flutter/material.dart';

class BreadcrumbWidget extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onShopTap;

  const BreadcrumbWidget({
    super.key,
    this.onHomeTap,
    this.onShopTap,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF4A3728),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.home_filled, color: Colors.white, size: 20),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    log("الذهاب الي الصفحه الرئيسيه");

                    // 1. جرب دي لو بتستخدم Navigator عادي:
                    // Navigator.of(context).pop();

                    // 2. أو جرب دي لو عايز تروح لصفحة معينة (استبدل HomePage باسم صفحتك):
                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);

                    // 3. الحل الأضمن عشان نتأكد إن المشكلة في الربط:
                    if (onHomeTap != null) {
                      onHomeTap!.call();
                    } else {
                      log("تحذير: onHomeTap قيمتها null!");
                    }
                  },
                  child: Text(
                    'الرئيسية',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '/',
                style: TextStyle(
                  color: Color(0xFFD4A96A),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            GestureDetector(
              onTap: onShopTap,
              child: const Text(
                'المتجر',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: Color(0xFFD1D1D1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
