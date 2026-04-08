import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedHeroButton extends StatelessWidget {
  final String label;
  final Color bgColor;
  final bool hasBorder;

  const AnimatedHeroButton({
    super.key,
    required this.label,
    required this.bgColor,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)), // حركة من تحت لفوق
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(
                  4.r,
                ), // زوايا حادة شوية زي الفيديو
                border: hasBorder
                    ? Border.all(color: Colors.white, width: 1.2)
                    : null,
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
