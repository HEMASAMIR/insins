import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/data/home_model/product_details_model.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductDetailsModel product;
  // ✅ ضفنا callback عشان لما يدوس رجوع يبلغ الصفحة الرئيسية تغير الـ Index
  final VoidCallback? onTap;

  const ProductDetailsView({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    const String baseUrl = "https://incense-sa.com/";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. قسم الصورة مع زرار الرجوع
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        baseUrl + (product.imageUrl ?? ""),
                        height: 350.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.image_not_supported,
                            size: 50.sp,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  // ✅ زرار الرجوع الشفاف
                  Positioned(
                    top: 25.h,
                    right: 25.w, // جهة اليمين عشان التطبيق عربي
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                              )
                            ]),
                        child: Icon(Icons.arrow_forward_ios,
                            size: 18.sp, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.categoryName ?? "مكياج",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      product.nameAr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "${product.price.toStringAsFixed(2)} ر.س",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Cairo',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 25.h),

                    // بوكس التفاصيل
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "تفاصيل المنتج",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            product.descriptionAr ??
                                "هذا المنتج يوفر تغطية مثالية ونتائج احترافية، مناسب للاستخدام اليومي ويمنحك مظهرًا طبيعيًا وجذابًا.",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                              fontFamily: 'Cairo',
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // أزرار الإضافة والكمية
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2ECC71),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Text(
                                "إضافة للسلة",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Text("1",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
