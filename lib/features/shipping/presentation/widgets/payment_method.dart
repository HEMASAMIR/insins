import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSection extends StatefulWidget {
  const PaymentSection({super.key});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  String selectedMethod = "tabby";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("طريقة الدفع",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo')),
        SizedBox(height: 10.h),
        _buildOption("tabby", "قسّطها مع تاببي", Icons.credit_card),
        _buildOption("cod", "الدفع عند الاستلام", Icons.money_outlined),
      ],
    );
  }

  Widget _buildOption(String value, String title, IconData icon) {
    bool isSelected = selectedMethod == value;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = value),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: isSelected ? const Color(0xFF2DBB54) : Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? const Color(0xFF2DBB54) : Colors.grey),
            const Spacer(),
            Text(title, style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp)),
            SizedBox(width: 10.w),
            Icon(icon, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
