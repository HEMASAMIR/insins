import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/constants/app_constants.dart';
import 'package:insins/core/widgets/error_widget.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';
import 'package:insins/features/home/presentaion/widget/custom_shimmer.dart';

class CategoriesSection extends StatelessWidget {
  final Function(dynamic) onCategoryTap;
  final Function(dynamic) onSubCategoryTap;
  const CategoriesSection({
    super.key,
    required this.onCategoryTap,
    required this.onSubCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 30.h),
          BlocBuilder<CategorieCubit, CategorieState>(
            builder: (context, state) {
              if (state is CategoriesLoading) return const CategoriesShimmer();

              if (state is CategorriesError) {
                return CustomErrorWidget(
                  message: state.message,
                  onRetry: () =>
                      context.read<CategorieCubit>().fetchCategories(),
                );
              }

              if (state is CategoriesLoaded) {
                // تجميع كل الـ Subcategories في قائمة واحدة للعرض لاحقاً
                final List<SubCategoryModel> allSubCategories = state.categories
                    .expand((cat) => cat.subCategories ?? <SubCategoryModel>[])
                    .toList();

                return Column(
                  children: [
                    // ── أولاً: عرض الأقسام الرئيسية ────────────────
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) => _buildCategoryLargeCard(
                          context, state.categories[index]),
                    ),

                    // فاصل جمالي بين القسمين
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child:
                          const Divider(color: Color(0xFFF5F5F5), thickness: 8),
                    ),

                    // ── ثانياً: عرض الأقسام الفرعية (تسوق الآن) ──────
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: allSubCategories.length,
                      itemBuilder: (context, index) =>
                          _buildSubCategoryActionCard(
                              context, allSubCategories[index]),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  // 1. الكارت الأصلي للأقسام الرئيسية
  Widget _buildCategoryLargeCard(BuildContext context, CategoryModel category) {
    final String? resolvedImageUrl = category.imageUrl != null
        ? '${AppConstants.baseUrl}/${category.imageUrl}'
        : null;

    return GestureDetector(
      onTap: () => onCategoryTap(category),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildImageWidget(resolvedImageUrl, 280.h),
            _buildCardFooter(category.nameAr, 'استكشف المجموعة'),
          ],
        ),
      ),
    );
  }

  // 2. الكارت الجديد للأقسام الفرعية مع زرار "تسوق الآن"
  Widget _buildSubCategoryActionCard(
      BuildContext context, SubCategoryModel subCat) {
    final String? resolvedImageUrl = subCat.imageUrl != null
        ? '${AppConstants.baseUrl}/${subCat.imageUrl}'
        : null;

    return Container(
      margin: EdgeInsets.only(bottom: 25.h),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'مجموعاتنا الفاخرة',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'اكتشف تشكيلتنا المختارة من العطور والجمال والعود',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          _buildImageWidget(resolvedImageUrl, 300.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              children: [
                Text(
                  subCat.nameAr,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
                SizedBox(height: 15.h),
                ElevatedButton(
                  onPressed: () => onSubCategoryTap(subCat),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(160.w, 45.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)),
                  ),
                  child: Text('تسوق الآن',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'Cairo')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // مساعدات التصميم (لتجنب تكرار الكود)
  BoxDecoration _cardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      );

  Widget _buildImageWidget(String? url, double height) => ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: url != null
              ? CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => _placeholderIcon())
              : _placeholderIcon(),
        ),
      );

  Widget _buildCardFooter(String title, String subtitle) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Cairo')),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[400],
                        fontFamily: 'Cairo')),
                Icon(Icons.arrow_back_ios_new_rounded,
                    size: 14.sp, color: Colors.grey[400]),
              ],
            ),
          ],
        ),
      );

  Widget _buildHeader() => Column(
        children: [
          Text('مجموعات إنسينس الحصرية',
              style: TextStyle(
                  color: const Color(0xFF4A1D1D),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Cairo')),
          SizedBox(height: 8.h),
          Text('نقدم لكم خلاصة خبرتنا في العطور والعود والجمال',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                  fontFamily: 'Cairo')),
        ],
      );

  Widget _placeholderIcon() => Container(
        color: const Color(0xFFF9F9F9),
        child: Center(
            child: Icon(Icons.image_not_supported_outlined,
                size: 40.sp, color: Colors.grey[300])),
      );
}
