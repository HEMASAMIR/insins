import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/core/constants/app_colors.dart';
import 'package:insins/core/di/injection.dart';
import 'package:insins/core/widgets/custom_app_bar.dart';
import 'package:insins/features/home/presentaion/view/cart_screen.dart';
import 'package:insins/features/home/presentaion/widget/custom_footer.dart';
import 'package:insins/features/home/logic/cart_cubit/cubit/cart_cubit.dart';

class PolicyScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const PolicyScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<CartCubit>(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          appBar: CustomAppBar(
            onCartTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // ── الهيدر ──────────────────────────────────────────
                Stack(
                  children: [
                    Container(
                      height: 220.h,
                      width: double.infinity,
                      child: Image.network(
                        'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=800&fit=crop',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    // overlay
                    Container(
                      height: 220.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    // النص
                    Container(
                      height: 220.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'السياسات والخصوصية',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'كل ما يخص حقوقكم وشروط الاستخدام لدينا',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Cairo',
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Container(
                            width: 60.w,
                            height: 2.h,
                            color: AppColors.gold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // ── البطاقات ─────────────────────────────────────────
                Transform.translate(
                  offset: Offset(0, -20.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        _buildPolicyCard(
                          icon: Icons.swap_horiz_rounded,
                          title: 'سياسة الاستبدال والاسترجاع',
                          content:
                              'حرصاً منا على سلامتكم، فإن العطور ومنتجات التجميل لا يتم استرجاعها أو استبدالها بعد فتح التغليف الأصلي، إلا في حال وجود خلل مصنعي أو خطأ في المنتج المرسل. يجب الإبلاغ عن المشكلة خلال 24 ساعة من استلام الطلب.',
                        ),
                        SizedBox(height: 16.h),
                        _buildPolicyCard(
                          icon: Icons.privacy_tip_outlined,
                          title: 'سياسة الخصوصية',
                          content:
                              'نحن نلتزم بحماية بياناتكم الشخصية. المعلومات المجمعة (الاسم، العنوان، الهاتف) تستخدم فقط لغرض إتمام عمليات الشحن والتواصل معكم بخصوص طلباتكم، ولن يتم مشاركتها مع أي جهة خارجية دون إذنكم.',
                        ),
                        SizedBox(height: 16.h),
                        _buildPolicyCard(
                          icon: Icons.local_shipping_outlined,
                          title: 'الشحن والتوصيل',
                          content:
                              'يتم التوصيل داخل المملكة العربية السعودية خلال 2-5 أيام عمل. يتم تحديد تكلفة الشحن بناءً على المنطقة وتظهر لكم بوضوح عند تأكيد الطلب.',
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),

                const FooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 45.w,
                height: 45.w,
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.gold, size: 22.sp),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          const Divider(thickness: 0.8),
          SizedBox(height: 10.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 13.5.sp,
              fontFamily: 'Cairo',
              color: Colors.grey[800],
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
