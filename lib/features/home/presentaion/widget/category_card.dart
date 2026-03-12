import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/constants/app_constants.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onExploreTap;
  const CategoryCard(this.category, {super.key, required this.onExploreTap});

  String? _resolveImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return null;
    if (imageUrl.startsWith('http')) return imageUrl;
    return '${AppConstants.baseUrl}/$imageUrl';
  }

  Widget _placeholder() => Container(
        color: const Color(0xFFF5F5F5),
        child: Center(
          child:
              Icon(Icons.image_outlined, size: 48.sp, color: Colors.grey[300]),
        ),
      );

  Widget _buildImage(String? url) {
    final resolved = _resolveImage(url);
    if (resolved == null) return _placeholder();
    return CachedNetworkImage(
      imageUrl: resolved,
      fit: BoxFit.cover,
      placeholder: (_, __) => const ColoredBox(color: Color(0xFFF9F9F9)),
      errorWidget: (_, __, ___) => _placeholder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ── الصورة ─────────────────────────────────
          Padding(
            padding: EdgeInsets.all(16.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                height: 260.h,
                width: double.infinity,
                child: _buildImage(category.imageUrl),
              ),
            ),
          ),

          Divider(height: 1, color: const Color(0xFFE8E8E8)),

          // ── الاسم + استكشف ──────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  category.nameAr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Cairo',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),

                // ── onTap → ProductsListScreen ──────────
                InkWell(
                  // هنا بننادي على الدالة اللي استلمناها في الـ Constructor
                  onTap: onExploreTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 14.sp,
                        color: Colors.grey[400],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'استكشف المجموعة',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Cairo',
                          color: Colors.grey[400],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
