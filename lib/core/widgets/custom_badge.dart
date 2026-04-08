import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  final bool isActive;

  const CustomBadge({super.key, required this.text, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        border: isActive ? Border.all(color: Colors.white24, width: 1) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white54,
          fontSize: 12.sp,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
