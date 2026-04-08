import 'package:flutter/material.dart';

class ShopCountBar extends StatelessWidget {
  final int totalCount;

  const ShopCountBar({
    super.key,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // يمين: جميع المنتجات
            const Text(
              'جميع المنتجات',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A0A00),
              ),
            ),

            // شمال: عدد المنتجات
            Text(
              '$totalCount منتج',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF777777),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
