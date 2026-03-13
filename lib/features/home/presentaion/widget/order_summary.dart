import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/constants/app_colors.dart';

class OrderSummary extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onCheckout;
  final VoidCallback onBackToShop;

  const OrderSummary({
    super.key,
    required this.totalPrice,
    required this.onCheckout,
    required this.onBackToShop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        // الحافة الذهبية العلوية
        border: Border(top: BorderSide(color: AppColors.gold, width: 3.h)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // عنوان ملخص الطلب
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "ملخص الطلب",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: const Color(0xFF1D1D1D),
              ),
            ),
          ),

          SizedBox(height: 15.h),
          const Divider(thickness: 0.5, color: Color(0xFFEEEEEE)),
          SizedBox(height: 15.h),

          // صف الإجمالي
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // السعر (يسار)
              Text(
                "SAR ${totalPrice.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4B3425),
                  fontFamily: 'Cairo',
                ),
              ),
              // كلمة الإجمالي (يمين)
              Text(
                "الإجمالي:",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: const Color(0xFF4B3425),
                ),
              ),
            ],
          ),

          SizedBox(height: 25.h),

          // زر إتمام الطلب الأخضر
          ElevatedButton(
            onPressed: onCheckout,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2DBB54),
              minimumSize: Size(double.infinity, 55.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
                SizedBox(width: 10.w),
                Text(
                  "إتمام الطلب",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 15.h),

          // زر العودة للمتجر
          GestureDetector(
            onTap: onBackToShop,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "العودة للمتجر",
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(Icons.arrow_forward, color: AppColors.gold, size: 18.sp),
              ],
            ),
          ),
          SizedBox(
            height: 60.h,
          )
        ],
      ),
    );
  }
}
