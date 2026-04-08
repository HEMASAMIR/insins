import 'package:flutter/material.dart';
import 'package:insins/core/constants/app_colors.dart';

class HeroBannerWidget extends StatefulWidget {
  final VoidCallback? onShopTap;

  const HeroBannerWidget({super.key, this.onShopTap});

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
      begin: const Offset(0, 0.2),
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
    return SizedBox(
      height: MediaQuery.of(context).size.height, // ✅ الشاشة كاملة
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// الصورة
          const Image(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?q=80&w=1400',
            ),
            fit: BoxFit.cover,
          ),

          /// gradient
          Container(
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
          ),

          /// 🔥 التوزيع الصح
          Column(
            children: [
              const Spacer(),

              /// الكلام في النص الحقيقي
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slideUp,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 60,
                          height: 1.5,
                          color: AppColors.gold,
                          margin: const EdgeInsets.only(bottom: 20),
                        ),
                        const Text(
                          'عنوان الفخامة والتميّز\nTitle of Luxury & Distinction',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'أرقى أنواع العطور والبخور ومنتجات التجميل\nالمستوحاة من أصالة التراث العربي.',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 36),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _HeroButton(
                              label: 'اكتشف العود',
                              filled: false,
                              onTap: () => widget.onShopTap?.call(),
                            ),
                            const SizedBox(width: 16),
                            _HeroButton(
                              label: 'تسوق العطور',
                              filled: true,
                              onTap: () => widget.onShopTap?.call(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              /// السهم تحت
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _BouncingArrow(),
              ),
            ],
          ),
        ],
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
            border: Border.all(color: AppColors.gold, width: 1.5),
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
    ).animate(
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
