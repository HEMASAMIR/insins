import 'package:url_launcher/url_launcher.dart';

class WhatsAppHelper {
  static const String _phoneNumber = "966503606971";
  static const String _phone = "0503606971";

  // ✅ للمنتجات
  static Future<void> sendMessage({
    required String productName,
    required double price,
  }) async {
    final String message =
        "السلام عليكم، أنا مهتم بمنتج: $productName\nالسعر: $price ر.س";

    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/$_phoneNumber?text=${Uri.encodeFull(message)}");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    }
  }

  // ✅ للاستفسار العام
  static Future<void> sendGeneralMessage() async {
    const String message = "السلام عليكم، أريد الاستفسار";

    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/$_phoneNumber?text=${Uri.encodeFull(message)}");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    }
  }

  // ✅ للاتصال
  static Future<void> call() async {
    final Uri phoneUrl = Uri.parse("tel:$_phone");
    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    }
  }
}
