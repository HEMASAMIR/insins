import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeader extends StatelessWidget {
  final String lightText;
  final String goldText;
  final Color goldColor;

  const SectionHeader({
    super.key,
    required this.lightText,
    required this.goldText,
    required this.goldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$lightText ",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo', // يفضل توحيد الخط
              ),
            ),
            Text(
              goldText,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: goldColor,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
        // الخط الذهبي السفلي
        Container(
          height: 2.h,
          width: 50.w,
          color: goldColor,
          margin: EdgeInsets.only(top: 8.h),
        ),
      ],
    );
  }
}
