import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/shipping/presentation/widgets/city_dropdown_field.dart';

class ShippingForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  const ShippingForm({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
  });

  @override
  State<ShippingForm> createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: 20.h),
        _buildTextField("الاسم الكريم", "الاسم الثنائي", Icons.person_outline),
        SizedBox(height: 15.h),
        _buildTextField(
            "رقم الجوال", "05xxxxxxxx", Icons.phone_android_outlined),
        SizedBox(height: 15.h),
        CityDropdownField(),
        SizedBox(height: 15.h),
        _buildTextField("العنوان التفصيلي", "اسم الحي، الشارع، رقم المنزل...",
            Icons.home_outlined),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "بيانات الشحن والدفع",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo'),
        ),
        SizedBox(width: 8.w),
        Icon(Icons.local_shipping_outlined,
            size: 22.sp, color: Colors.grey[700]),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 13.sp, fontFamily: 'Cairo', color: Colors.grey[600])),
        SizedBox(height: 6.h),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[400],
                  fontFamily: 'Cairo'),
              prefixIcon: Icon(icon, size: 20.sp, color: Colors.grey[400]),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[200]!)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[200]!)),
            ),
          ),
        ),
      ],
    );
  }
}
