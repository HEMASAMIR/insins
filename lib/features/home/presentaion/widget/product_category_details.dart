import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/constants/app_constants.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';

class ProductCategoriesCard extends StatelessWidget {
  final ProductDetailsModel product;

  const ProductCategoriesCard({required this.product, super.key});

  String get _imageUrl {
    final img = product.imageUrl;
    if (img == null || img.isEmpty) return '';
    if (img.startsWith('http')) return img;
    return '${AppConstants.baseUrl}/$img';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFEAEAEA)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        // ✅ Column بـ mainAxisSize.max داخل Container محدود الحجم من الـ Grid
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ── الصورة - Expanded عشان تاخد الجزء الأكبر ──
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: SizedBox(
                  width: double.infinity,
                  child: _imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: _imageUrl,
                          fit: BoxFit.contain,
                          placeholder: (_, __) => const Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.black12),
                          ),
                          errorWidget: (_, __, ___) => _placeholder(),
                        )
                      : _placeholder(),
                ),
              ),
            ),

            // ── الاسم والسعر - Expanded عشان يملأ الباقي بدون overflow ──
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // الاسم
                    Text(
                      product.nameAr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Cairo',
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),

                    // السعر
                    Text(
                      '${product.price.toStringAsFixed(2)} ر.س',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Cairo',
                        color: Colors.black,
                      ),
                    ),

                    // ── زر إضافة للسلة ──
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          elevation: 0,
                          // ✅ padding صغير عشان الزرار ما يكبرش أوي
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        icon: Icon(Icons.shopping_cart_outlined,
                            size: 12.sp, color: Colors.white),
                        label: Text(
                          'أضف للسلة',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontFamily: 'Cairo',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() => const ColoredBox(
        color: Color(0xFFF5F5F5),
        child: Center(
          child: Icon(Icons.image_not_supported_outlined, color: Colors.grey),
        ),
      );
}
