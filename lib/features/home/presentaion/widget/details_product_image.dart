import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsProductImage extends StatelessWidget {
  final String imageUrl;
  const DetailsProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      color: const Color(0xFFFBFBFB),
      child: Image.network(
        "https://incense-sa.com/$imageUrl",
        fit: BoxFit.contain,
      ),
    );
  }
}
