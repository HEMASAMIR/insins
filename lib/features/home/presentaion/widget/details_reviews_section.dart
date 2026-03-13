import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsReviewsSection extends StatelessWidget {
  const DetailsReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildHeaderRow(),
          Divider(height: 30.h),
          _buildEmptyState(),
          SizedBox(height: 30.h),
          _buildReviewForm(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          const Icon(Icons.star, color: Colors.amber, size: 18),
          Text(" 0.0", style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp)),
        ]),
        Text("آراء العملاء",
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.chat_bubble_outline, color: Colors.grey[300], size: 40),
          SizedBox(height: 10.h),
          Text("لا توجد تقييمات بعد",
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold)),
          Text("كن أول من يشاركنا رأيه في هذا المنتج المميز",
              style: TextStyle(
                  fontFamily: 'Cairo', fontSize: 12.sp, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildReviewForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("أضف تقييمك",
            style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: 15.sp)),
        SizedBox(height: 15.h),
        _buildLabel("الاسم"),
        _buildTextField("اكتب اسمك هنا"),
        SizedBox(height: 15.h),
        _buildLabel("تقييمك"),
        _buildRatingDropdown(),
        SizedBox(height: 15.h),
        _buildLabel("رأيك يهمنا"),
        _buildTextField("حدثنا عن تجربتك مع المنتج...", maxLines: 3),
        SizedBox(height: 20.h),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildLabel(String text) => Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child:
          Text(text, style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp)));

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      textAlign: TextAlign.right,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  Widget _buildRatingDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8.r)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: "5",
          items: ["5", "4", "3", "2", "1"]
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text("⭐ ⭐ ⭐ ⭐ ⭐ (ممتاز)",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12.sp))))
              .toList(),
          onChanged: (v) {},
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.send, size: 18, color: Colors.white),
        label: const Text("إرسال التقييم",
            style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r))),
      ),
    );
  }
}
