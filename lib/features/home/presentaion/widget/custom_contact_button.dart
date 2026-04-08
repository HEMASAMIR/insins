import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insins/core/widgets/whatsapp_helper.dart';

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

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

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
          // ✅ زر الواتساب مع Pulse Animation
          ScaleTransition(
            scale: _scaleAnimation,
            child: _buildCircleBtn(
              icon: FontAwesomeIcons.whatsapp,
              onTap: () => WhatsAppHelper.sendGeneralMessage(),
              bgColor: const Color(0xFF25D366),
              isMain: true,
            ),
          ),

          SizedBox(height: 16.h),

          // ✅ زر الاتصال
          _buildCircleBtn(
            icon: Icons.phone,
            onTap: () => WhatsAppHelper.call(),
            bgColor:
                const Color(0xFF333333).withOpacity(0.85), // لون أغمق وأشيك
            isMain: false,
          ),
        ],
      ),
    );
  }

  Widget _buildCircleBtn({
    required IconData icon,
    required VoidCallback onTap,
    required Color bgColor,
    required bool isMain,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isMain ? 56.w : 48.w,
        height: isMain ? 56.w : 48.w,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: isMain ? 28.sp : 22.sp),
      ),
    );
  }
}
