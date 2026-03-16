import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceRowWidget extends StatelessWidget {
  final String label;
  final String price;

  const PriceRowWidget({
    super.key,
    required this.label,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            color: const Color(0xFF4B3425),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
            fontFamily: 'Cairo',
            color: const Color(0xFF4B3425),
          ),
        ),
      ],
    );
  }
}
