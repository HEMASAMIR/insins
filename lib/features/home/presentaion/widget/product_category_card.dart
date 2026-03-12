// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // ✅ ضفنا دي
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:insins/features/home/data/home_model/categories_model.dart';
// import 'package:insins/features/home/logic/cubit/product_details/productdetails_cubit.dart';
// import 'package:insins/features/home/presentaion/widget/product_category_details.dart';

// class CategoryCard extends StatelessWidget {
//   final CategoryModel category;
//   const CategoryCard(this.category, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: const Color(0xFFE8E8E8)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           // ── الصورة ───────────────────────────────
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8.r),
//               child: SizedBox(
//                 height: 260.h,
//                 width: double.infinity,
//                 child: _buildImage(category.imageUrl),
//               ),
//             ),
//           ),
//           Divider(height: 1, color: const Color(0xFFE8E8E8)),
//           // ── الاسم + استكشف ───────────────────────
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   category.nameAr,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.w800,
//                     fontFamily: 'Cairo',
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//                 InkWell(
//                 onTap: () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => BlocProvider(
//         // بنستخدم sl (GetIt) بتاعك عشان نجيب الـ Cubit ونطلب البيانات فوراً
//         create: (context) => sl<ProductDetailsCubit>()..getProductsByCategory(category.id),
//         child: CategoryProductsView(categoryName: category.nameAr),
//       ),
//     ),
//   );
// }
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.arrow_back,
//                           size: 14.sp, color: Colors.grey[400]),
//                       SizedBox(width: 4.w),
//                       Text(
//                         "استكشف المجموعة",
//                         style: TextStyle(
//                           fontSize: 13.sp,
//                           fontFamily: 'Cairo',
//                           color: Colors.grey[400],
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
