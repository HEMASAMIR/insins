import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class WhatsAppHelper {
  static const String _phoneNumber = "966503606971";
  static const String _phone = "0503606971";

  // ✅ دالة موحدة لفتح الواتساب بشكل احترافي
  static Future<void> _launchWhatsApp(String message) async {
    final String encodedMsg = Uri.encodeComponent(message);

    // رابط الأندرويد (بيفتح التطبيق مباشرة)
    final Uri whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$_phoneNumber&text=$encodedMsg");

    // رابط iOS والمتصفح (Fallback)
    final Uri whatsappUniversal =
        Uri.parse("https://wa.me/$_phoneNumber?text=$encodedMsg");

    try {
      if (Platform.isAndroid) {
        // محاولة فتح التطبيق مباشرة
        await launchUrl(whatsappAndroid, mode: LaunchMode.externalApplication);
      } else {
        // في iOS الـ universal link شغال زي الفل
        await launchUrl(whatsappUniversal,
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // لو فشل (مثلاً التطبيق مش موجود) يفتح المتصفح
      await launchUrl(whatsappUniversal, mode: LaunchMode.platformDefault);
    }
  }

  // ✅ للمنتجات
  static Future<void> sendMessage({
    required String productName,
    required double price,
  }) async {
    final String message =
        "السلام عليكم، أنا مهتم بمنتج: $productName\nالسعر: $price ر.س";
    await _launchWhatsApp(message);
  }

  // ✅ للاستفسار العام
  static Future<void> sendGeneralMessage() async {
    const String message = "السلام عليكم، أريد الاستفسار";
    await _launchWhatsApp(message);
  }

  // ✅ للاتصال
  static Future<void> call() async {
    final Uri phoneUrl = Uri.parse("tel:$_phone");
    try {
      // الـ tel: دايماً بنستخدم معاها LaunchMode.externalApplication عشان يفتح لوحة الاتصال
      await launchUrl(phoneUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Could not launch call: $e");
    }
  }
}
