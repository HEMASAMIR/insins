import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuSectionHeader extends StatelessWidget {
  final String title;
  final double? fontSize;
  final VoidCallback? onTap;

  const MenuSectionHeader({
    super.key,
    required this.title,
    this.fontSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.8),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize ?? 15.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
