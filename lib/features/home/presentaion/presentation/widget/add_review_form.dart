import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/home/data/add_review_model/add_review_mode.dart';
import 'package:insins/features/home/presentaion/add_review/logic/add_review_cubit/addreview_cubit.dart';
import 'package:insins/features/home/presentaion/add_review/logic/add_review_cubit/addreview_state.dart';

class AddReviewForm extends StatefulWidget {
  final int productId;
  const AddReviewForm({super.key, required this.productId});

  @override
  State<AddReviewForm> createState() => _AddReviewFormState();
}

class _AddReviewFormState extends State<AddReviewForm> {
  final _formKey = GlobalKey<FormState>(); // ✅
  int selectedRating = 5;
  bool _submitted = false;
  final nameController = TextEditingController();
  final commentController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddReviewCubit, AddReviewState>(
      listener: (context, state) {
        if (state is AddReviewSuccess) {
          nameController.clear();
          commentController.clear();
          setState(() {
            selectedRating = 5;
            _submitted = true;
          });
        } else if (state is AddReviewFailure) {
          _showSnackBar(state.errMessage, Colors.red);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ✅ البانر بعد الإرسال
          if (_submitted)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              margin: EdgeInsets.only(bottom: 15.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.green),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  SizedBox(width: 8.w),
                  Text(
                    "شكراً للتقييم! سيظهر بعد المراجعة",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13.sp,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),

          Text(
            "أضف تقييمك",
            style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: 15.sp),
          ),
          SizedBox(height: 15.h),

          // ✅ الفورم
          if (!_submitted)
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildLabel("الاسم"),
                  _buildTextField(
                    "اكتب اسمك هنا",
                    controller: nameController,
                    errorMsg: "برجاء إدخال الاسم",
                  ),
                  SizedBox(height: 15.h),
                  _buildLabel("تقييمك"),
                  _buildStarRatingBar(),
                  SizedBox(height: 15.h),
                  _buildLabel("رأيك يهمنا"),
                  _buildTextField(
                    "حدثنا عن تجربتك مع المنتج...",
                    maxLines: 3,
                    controller: commentController,
                    errorMsg: "برجاء إدخال تعليقك",
                  ),
                  SizedBox(height: 20.h),
                  _buildSubmitButton(context),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: 'Cairo')),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child:
            Text(text, style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp)),
      );

  Widget _buildStarRatingBar() {
    final ratings = [
      {'label': 'ممتاز', 'value': 5},
      {'label': 'جيد جداً', 'value': 4},
      {'label': 'جيد', 'value': 3},
      {'label': 'مقبول', 'value': 2},
      {'label': 'سيء', 'value': 1},
    ];

    return DropdownButtonFormField<int>(
      value: selectedRating,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      items: ratings.map((r) {
        return DropdownMenuItem<int>(
          value: r['value'] as int,
          child: Row(
            children: [
              Row(
                children: List.generate(
                  r['value'] as int,
                  (_) => const Icon(Icons.star, color: Colors.amber, size: 16),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                r['label'] as String,
                style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (val) {
        if (val != null) setState(() => selectedRating = val);
      },
    );
  }

  Widget _buildTextField(
    String hint, {
    int maxLines = 1,
    TextEditingController? controller,
    String? errorMsg,
  }) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.right,
      maxLines: maxLines,
      validator: (val) => val == null || val.trim().isEmpty
          ? errorMsg ?? "هذا الحقل مطلوب"
          : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext outerContext) {
    return BlocBuilder<AddReviewCubit, AddReviewState>(
      builder: (context, state) {
        bool isLoading = state is AddReviewLoading;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: isLoading
                ? null
                : () {
                    FocusScope.of(context).unfocus();

                    // ✅ validation بيظهر تحت كل field
                    if (!_formKey.currentState!.validate()) return;

                    outerContext.read<AddReviewCubit>().addReview(
                          reviewModel: ReviewRequestModel(
                            productId: widget.productId,
                            customerName: nameController.text.trim(),
                            rating: selectedRating,
                            comment: commentController.text.trim(),
                          ),
                        );
                  },
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                : const Icon(Icons.send, size: 18, color: Colors.white),
            label: Text(
              isLoading ? "جاري الإرسال..." : "إرسال التقييم",
              style: const TextStyle(fontFamily: 'Cairo', color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        );
      },
    );
  }
}
