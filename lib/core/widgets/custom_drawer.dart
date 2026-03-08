import 'package:flutter/material.dart';
// تأكد من استيراد ملف الـ FAB الخاص بك
import 'package:insins/features/home/presentaion/widget/custom_contact_button.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // زر الإغلاق
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                const Spacer(flex: 1),

                // ✅ روابط القائمة - خط كبير عشان مالية الشاشة
                _buildDrawerItem(context, 'الرئيسية'),
                _buildDrawerItem(context, 'من نحن'),
                _buildDrawerItem(context, 'قسم العطور', hasArrow: true),
                _buildDrawerItem(context, 'المتجر'),
                _buildDrawerItem(context, 'تواصل معنا'),

                const Spacer(flex: 2),

                // زر تغيير اللغة في الأسفل
                _buildLanguageSection(),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ويدجت مساعدة للعناصر
  Widget _buildDrawerItem(BuildContext context, String title,
      {bool hasArrow = false}) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26, // تكبير الخط ليناسب المساحة الكبيرة
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
              ),
            ),
            if (hasArrow) ...[
              const SizedBox(width: 10),
              const Icon(Icons.keyboard_arrow_down,
                  color: Colors.white70, size: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF333333)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'English',
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Cairo'),
            ),
            SizedBox(width: 10),
            Icon(Icons.language, color: Colors.white54, size: 20),
          ],
        ),
      ),
    );
  }
}
