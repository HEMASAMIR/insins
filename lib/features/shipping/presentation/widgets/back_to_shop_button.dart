import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackToShopButton extends StatelessWidget {
  final VoidCallback onTap;

  const BackToShopButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "العودة للمتجر",
            style: TextStyle(
              color: const Color(0xFFD4AF37),
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(width: 5.w),
          Icon(Icons.arrow_back, color: const Color(0xFFD4AF37), size: 18.sp),
        ],
      ),
    );
  }
}
