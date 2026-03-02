import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insins/features/home/presentaion/view/policy_page.dart';

class CustomFooter extends StatelessWidget {
  final Color darkBg;
  final Color goldColor;

  const CustomFooter({
    super.key,
    required this.darkBg,
    required this.goldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      color: darkBg,
      width: double.infinity,
      child: Column(
        children: [
          // شعار البراند
          Text(
            "إنسينس - INCENSE",
            style: TextStyle(
              color: goldColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              letterSpacing: 1.2,
              fontFamily: 'Cairo',
            ),
          ),

          SizedBox(height: 15.h),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PoliciesPage()),
              );
            },
            child: Column(
              children: [
                Text(
                  "السياسات والخصوصية",
                  style: TextStyle(
                    color: goldColor.withOpacity(0.8),
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Privacy & Policies",
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 10.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 25.h),

          // أيقونات التواصل الاجتماعي
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(FontAwesomeIcons.instagram),
              SizedBox(width: 25.w),
              _buildSocialIcon(FontAwesomeIcons.twitter),
              SizedBox(width: 25.w),
              _buildSocialIcon(FontAwesomeIcons.snapchat),
            ],
          ),

          SizedBox(height: 30.h),

          // حقوق الملكية
          Divider(
            color: Colors.white10,
            thickness: 1,
            indent: 50.w,
            endIndent: 50.w,
          ),
          SizedBox(height: 15.h),

          Text(
            "© 2026 جميع الحقوق محفوظة",
            style: TextStyle(
              color: Colors.white30,
              fontSize: 11.sp,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت مساعدة لبناء الأيقونات بشكل موحد
  Widget _buildSocialIcon(IconData icon) {
    return InkWell(
      onTap: () {
        // ضف روابط السوشيال ميديا هنا
      },
      child: Icon(icon, color: Colors.white54, size: 20.sp),
    );
  }
}
