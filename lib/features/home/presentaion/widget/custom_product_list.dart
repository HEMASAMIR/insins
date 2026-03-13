import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalProductCard extends StatelessWidget {
  final dynamic product;
  final VoidCallback onAdd;
  final VoidCallback onTap;

  const VerticalProductCard({
    super.key,
    required this.product,
    required this.onAdd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. الصورة في المنتصف
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
              child: AspectRatio(
                aspectRatio: 1.1,
                child: Image.network(
                  "https://incense-sa.com/${product.imageUrl}",
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_not_supported,
                    size: 50.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 2. الاسم في المنتصف
                  Text(
                    product.nameAr ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: const Color(0xFF4A1D1D),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // 3. السعر في المنتصف
                  Text(
                    "${product.price} ر.س",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Cairo',
                      color: const Color(0xFFD4A056),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  // 4. زر الإضافة (واخد العرض كله)
                  SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: ElevatedButton.icon(
                      onPressed: onAdd, // هنا بينفذ إضافة للسلة بس
                      icon: Icon(Icons.add_shopping_cart,
                          color: Colors.white, size: 18.sp),
                      label: Text(
                        "إضافة للسلة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2DBB54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
