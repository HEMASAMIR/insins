import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/presentaion/view/policy_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:insins/features/home/presentaion/view/cart_screen.dart'; // تأكد من مسار صفحة السلة عندك

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  // دالة مساعدة لفتح الروابط الخارجية (سوشيال ميديا)
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: const Color(0xFF0D0D0D),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. اللوجو
                  Image.asset(
                    'assets/images/insins.jpeg',
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 14),

                  // 2. الوصف
                  const Text(
                    'إنسينس للعطور - نمنحك تجربة عطرية استثنائية\nمستوحاة من التراث العربي',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: Color(0xFF999999),
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 3. السوشيال ميديا
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon(
                        FontAwesomeIcons.tiktok,
                        () => _launchURL('https://www.tiktok.com/@incense_sa'),
                      ),
                      const SizedBox(width: 16),
                      _socialIcon(
                        FontAwesomeIcons.snapchat,
                        () => _launchURL(
                            'https://www.snapchat.com/add/incense-s'),
                      ),
                      const SizedBox(width: 16),
                      _socialIcon(
                        FontAwesomeIcons.instagram,
                        () => _launchURL('https://www.instagram.com/incense.a'),
                      ),
                      const SizedBox(width: 16),
                      _socialIcon(
                        FontAwesomeIcons.whatsapp,
                        () => _launchURL('https://wa.me/966503606971'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),
                  _divider(),
                  const SizedBox(height: 24),

                  // 4. روابط تهمك (الآن تعمل وقابلة للضغط)
                  _sectionTitle('روابط تهمك'),
                  const SizedBox(height: 12),
                  _link('سلة المشتريات', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: BlocProvider.of<CartCubit>(
                              context), // بياخد الـ Cubit اللي شغال فعلاً
                          child: const CartScreen(),
                        ),
                      ),
                    );
                  }),
                  _link('معلومات الشحن', () {}),
                  _link('السياسات', () {
                    log("Navigate to PolicyScreen");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PolicyScreen(),
                        ));
                  }),

                  const SizedBox(height: 24),

                  // 5. زرار موثق
                  _buildVerifiedBadge(),

                  const SizedBox(height: 24),
                  _divider(),
                  const SizedBox(height: 24),

                  // 6. تواصل معنا
                  _sectionTitle('تواصل معنا'),
                  const SizedBox(height: 14),
                  _contactRow(Icons.phone, '+966 503 606 971'),
                  const SizedBox(height: 8),
                  _contactRow(Icons.email_outlined, 'info@incense-sa.com'),

                  const SizedBox(height: 24),
                  _divider(),
                  const SizedBox(height: 24),

                  // 7. طرق الدفع
                  _sectionTitle('طرق دفع متعددة وآمنة'),
                  const SizedBox(height: 14),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _paymentBadge('Visa'),
                      _paymentBadge('Mastercard'),
                      _paymentBadge('mada'),
                      _paymentBadge('Tabby'),
                      _paymentBadge('Apple Pay'),
                    ],
                  ),
                ],
              ),
            ),

            // Copyright Section
            _buildCopyrightSection(),
          ],
        ),
      ),
    );
  }

  // --- مساعدات التصميم (Helper Widgets) ---

  Widget _socialIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1A1A1A),
          border: Border.all(color: const Color(0xFF333333)),
        ),
        child: Center(
          child: FaIcon(icon, size: 15, color: Colors.white),
        ),
      ),
    );
  }

  Widget _link(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13,
            color: Color(0xFF888888),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifiedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () async {
              final Uri url =
                  Uri.parse('https://incense-sa.com/images/certificate.jpeg');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                debugPrint('Could not launch URL');
              }
            },
            child: Text(
              'موثق لدى منصة الأعمال',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopyrightSection() {
    return Container(
      color: const Color(0xFF080808),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      width: double.infinity,
      child: const Column(
        children: [
          Text(
            '© 2026 جميع الحقوق محفوظة لشركة إنسينس للعطور',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 10,
              color: Color(0xFF555555),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Design & Programming by GNTAYER',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF444444),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(color: Color(0xFF222222), thickness: 1);

  Widget _sectionTitle(String title) => Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  Widget _contactRow(IconData icon, String text) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: Colors.white38),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              color: Color(0xFF888888),
            ),
          ),
        ],
      );

  Widget _paymentBadge(String name) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF333333)),
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 11,
            color: Color(0xFFCCCCCC),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
