import 'package:flutter/material.dart';
import 'package:insins/core/constants/app_colors.dart';

class HeroBannerWidget extends StatefulWidget {
  const HeroBannerWidget({super.key});

  @override
  State<HeroBannerWidget> createState() => _HeroBannerWidgetState();
}

class _HeroBannerWidgetState extends State<HeroBannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?q=80&w=1400',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.65),
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slideUp,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الخط الذهبي العلوي
                  Container(
                    width: 60,
                    height: 1.5,
                    color: AppColors.gold,
                    margin: const EdgeInsets.only(bottom: 20),
                  ),

                  // العنوان العربي
                  const Text(
                    'عنوان الفخامة والتميّز',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      height: 1.4,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // العنوان الإنجليزي
                  const Text(
                    'Title of Luxury & Distinction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // الوصف
                  const Text(
                    'أرقى أنواع العطور والبخور ومنتجات التجميل\nالمستوحاة من أصالة التراث العربي.',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // الأزرار
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // زر تسوق العطور
                      _HeroButton(
                        label: 'تسوق العطور',
                        filled: true,
                        onTap: () {},
                      ),
                      const SizedBox(width: 16),
                      // زر اكتشف العود
                      _HeroButton(
                        label: 'اكتشف العود',
                        filled: false,
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // سهم للأسفل
                  const _BouncingArrow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _HeroButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: widget.filled
                ? (_hovered ? Colors.white : AppColors.gold)
                : Colors.transparent,
            border: Border.all(
              color: widget.filled
                  ? (_hovered ? AppColors.gold : AppColors.gold)
                  : Colors.white,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.filled
                  ? (_hovered ? AppColors.gold : Colors.white)
                  : Colors.white,
              fontSize: 13,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _BouncingArrow extends StatefulWidget {
  const _BouncingArrow();

  @override
  State<_BouncingArrow> createState() => _BouncingArrowState();
}

class _BouncingArrowState extends State<_BouncingArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _bounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _bounce = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.4),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _bounce,
      child: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.gold,
        size: 32,
      ),
    );
  }
}
