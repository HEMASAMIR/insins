import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/constants/app_constants.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final Function(dynamic)
      onExploreTap; // غيرنا النوع هنا عشان يستقبل القسم الفرعي

  const CategoryCard(
    this.category, {
    super.key,
    required this.onExploreTap,
  });

  String? _resolveImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return null;
    if (imageUrl.startsWith('http')) return imageUrl;
    return '${AppConstants.baseUrl}/$imageUrl';
  }

  Widget _placeholder() => Container(
        color: const Color(0xFFF9F9F9),
        child: Center(
          child:
              Icon(Icons.image_outlined, size: 24.sp, color: Colors.grey[300]),
        ),
      );

  Widget _buildLeadingImage(String? url) {
    final resolved = _resolveImage(url);
    return Container(
      width: 55.w,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: resolved == null
            ? _placeholder()
            : CachedNetworkImage(
                imageUrl: resolved,
                fit: BoxFit.cover,
                placeholder: (_, __) => _placeholder(),
                errorWidget: (_, __, ___) => _placeholder(),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        // عشان نشيل الخطوط اللي بتظهر تلقائياً في الـ ExpansionTile
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),

          // ── القسم الرئيسي (Leading على اليمين عشان العربي) ──
          leading: _buildLeadingImage(category.imageUrl),

          // ── اسم القسم ──
          title: Text(
            category.nameAr,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              fontFamily: 'Cairo',
              color: const Color(0xFF4A1D1D),
            ),
          ),

          // ── السهم ──
          trailing: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey[400],
            size: 24.sp,
          ),

          // ── الأقسام الفرعية (تظهر تحت بعض بالطول) ──
          children: category.subCategories.map((sub) {
            return Column(
              children: [
                const Divider(height: 1, color: Color(0xFFF5F5F5)),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
                  onTap: () => onExploreTap(sub),
                  title: Text(
                    sub.nameAr,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    'استكشف المجموعة ←',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: 'Cairo',
                      color: Colors.grey[400],
                    ),
                  ),
                  // صورة مصغرة جداً للقسم الفرعي لو موجودة
                  trailing: sub.imageUrl != null
                      ? CircleAvatar(
                          radius: 15.r,
                          backgroundColor: const Color(0xFFF9F9F9),
                          backgroundImage:
                              NetworkImage(_resolveImage(sub.imageUrl) ?? ''),
                        )
                      : null,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
