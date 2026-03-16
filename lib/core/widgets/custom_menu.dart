// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:insins/core/widgets/category_sub_section.dart';
// import 'package:insins/core/widgets/menu_header.dart';
// import 'package:insins/core/widgets/menu_section_header.dart';
// import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';

// class CategoryMenuWidget extends StatelessWidget {
//   final Function(int categoryId, String categoryName) onCategorySelected;

//   const CategoryMenuWidget({
//     super.key,
//     required this.onCategorySelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: SafeArea(
//           bottom: false,
//           child: Column(
//             children: [
//               const MenuHeader(title: 'الأقسام'),
//               Expanded(
//                 child: BlocBuilder<CategorieCubit, CategorieState>(
//                   builder: (context, state) {
//                     if (state is CategoriesLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(color: Colors.white),
//                       );
//                     }

//                     if (state is CategoriesLoaded) {
//                       final categories = state.categories;

//                       return SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: Column(
//                           children: [
//                             MenuSectionHeader(
//                               title: "جميع المنتجات",
//                               fontSize: 13.sp,
//                               onTap: () {
//                                 debugPrint("🚀 اختار: جميع المنتجات | ID: 0");
//                                 onCategorySelected(0, 'جميع المنتجات');
//                                 Navigator.pop(context);
//                               },
//                             ),
//                             ...categories.map((category) {
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   MenuSectionHeader(
//                                     title: category.nameAr,
//                                     fontSize: 13.sp,
//                                   ),
//                                   CategorySubSection(
//                                     items: category.subCategories
//                                         .map((sub) => sub.nameAr)
//                                         .toList(),
//                                     onItemTap: (itemName) {
//                                       final selectedSub =
//                                           category.subCategories.firstWhere(
//                                         (sub) => sub.nameAr == itemName,
//                                       );
//                                       debugPrint(
//                                           "✅ اختار: ${selectedSub.nameAr} | ID: ${selectedSub.id}");
//                                       onCategorySelected(
//                                         selectedSub.id,
//                                         selectedSub.nameAr,
//                                       );
//                                       Navigator.pop(context);
//                                     },
//                                   ),
//                                 ],
//                               );
//                             }).toList(),
//                             SizedBox(height: 50.h),
//                           ],
//                         ),
//                       );
//                     }

//                     return const Center(
//                       child: Text(
//                         "خطأ في تحميل البيانات",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/widgets/category_sub_section.dart';
import 'package:insins/core/widgets/menu_header.dart';
import 'package:insins/core/widgets/menu_section_header.dart';
import 'package:insins/features/home/logic/categories_cubit/cubit/categories_cubit.dart';

class CategoryMenuWidget extends StatelessWidget {
  final Function(int categoryId, String categoryName) onCategorySelected;

  const CategoryMenuWidget({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const MenuHeader(title: 'الأقسام'),
              Expanded(
                child: BlocBuilder<CategorieCubit, CategorieState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    if (state is CategoriesLoaded) {
                      final categories = state.categories;

                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            MenuSectionHeader(
                              title: "جميع المنتجات",
                              fontSize: 13.sp,
                              onTap: () {
                                debugPrint("🚀 اختار: جميع المنتجات | ID: 0");
                                onCategorySelected(0, 'جميع المنتجات');
                                Navigator.pop(context);
                              },
                            ),
                            ...categories.map((category) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MenuSectionHeader(
                                    title: category.nameAr,
                                    fontSize: 13.sp,
                                  ),
                                  CategorySubSection(
                                    items: category.subCategories
                                        .map((sub) => sub.nameAr)
                                        .toList(),
                                    onItemTap: (itemName) {
                                      final selectedSub =
                                          category.subCategories.firstWhere(
                                        (sub) => sub.nameAr == itemName,
                                      );
                                      debugPrint(
                                          "✅ اختار: ${selectedSub.nameAr} | ID: ${selectedSub.id}");
                                      onCategorySelected(
                                        selectedSub.id,
                                        selectedSub.nameAr,
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            }).toList(),
                            SizedBox(height: 50.h),
                          ],
                        ),
                      );
                    }

                    return const Center(
                      child: Text(
                        "خطأ في تحميل البيانات",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
