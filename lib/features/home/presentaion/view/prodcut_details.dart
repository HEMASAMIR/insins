import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductDetailsModel product;
  final Function(dynamic) onTap;
  const ProductDetailsView(
      {super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // مسافة عشان الـ AppBar الشفاف ميتغطاش
          SizedBox(height: 120.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // صورة المنتج
                Container(
                  height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Image.network(
                    "https://incense-sa.com/${product.imageUrl}",
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                ),
                SizedBox(height: 25.h),

                // اسم المنتج
                Text(
                  product.nameAr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    color: const Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 10.h),

                // السعر
                Text(
                  "${product.price.toStringAsFixed(2)} ر.س",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Cairo',
                    color: const Color(0xFF2ECC71),
                  ),
                ),

                SizedBox(height: 30.h),

                // زر الإضافة للسلة (نفس ستايل الموقع)
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF35302C),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text(
                      "إضافة للسلة",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),

          // الفوتر ثابت في نهاية الصفحة
          const FooterWidget(),
        ],
      ),
    );
  }
}
