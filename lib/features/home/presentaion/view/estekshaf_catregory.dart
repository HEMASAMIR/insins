import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insins/core/router/routes.dart';
import 'package:insins/features/home/data/cart_model/cart_model.dart';
import 'package:insins/features/home/data/home_model/categories_model.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_cubit.dart';
import 'package:insins/features/home/logic/cubit/product_details/productdetails_state.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/custom_product_list.dart';

class CategoryDetailsPage extends StatefulWidget {
  final VoidCallback onBack;
  final CategoryModel category;
  final Function(dynamic) onProductTap;

  const CategoryDetailsPage({
    super.key,
    required this.category,
    required this.onProductTap,
    required this.onBack,
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

  // ✅ لما الـ category تتغير يعمل fetch جديد
  @override
  void didUpdateWidget(covariant CategoryDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category.id != widget.category.id) {
      context
          .read<ProductDetailsCubit>()
          .getProductsByCategoryId(widget.category.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                // ✅ بنجبره يقرأ من النسخة اللي في الـ Memory عشان لو الـ Context اتهز وأنت راجع
                bloc: context.read<ProductDetailsCubit>(),
                buildWhen: (previous, current) {
                  // ✅ بنقوله "اثبت مكانك" وما تعملش Rebuild للبياض
                  // فقط لو الحالة فيها داتا أو تحميل أو خطأ
                  return current is ProductDetailsLoaded ||
                      current is ProductDetailsLoading ||
                      current is ProductDetailsError;
                },
                builder: (context, state) {
                  if (state is ProductDetailsLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFF2DBB54)));
                  }

                  if (state is ProductDetailsLoaded) {
                    if (state.products.isEmpty) return _buildEmptyState();

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      itemCount: state.products.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.products.length) {
                          return const FooterWidget();
                        }

                        final currentProduct = state.products[index];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: VerticalProductCard(
                            product: currentProduct,
                            onAdd: () {
                              final cartItem = CartItemModel(
                                id: currentProduct.id.toString(),
                                name: currentProduct.nameAr,
                                price: double.parse(
                                    currentProduct.price.toString()),
                                image: currentProduct.imageUrl.toString(),
                                quantity: 1,
                              );
                              context.read<CartCubit>().addToCart(cartItem);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "تم إضافة ${currentProduct.nameAr} للسلة"),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            onTap: () {
                              context.push(
                                AppRoutes.productDetailsScreen,
                                extra: currentProduct,
                              );
                            },
                          ),
                        );
                      },
                    );
                  }

                  if (state is ProductDetailsError) {
                    return Center(child: Text("خطأ: ${state.message}"));
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBack,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Colors.green,
            ),
          ),
          Expanded(
            child: Text(
              widget.category.nameAr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          SizedBox(width: 48.w),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 60.sp, color: Colors.grey),
          SizedBox(height: 10.h),
          Text("لا توجد منتجات حالياً",
              style: TextStyle(fontFamily: 'Cairo', fontSize: 16.sp)),
        ],
      ),
    );
  }
}
