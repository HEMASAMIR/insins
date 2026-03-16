import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/di/injection.dart';
import 'package:insins/features/checkout/logic/cubit/checkout_cubit.dart';
import 'package:insins/features/shipping/logic/shipping_cubit/cubit/shipping_cubit.dart';
import 'package:insins/features/shipping/presentation/widgets/back_to_shop_button.dart';
import 'package:insins/features/shipping/presentation/widgets/custom_action_button.dart';
import 'package:insins/features/shipping/presentation/widgets/custom_checkout.dart';
import 'package:insins/features/shipping/presentation/widgets/price_row_widget.dart';

class OrderSummary extends StatefulWidget {
  final double totalPrice;
  final VoidCallback onBackToShop;
  final ShippingCubit shippingCubit;

  const OrderSummary({
    super.key,
    required this.totalPrice,
    required this.onBackToShop,
    required this.shippingCubit,
  });

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  bool isCheckingOut = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        border:
            Border(top: BorderSide(color: const Color(0xFFD4AF37), width: 3.h)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, -5))
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isCheckingOut)
              _buildSummaryView()
            else
              // الحل هنا: بنستخدم MultiBlocProvider عشان نوفر الـ 2 Cubits
              MultiBlocProvider(
                providers: [
                  // 1. بنوفر الـ ShippingCubit اللي جاي من الـ Constructor
                  BlocProvider.value(value: widget.shippingCubit),
                  // 2. بنوفر الـ CheckoutCubit باستخدام GetIt (sl)
                  BlocProvider(
                    create: (context) => sl<CheckoutCubit>(),
                  ),
                ],
                child: CheckoutViewBody(
                  onBack: () => setState(() => isCheckingOut = false),
                ),
              ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryView() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text("ملخص الطلب",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo')),
        ),
        SizedBox(height: 15.h),
        const Divider(thickness: 0.5),
        SizedBox(height: 15.h),
        PriceRowWidget(
          label: "الإجمالي:",
          price: "SAR ${widget.totalPrice.toStringAsFixed(0)}",
        ),
        SizedBox(height: 25.h),
        CustomActionButton(
          text: "إتمام الطلب",
          color: const Color(0xFF2DBB54),
          icon: Icons.check_circle,
          onTap: () => setState(() => isCheckingOut = true),
        ),
        SizedBox(height: 15.h),
        BackToShopButton(onTap: widget.onBackToShop),
      ],
    );
  }
}
