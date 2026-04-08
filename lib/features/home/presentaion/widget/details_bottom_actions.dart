import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io'; // مهم جداً عشان نحدد نوع نظام التشغيل

class DetailsBottomActions extends StatelessWidget {
  final VoidCallback onAddToCart;
  final VoidCallback onWhatsApp;

  const DetailsBottomActions({
    super.key,
    required this.onAddToCart,
    required this.onWhatsApp,
  });

  Future<void> _launchWhatsApp() async {
    const String phoneNumber = "966503606971";
    const String message = "السلام عليكم، أريد الاستفسار عن هذا المنتج";

    // الرابط ده بيفتح التطبيق مباشرة في الأندرويد
    final Uri whatsappUri = Uri.parse(
        "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}");

    // الرابط ده احتياطي لو الواتساب مش موجود
    final Uri fallbackUri = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    try {
      // جرب تفتح التطبيق مباشرة
      bool launched = await launchUrl(
        whatsappUri,
        mode: LaunchMode.externalNonBrowserApplication, // ده بيمنع فتح المتصفح
      );

      if (!launched) {
        await launchUrl(fallbackUri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      // لو فشل تماماً افتح الرابط العادي
      await launchUrl(fallbackUri, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        children: [
          // زر الواتساب المعدل
          _buildIconButton(
            FontAwesomeIcons.whatsapp,
            const Color(0xFF25D366), // لون واتساب الرسمي
            () {
              _launchWhatsApp();
              onWhatsApp(); // تنفيذ أي أكشن إضافي باعه الكوبيت
            },
          ),

          SizedBox(width: 12.w),

          // زر إضافة للسلة
          Expanded(
            child: ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF27AE60),
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                "إضافة للسلة",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // خلفية خفيفة بتخلي الزرار أشيك
          border: Border.all(color: color.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: color, size: 22.sp),
      ),
    );
  }
}
