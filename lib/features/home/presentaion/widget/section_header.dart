import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // العنوان الرئيسي بالخط العريض
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo', // نفس خط المتجر
              color: Color(0xFF1A1A1A),
            ),
          ),

          // زر "عرض الكل" بلمسة ذهبية
          if (onSeeAll != null)
            InkWell(
              onTap: onSeeAll,
              child: const Text(
                "عرض الكل",
                style: TextStyle(
                  color: Color(0xFFD4A96A), // اللون الذهبي بتاعك
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
