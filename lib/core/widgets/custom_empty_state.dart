import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool isError;

  const EmptyStateWidget({
    super.key,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الأيقونة بتتغير بناءً على حالة الخطأ أو فراغ البيانات
          Icon(
            isError ? Icons.wifi_off_rounded : Icons.inventory_2_outlined,
            size: 70.sp,
            color: Colors.grey[300],
          ),
          SizedBox(height: 15.h),
          Text(
            isError ? 'حدث خطأ في الاتصال' : 'عذراً، لم نجد نتائج',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              color: Colors.black54,
            ),
          ),
          // لو حابب تضيف نص إضافي تحت العنوان
          if (!isError)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'لا توجد منتجات متوفرة في هذا القسم حالياً',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: 'Cairo',
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
