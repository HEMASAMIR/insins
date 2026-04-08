import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsProductInfo extends StatelessWidget {
  final String name;
  final String price;
  final String description;

  const DetailsProductInfo({
    super.key,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight, // بيخلي الودجت نفسها تتركن يمين
            child: Text(
              name,
              textAlign: TextAlign.right, // بيخلي الكلام جوه السطور يترص يمين
              textDirection: TextDirection
                  .rtl, // بيضمن إن العربي يبدأ من اليمين حتى لو فيه أرقام
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text("$price ر.س",
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18.sp,
                  color: const Color(0xFFD4AF37),
                  fontWeight: FontWeight.bold)),
          Divider(height: 30.h),
          Text("الوصف",
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          Text(description,
              textAlign: TextAlign.right,
              style:
                  TextStyle(fontFamily: 'Cairo', fontSize: 14.sp, height: 1.5)),
        ],
      ),
    );
  }
}
