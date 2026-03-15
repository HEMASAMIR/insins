import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:insins/core/di/injection.dart';
import 'package:insins/core/widgets/cart_dialog.dart';
import 'package:insins/core/widgets/custom_app_bar.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_state.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/presentaion/widget/order_summary.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback? onBackToShop;
  const CartScreen({super.key, this.onBackToShop});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<CartCubit>(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: const Color(0xFFFBFBFB),
          appBar: CustomAppBar(),
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                    child: CircularProgressIndicator(color: AppColors.gold));
              }
              if (state is CartLoaded) {
                if (state.items.isEmpty) return _buildEmptyCart(context);
                return _buildCartContent(context, state);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartLoaded state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildHeader(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: state.items.map((item) {
                final String imageUrl = item.image.startsWith('http')
                    ? item.image
                    : 'https://incense-sa.com/${item.image}';
                return _buildCartItem(context, item, imageUrl);
              }).toList(),
            ),
          ),
          SizedBox(height: 50.h),
          OrderSummary(
            totalPrice: state.totalPrice,
            onCheckout: () {},
            onBackToShop: () {
              if (onBackToShop != null) {
                onBackToShop!();
              } else {
                Navigator.pop(context);
              }
            },
          ),
          const FooterWidget(),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 80.h),
          Icon(Icons.shopping_cart_outlined,
              size: 80.sp, color: Colors.grey[300]),
          SizedBox(height: 20.h),
          Text(
            "سلة المشتريات فارغة حالياً",
            style: TextStyle(
                fontFamily: 'Cairo', fontSize: 18.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
            onPressed: onBackToShop ?? () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            child: const Text("ابدأ التسوق الآن",
                style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
          SizedBox(height: 100.h),
          const FooterWidget(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(
        top: kToolbarHeight + 120.h, // ✅ عشان ميتغطاش بالـ AppBar
        bottom: 20.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'سلة المشتريات',
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo'),
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, dynamic item, String imageUrl) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(12.r)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                Uri.encodeFull(imageUrl),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo')),
                SizedBox(height: 5.h),
                Text('SAR ${item.price}',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              bool? confirm = await CartDialogs.showDeleteConfirmation(context);
              if (confirm == true) {
                if (context.mounted) {
                  context.read<CartCubit>().removeFromCart(item.id);
                  CartDialogs.showDeletedSuccess(context);
                }
              }
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                children: [
                  Icon(Icons.delete, color: Colors.red[400], size: 22.sp),
                  Text("حذف",
                      style: TextStyle(
                          color: Colors.red[400],
                          fontSize: 11.sp,
                          fontFamily: 'Cairo')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
