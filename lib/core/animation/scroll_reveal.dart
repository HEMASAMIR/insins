import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScrollReveal extends StatelessWidget {
  final Widget child;
  final double delay;

  const ScrollReveal({super.key, required this.child, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(duration: 800.ms, delay: delay.ms, curve: Curves.easeOut)
        .slideY(
          begin: 0.1,
          end: 0,
          duration: 800.ms,
          delay: delay.ms,
          curve: Curves.easeOutBack,
        )
        .shimmer(
          delay: (delay + 800).ms,
          duration: 1500.ms,
          color: Colors.white24,
        );
  }
}
