import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuickContactButtons extends StatefulWidget {
  const QuickContactButtons({super.key});

  @override
  State<QuickContactButtons> createState() => _QuickContactButtonsState();
}

class _QuickContactButtonsState extends State<QuickContactButtons>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 1. إعداد أنيميشن النبض (Pulse)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // 2. أنيميشن ظهور الأزرار (Fade In)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: _isVisible ? 1.0 : 0.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // زر الواتساب - مع تأثير النبض المستمر
          ScaleTransition(
            scale: _scaleAnimation,
            child: _buildCircleBtn(
              icon: FontAwesomeIcons.whatsapp,
              onTap: () {
                // ضيف الأكشن هنا (فتح الواتساب)
              },
              bgColor: const Color(0xFF25D366),
              isMain: true,
            ),
          ),

          SizedBox(height: 15.h),

          // زر الاتصال - ثابت (أصغر شوية زي الـ Mini في الـ CSS)
          _buildCircleBtn(
            icon: Icons.phone,
            onTap: () {
              // ضيف الأكشن هنا (اتصال)
            },
            bgColor: const Color(0xFF9E9E9E).withOpacity(0.9),
            isMain: false,
          ),
        ],
      ),
    );
  }

  // ميثود بناء الزرار الموحدة عشان الكود يكون نظيف
  Widget _buildCircleBtn({
    required IconData icon,
    required VoidCallback onTap,
    required Color bgColor,
    required bool isMain,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isMain ? 54.w : 45.w, // الرئيسي أكبر شوية
        height: isMain ? 54.w : 45.w,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: isMain ? 28.sp : 22.sp),
      ),
    );
  }
}
