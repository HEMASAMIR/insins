import 'package:flutter/material.dart';

class SlideRevealAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool isExiting; // بنستخدمها عشان نعرف الويدجت هتقفل ولا هتفتح

  const SlideRevealAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.isExiting = false,
  });

  @override
  State<SlideRevealAnimation> createState() => SlideRevealAnimationState();
}

class SlideRevealAnimationState extends State<SlideRevealAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // من اليمين
      end: Offset.zero, // للمنتصف
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ));

    _controller.forward();
  }

  // ميثود نقدر نناديها من برا عشان نقفل الأنيميشن
  Future<void> reverse() async {
    await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}
