import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsProductImage extends StatelessWidget {
  final String imageUrl;
  const DetailsProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // ✅ encode الـ URL عشان المسافات والحروف العربية
    final String fullUrl = Uri.encodeFull("https://incense-sa.com/$imageUrl");

    return Container(
      width: double.infinity,
      height: 300.h,
      color: const Color(0xFFFBFBFB),
      child: CachedNetworkImage(
        imageUrl: fullUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.black12,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.image_not_supported_outlined,
          color: Colors.grey,
          size: 50,
        ),
      ),
    );
  }
}
