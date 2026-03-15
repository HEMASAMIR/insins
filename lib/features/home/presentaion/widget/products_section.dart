import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/logic/cubit/homecubit_cubit.dart';
import 'package:insins/features/home/logic/cubit/homecubit_state.dart';
import 'package:insins/features/home/presentaion/widget/custom_product_shimmer.dart';
import 'package:insins/features/home/presentaion/widget/product_card.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const ProductsShimmer();
        }

        if (state is ProductsLoaded) {
          // التعديل هنا: نستخدم ListView عشان الكروت تنزل تحت بعضها (طولية)
          return ListView.builder(
            shrinkWrap: true, // مهم عشان يشتغل جوه Column
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics:
                const NeverScrollableScrollPhysics(), // بنعتمد على Scroll الصفحة الكبيرة
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: state.products[index],
                onTap: () {
                  // الأكشن بتاعك هنا
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
