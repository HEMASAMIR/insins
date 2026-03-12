import 'package:flutter/material.dart';

class LanguageSelectorWidget extends StatefulWidget {
  final String languageName;
  final VoidCallback onTap;

  const LanguageSelectorWidget({
    super.key,
    this.languageName = 'English',
    required this.onTap,
  });

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // إعداد أنيميشن النبض (Pulse)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true); // يكرر الأنيميشن رايح جاي

    _animation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          // جعل الزرار يأخذ العرض المتاح كاملاً
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF333333), // اللون الرمادي الفخم
            borderRadius: BorderRadius.circular(8), // حواف خفيفة زي الصورة
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.languageName,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.language, color: Colors.white, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
