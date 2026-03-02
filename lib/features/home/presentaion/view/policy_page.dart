import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/colors/app_colors.dart';
import 'package:insins/core/animation/scroll_reveal.dart';

class PoliciesPage extends StatelessWidget {
  const PoliciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkGrey,
        title: Text(
          "السياسات والخصوصية",
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.h,
              color: AppColors.darkGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "السياسات والخصوصية",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Privacy & Policies",
                    style: TextStyle(color: AppColors.gold, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -30.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 20),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildItem(
                        "سياسة الاسترجاع",
                        "العطور لا تستبدل بعد الفتح لأسباب صحية.",
                      ),
                      _buildDivider(),
                      _buildItem(
                        "سياسة الخصوصية",
                        "بياناتكم في أمان وتستخدم للشحن فقط.",
                      ),
                      _buildDivider(),
                      _buildItem("الشحن", "التوصيل خلال 2-5 أيام عمل."),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, String desc) {
    return ScrollReveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            desc,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Container(
    height: 1,
    margin: EdgeInsets.symmetric(vertical: 20.h),
    color: AppColors.gold.withOpacity(0.2),
  );
}
