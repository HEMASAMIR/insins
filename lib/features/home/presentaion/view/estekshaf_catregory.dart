import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_cubit.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_state.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/details_product_card.dart';

class CategoryDetailsPage extends StatefulWidget {
  final CategoryModel category;
  // ✅ الخطوة الناقصة: تعريف الدالة هنا عشان تقدر تنادي عليها بـ widget.onProductTap
  final Function(dynamic) onProductTap;

  const CategoryDetailsPage({
    super.key,
    required this.category,
    required this.onProductTap, // ✅ لازم تكون مطلوب في الـ constructor
  });

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailsCubit>()
        .getProductsByCategoryId(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const PageStorageKey('category_details'),
      child: Column(
        children: [
          SizedBox(height: 200.h),
          _buildHeader(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
            child: Column(
              children: [
                BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                  builder: (context, state) {
                    String countText = "جاري التحميل...";
                    if (state is ProductDetailsLoaded) {
                      countText = "${state.products.length} منتج";
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          countText,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey[600],
                              fontFamily: 'Cairo'),
                        ),
                        Text(
                          "جميع المنتجات",
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo'),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 15.h),
                const Divider(thickness: 0.5),
                SizedBox(height: 25.h),

                // قائمة المنتجات
                BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                  builder: (context, state) {
                    if (state is ProductDetailsLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                              color: Color(0xFF2ECC71)),
                        ),
                      );
                    } else if (state is ProductDetailsLoaded) {
                      if (state.products.isEmpty) {
                        return _buildEmptyState();
                      }

                      // ... الـ imports زي ما هي

// داخل الـ ListView.builder في صفحة CategoryDetailsPage
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ProductDetailsView(
                            // ✅ نستخدم الكارت هنا
                            product: state.products[index],
                            onTap: () =>
                                widget.onProductTap(state.products[index]),
                          );
                        },
                      );
                    } else if (state is ProductDetailsError) {
                      return Center(child: Text("خطأ: ${state.message}"));
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          const FooterWidget(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Icon(Icons.inbox_outlined, size: 45.sp, color: Colors.grey[400]),
        SizedBox(height: 10.h),
        Text("عذراً لم نجد نتائج",
            style: TextStyle(
                fontSize: 13.sp, color: Colors.grey[500], fontFamily: 'Cairo')),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff35302c), Color(0xff3a3732)],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text("المتجر",
              style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo')),
          SizedBox(height: 10.h),
          Text("اكتشف عبق الفخامة والأصالة في مكان واحد",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                  fontFamily: 'Cairo')),
        ],
      ),
    );
  }
}
