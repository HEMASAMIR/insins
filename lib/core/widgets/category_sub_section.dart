import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySubSection extends StatelessWidget {
  final List<String> items;
  final Function(String)? onItemTap;

  const CategorySubSection({
    super.key,
    required this.items,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: items.map((item) {
          return InkWell(
            onTap: () {
              if (onItemTap != null) {
                onItemTap!(item);
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                    width: 0.5,
                  ),
                ),
              ),
              // ✅ هنا التعديل عشان الكلام يبقى في النص بالظبط
              alignment: Alignment.center,
              child: Text(
                "- $item",
                textAlign: TextAlign.center, // ✅ توسيط النص
                style: TextStyle(
                  color: const Color(0xFF4A4A4A),
                  fontSize: 14.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
