// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class TestimonialsSection extends StatelessWidget {
//   final Color goldColor;

//   const TestimonialsSection({super.key, required this.goldColor});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
//       child: Column(
//         children: [
//           _buildSectionHeader("ماذا قالوا عن", "إنسينس"),
//           SizedBox(height: 20.h),
//           SizedBox(
//             height: 180.h,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               // أضفت خاصية Bouncing لمظهر أكثر سلاسة عند السحب
//               physics: const BouncingScrollPhysics(),
//               children: [
//                 _testimonialCard(
//                   "نورة العتيبي",
//                   "رائحة العود عندهم تأخذك لعالم آخر، والثبات مذهل جداً.",
//                 ),
//                 _testimonialCard(
//                   "فهد الشمري",
//                   "عطور الشعر والجمال دائماً خياري الأول، التغليف فخم جداً.",
//                 ),
//                 _testimonialCard(
//                   "سارة محمد",
//                   "تجربة رائعة من البداية للنهاية، المنتجات أصلية والتعامل راقي جداً.",
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ميثود بناء الهيدر داخل الويدجت
//   Widget _buildSectionHeader(String lightText, String goldText) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "$lightText ",
//               style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               goldText,
//               style: TextStyle(
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.bold,
//                 color: goldColor,
//               ),
//             ),
//           ],
//         ),
//         Container(
//           height: 2.h,
//           width: 50.w,
//           color: goldColor,
//           margin: EdgeInsets.only(top: 8.h),
//         ),
//       ],
//     );
//   }

//   // ميثود بناء الكارت الصغير
//   Widget _testimonialCard(String name, String comment) {
//     return Container(
//       width: 280.w,
//       margin: EdgeInsets.only(left: 15.w, bottom: 5.h, top: 5.h),
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Icon(
//             FontAwesomeIcons.quoteRight,
//             color: Colors.orangeAccent,
//             size: 20,
//           ),
//           SizedBox(height: 10.h),
//           Expanded(
//             child: Text(
//               comment,
//               style: TextStyle(
//                 fontStyle: FontStyle.italic,
//                 fontSize: 13.sp,
//                 height: 1.4,
//               ),
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           Text(
//             name,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: goldColor,
//               fontSize: 14.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
