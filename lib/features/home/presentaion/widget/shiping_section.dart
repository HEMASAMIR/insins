import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShippingSection extends StatelessWidget {
  final Color goldColor;
  final Color darkBg;

  const ShippingSection({
    super.key,
    required this.goldColor,
    required this.darkBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.w),
      child: Column(
        children: [
          _buildSectionHeader("الشحن", "وتتبع الطلب"),
          SizedBox(height: 20.h),
          Row(
            children: [
              _shippingSmallCard(
                FontAwesomeIcons.shippingFast,
                "3-6 أيام",
                "مدة التوصيل",
              ),
              SizedBox(width: 10.w),
              _shippingSmallCard(Icons.wallet, "فوق 500 ريال", "شحن مجاني"),
            ],
          ),
          SizedBox(height: 20.h),
          _buildTrackingCard(),
        ],
      ),
    );
  }

  // كارت تتبع الطلب
  Widget _buildTrackingCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          Text(
            "تتبع طلبك الآن",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 15.h),
          TextField(
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: "أدخل رقم الطلب (مثلاً: 1024)",
              hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Cairo'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
          ),
          SizedBox(height: 15.h),
          _buildActionButton("تتبع حالة الطلب"),
        ],
      ),
    );
  }

  // الهيدر الخاص بالسكشن
  Widget _buildSectionHeader(String lightText, String goldText) {
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
                fontFamily: 'Cairo',
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
        Container(
          height: 2.h,
          width: 50.w,
          color: goldColor,
          margin: EdgeInsets.only(top: 8.h),
        ),
      ],
    );
  }

  // الكروت الصغيرة (مدة التوصيل / الشحن المجاني)
  Widget _shippingSmallCard(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: goldColor, size: 30.sp),
            SizedBox(height: 10.h),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                fontFamily: 'Cairo',
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11.sp,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // زر الأكشن
  Widget _buildActionButton(String label) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: darkBg,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}
