import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: const Color(0xFF0D0D0D),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // ✅ center
                children: [
                  // ✅ 1. اللوجو
                  Image.asset(
                    'assets/images/insins.jpeg',
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 14),

                  // ✅ 2. الوصف
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

                  // ✅ 3. سوشيال
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon(FontAwesomeIcons.tiktok),
                      const SizedBox(width: 16),
                      _socialIcon(FontAwesomeIcons.whatsapp),
                      const SizedBox(width: 16),
                      _socialIcon(FontAwesomeIcons.instagram),
                    ],
                  ),
                  const SizedBox(height: 28),
                  _divider(),
                  const SizedBox(height: 24),

                  // ✅ 4. روابط - center
                  _sectionTitle('روابط تهمك'),
                  const SizedBox(height: 12),
                  _link('سلة المشتريات'),
                  _link('معلومات الشحن'),
                  _link('السياسات'),
                  const SizedBox(height: 24),

                  // ✅ 5. زرار موثق
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF333333)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'موثق لدى منصة الأعمال',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _divider(),
                  const SizedBox(height: 24),

                  // ✅ 6. تواصل معنا - center
                  _sectionTitle('تواصل معنا'),
                  const SizedBox(height: 14),
                  _contactRow(Icons.phone, '+966 503 606 971'),
                  const SizedBox(height: 8),
                  _contactRow(Icons.email_outlined, 'info@incense-sa.com'),
                  const SizedBox(height: 24),
                  _divider(),
                  const SizedBox(height: 24),

                  // ✅ 7. طرق الدفع
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
                  const SizedBox(height: 12),

                  // ✅ الدفع عند الاستلام
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF333333)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.payments_outlined,
                            color: Colors.white54, size: 14),
                        SizedBox(width: 6),
                        Text(
                          'الدفع عند الاستلام',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Copyright
            Container(
              color: const Color(0xFF080808),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => const Divider(color: Color(0xFF222222), thickness: 1);

  // ✅ كل العناصر center
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

  Widget _link(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13,
            color: Color(0xFF888888),
          ),
        ),
      );

  Widget _contactRow(IconData icon, String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // ✅ center
          mainAxisSize: MainAxisSize.min,
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
        ),
      );

  Widget _socialIcon(IconData icon) => Container(
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
