import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageCard extends StatelessWidget {
  const ProductImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 250.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(80.r), // الميلان اللي في الصورة
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        image: const DecorationImage(
          image: NetworkImage('https://your-product-image.com/img.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
