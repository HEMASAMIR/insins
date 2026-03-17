import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

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
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0D0D),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'الشحن والتوصيل',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header subtitle
              const Center(
                child: Text(
                  'كل ما تريد معرفته عن وصول عطورك المفضلة إليك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    color: Color(0xFF888888),
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Info Cards Row
              Row(
                children: [
                  Expanded(
                    child: _infoCard(
                      icon: Icons.access_time_rounded,
                      title: 'مدة التوصيل',
                      lines: const [
                        'داخل المملكة: 3–6 أيام عمل',
                        'منطقة القصيم: 24–48 ساعة',
                        'مناطق أخرى: 3–5 أيام عمل',
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _infoCard(
                      icon: Icons.local_shipping_outlined,
                      title: 'تكلفة الشحن',
                      lines: const [
                        'شحن مجاني للطلبات فوق 500 ريال',
                        'الطلبات الأخرى تخضع لرسوم شركة الشحن حسب المنطقة',
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Shipping Partners
              _sectionCard(
                title: 'شركاء النجاح',
                icon: Icons.handshake_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'نتعامل مع أفضل الشركات لضمان وصول العطور بأمان',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: Color(0xFF888888),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _partnerBadge('سمسا', 'SMSA'),
                        _partnerBadge('أرامكس', 'Aramex'),
                        _partnerBadge('سبل', 'SPL'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Tracking Section
              _sectionCard(
                title: 'كيف أتتبع طلبي؟',
                icon: Icons.pin_drop_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textDirection: TextDirection.rtl,
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          color: Color(0xFF888888),
                          height: 1.6,
                        ),
                        children: [
                          TextSpan(text: 'بعد إتمام الطلب، سيصلك '),
                          TextSpan(
                            text: 'رقم التتبع',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  ' عبر الواتساب فور تسليم الشحنة لشركة الشحن.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Tracking links
                    _trackingButton(
                      label: 'تتبع عبر SMSA',
                      url: 'https://www.smsaexpress.com/ar/tracking',
                      color: const Color(0xFF1B5E20),
                    ),
                    const SizedBox(height: 8),
                    _trackingButton(
                      label: 'تتبع عبر Aramex',
                      url: 'https://www.aramex.com/ar/track/shipments',
                      color: const Color(0xFF7B2D00),
                    ),
                    const SizedBox(height: 8),
                    _trackingButton(
                      label: 'تتبع عبر SPL (سبل)',
                      url: 'https://splonline.com.sa/ar/track/',
                      color: const Color(0xFF1A237E),
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Color(0xFF222222)),
                    const SizedBox(height: 12),
                    // WhatsApp CTA
                    GestureDetector(
                      onTap: () => _launchURL('https://wa.me/966503606971'),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF25D366)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.chat,
                                color: Color(0xFF25D366), size: 18),
                            SizedBox(width: 8),
                            Text(
                              'تتبع الطلب عبر واتساب',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13,
                                color: Color(0xFF25D366),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _infoCard({
    required IconData icon,
    required String title,
    required List<String> lines,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                line,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  color: Color(0xFF888888),
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(color: Color(0xFF2A2A2A)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _partnerBadge(String nameAr, String nameEn) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: Column(
        children: [
          Text(
            nameAr,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            nameEn,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trackingButton({
    required String label,
    required String url,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.open_in_new, color: Colors.white54, size: 14),
          ],
        ),
      ),
    );
  }
}
