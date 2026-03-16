// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:insins/features/checkout/data/models/order_model.dart';
// import 'package:insins/features/checkout/logic/cubit/checkout_cubit.dart';
// import 'package:insins/features/checkout/logic/cubit/checkout_state.dart';
// import 'package:insins/features/checkout/data/models/checkout_model.dart';
// import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
// import 'package:insins/features/home/logic/cart_cubit/cubit/cart_state.dart';
// import 'package:insins/features/shipping/logic/shipping_cubit/cubit/shipping_cubit.dart';
// import 'package:insins/features/shipping/logic/shipping_cubit/cubit/shipping_state.dart';
// import 'package:insins/features/shipping/presentation/widgets/shippin_form.dart';
// import 'package:insins/features/shipping/presentation/widgets/payment_method.dart';
// import 'package:insins/features/shipping/presentation/widgets/custom_action_button.dart';

// // حولناها لـ StatefulWidget عشان نعرف نتحكم في الـ Controllers
// class CheckoutViewBody extends StatefulWidget {
//   final VoidCallback onBack;

//   const CheckoutViewBody({
//     super.key,
//     required this.onBack,
//   });

//   @override
//   State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
// }

// class _CheckoutViewBodyState extends State<CheckoutViewBody> {
//   // 1. تعريف الـ Controllers هنا عشان نسحب منهم القيم وقت الضغط على الزرار
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CheckoutCubit, CheckoutState>(
//       listener: (context, state) {
//         if (state is CheckoutSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//                 content: Text("تم تأكيد طلبك بنجاح!"),
//                 backgroundColor: Colors.green),
//           );
//           // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
//         }

//         if (state is CheckoutFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 state.errMessage.contains("timeout")
//                     ? "عذراً، الاتصال بالخادم ضعيف حالياً"
//                     : state.errMessage,
//                 style: const TextStyle(fontFamily: 'Cairo'),
//               ),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         return SingleChildScrollView(
//           // عشان الكيبورد لما يفتح
//           child: Column(
//             children: [
//               // 2. مرر الـ Controllers للـ ShippingForm (تأكد من تعديل الـ Constructor هناك ليقبلهم)
//               ShippingForm(
//                 nameController: nameController,
//                 phoneController: phoneController,
//                 addressController: addressController,
//               ),

//               SizedBox(height: 25.h),
//               const PaymentSection(),
//               SizedBox(height: 25.h),

//               CustomActionButton(
//                 text: "تأكيد الطلب",
//                 color: const Color(0xFF1D1D1D),
//                 icon: Icons.arrow_forward,
//                 isLoading: state is CheckoutLoading,
//                 onTap: () {
//                   final shippingState = context.read<ShippingCubit>().state;
//                   final cartState = context.read<CartCubit>().state;

//                   if (shippingState is ShippingSuccess &&
//                       cartState is CartLoaded) {
//                     final selectedCity = shippingState.selectedCity;

//                     if (selectedCity != null) {
//                       // 3. بناء الـ Request باستخدام الـ Controllers مباشرة
//                       final request = CheckoutRequest(
//                         customerName: nameController.text, // من الـ Controller
//                         customerPhone:
//                             phoneController.text, // من الـ Controller
//                         city: selectedCity.cityName ?? "",
//                         address: addressController.text, // من الـ Controller
//                         paymentMethod: "cash", // أو هاته من اختيار المستخدم

//                         items: cartState.items
//                             .map((item) => OrderItem(
//                                   productId: int.tryParse(item.id.toString()) ??
//                                       0, // حل مشكلة int
//                                   quantity: item.quantity,
//                                   price:
//                                       double.tryParse(item.price.toString()) ??
//                                           0.0,
//                                   productName: item.name,
//                                 ))
//                             .toList(),
//                       );

//                       // تنفيذ الطلب
//                       context.read<CheckoutCubit>().submitOrder(request);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text("برجاء اختيار المدينة أولاً")),
//                       );
//                     }
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content:
//                               Text("تأكد من استكمال البيانات وجودة الإنترنت")),
//                     );
//                   }
//                 },
//               ),
//               SizedBox(height: 15.h),
//               TextButton(
//                 onPressed: widget.onBack,
//                 child: Text(
//                   "تعديل الطلب",
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     color: Colors.grey,
//                     fontSize: 14.sp,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/checkout/data/models/order_model.dart';
import 'package:insins/features/checkout/logic/cubit/checkout_cubit.dart';
import 'package:insins/features/checkout/logic/cubit/checkout_state.dart';
import 'package:insins/features/checkout/data/models/checkout_model.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_state.dart';
import 'package:insins/features/shipping/logic/shipping_cubit/cubit/shipping_cubit.dart';
import 'package:insins/features/shipping/logic/shipping_cubit/cubit/shipping_state.dart';
import 'package:insins/features/shipping/presentation/widgets/shippin_form.dart';
import 'package:insins/features/shipping/presentation/widgets/payment_method.dart';
import 'package:insins/features/shipping/presentation/widgets/custom_action_button.dart';

class CheckoutViewBody extends StatefulWidget {
  final VoidCallback onBack;
  const CheckoutViewBody({super.key, required this.onBack});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  // الكنترولرز بتوعنا عشان نسحب منهم الداتا للفورم
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("تم تأكيد الطلب بنجاح!"),
                backgroundColor: Colors.green),
          );
        }
        if (state is CheckoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.errMessage), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        // بنستخدم context.watch عشان الـ UI يتحدث أول ما نختار مدينة أو السعر يتغير
        final cartState = context.watch<CartCubit>().state;
        final shippingState = context.watch<ShippingCubit>().state;

        // حساب الحسبة الحقيقية
        double subtotal =
            (cartState is CartLoaded) ? cartState.totalPrice : 0.0;
        double shipping = (shippingState is ShippingSuccess)
            ? (shippingState.selectedCity?.price ?? 0.0)
            : 0.0;
        double total = subtotal + shipping;

        return SingleChildScrollView(
          child: Column(
            children: [
              ShippingForm(
                nameController: nameController,
                phoneController: phoneController,
                addressController: addressController,
              ),
              SizedBox(height: 20.h),
              const PaymentSection(),
              SizedBox(height: 30.h),

              // --- الجزء اللي رجعناه: ملخص الطلب ---
              _buildOrderSummary(subtotal, shipping, total),

              SizedBox(height: 20.h),

              CustomActionButton(
                text: "تأكيد الطلب",
                color: const Color(0xFF1D1D1D),
                icon: Icons.arrow_forward,
                isLoading: state is CheckoutLoading,
                onTap: () => _handleOrderSubmission(context),
              ),

              SizedBox(height: 10.h),
              TextButton(
                onPressed: widget.onBack,
                child: Text(
                  "تعديل الطلب",
                  style: TextStyle(
                      fontFamily: 'Cairo', color: Colors.grey, fontSize: 14.sp),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ويدجت ملخص الطلب اللي في الصورة
  Widget _buildOrderSummary(double subtotal, double shipping, double total) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "ملخص الطلب",
            style: TextStyle(
                fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const Text(
            "راجع منتجاتك قبل التأكيد",
            style: TextStyle(
                fontFamily: 'Cairo', color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 15.h),
          _summaryRow("المجموع الفرعي", "$subtotal ر.س"),
          SizedBox(height: 10.h),
          _summaryRow("الشحن", "$shipping ر.س"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(color: Colors.grey[200]),
          ),
          _summaryRow("الإجمالي", "$total ر.س", isTotal: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[700],
          ),
        ),
      ],
    );
  }

  void _handleOrderSubmission(BuildContext context) {
    final shippingState = context.read<ShippingCubit>().state;
    final cartState = context.read<CartCubit>().state;

    if (shippingState is ShippingSuccess && cartState is CartLoaded) {
      final request = CheckoutRequest(
        customerName: nameController.text,
        customerPhone: phoneController.text,
        city: shippingState.selectedCity?.cityName ?? "",
        address: addressController.text,
        paymentMethod: "Cash",
        items: cartState.items
            .map((e) => OrderItem(
                  productId: int.parse(e.id.toString()),
                  quantity: e.quantity,
                  price: e.price,
                  productName: e.name,
                ))
            .toList(),
      );
      context.read<CheckoutCubit>().submitOrder(request);
    }
  }
}
