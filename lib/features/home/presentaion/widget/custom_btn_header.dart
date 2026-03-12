import 'package:flutter/material.dart';

class BreadcrumbWidget extends StatelessWidget {
  const BreadcrumbWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدمنا Directionality لضمان أن الترتيب يبدأ من اليمين (الرئيسية أولاً)
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF4A3728), // لون الخلفية البني الداكن
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // أيقونة الرئيسية
            const Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            // نص الرئيسية
            const Text(
              'الرئيسية',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // الفاصل (بأبعاد متساوية)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '/',
                style: TextStyle(
                  color:
                      Color(0xFFD4A96A), // لون ذهبي خفيف للفاصل ليعطي شكل فخم
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            // نص الصفحة الحالية (المتجر)
            const Text(
              'المتجر',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: Color(0xFFD1D1D1), // رمادي فاتح لتمييز الصفحة الحالية
              ),
            ),
          ],
        ),
      ),
    );
  }
}
