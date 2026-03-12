import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insins/core/constants/app_constants.dart';

class ProductCardWidget extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String name;
  final double price;
  final VoidCallback onAddToCart;

  const ProductCardWidget({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.name,
    required this.price,
    required this.onAddToCart,
    void Function()? onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String fullImageUrl = "${AppConstants.baseUrl}/${imageUrl.trim()}";

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── صورة المنتج
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  // ✅ استخدام الرابط الكامل الذي تم تجهيزه
                  imageUrl: fullImageUrl,
                  fit: BoxFit
                      .contain, // BoxFit.contain أفضل لصور المنتجات لعدم قص الأطراف
                  placeholder: (context, url) => Container(
                    color: const Color(0xFFF5F0EB),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFCCBB99),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    // طباعة الخطأ في الـ Console لمعرفة السبب إذا لم تظهر الصورة
                    debugPrint("Error loading image: $url");
                    return Container(
                      color: const Color(0xFFF5F0EB),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Color(0xFFCCBB99),
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── بيانات المنتج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      color: Color(0xFF999999),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A0A00),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('﷼',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF333333))),
                      const SizedBox(width: 4),
                      Text(
                        price.toStringAsFixed(2),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: ElevatedButton.icon(
                      onPressed: onAddToCart,
                      icon: const Icon(Icons.shopping_cart, size: 16),
                      label: const Text(
                        'إضافة للسلة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3CB371),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
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
}
