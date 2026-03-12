import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/widgets/error_widget.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';
import 'package:insins/features/home/presentaion/widget/category_card.dart';
import 'package:insins/features/home/presentaion/widget/custom_shimmer.dart';

class CategoriesSection extends StatelessWidget {
  // 1. تعريف الدالة اللي هتستقبلها من الصفحة الكبيرة
  final Function(CategoryModel) onCategoryTap;

  const CategoriesSection({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        children: [
          // ── العنوان ──────────────────────────────
          Text(
            'مجموعات إنسينس الحصرية',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'نقدم لكم خلاصة خبرتنا في العطور والعود والجمال',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 30.h),

          // ── القائمة ──────────────────────────────
          BlocBuilder<CategorieCubit, CategorieState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const CategoriesShimmer();
              }

              if (state is CategorriesError) {
                return CustomErrorWidget(
                  message: state.message,
                  onRetry: () =>
                      context.read<CategorieCubit>().fetchCategories(),
                );
              }

              if (state is CategoriesLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final CategoryModel cat = state.categories[index];

                    // 2. التعديل هنا: بنمرر القسم والدالة اللي هتفتحه
                    return CategoryCard(
                      cat,
                      onExploreTap: () => onCategoryTap(cat),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
