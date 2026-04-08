import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insins/features/shipping/logic/shipping_cubit/cubit/shipping_cubit.dart';
import 'package:insins/features/shipping/logic/shipping_cubit/cubit/shipping_state.dart';

class CityDropdownField extends StatelessWidget {
  const CityDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingCubit, ShippingState>(
      builder: (context, state) {
        List<dynamic> cities = [];
        String? selectedCityName;

        if (state is ShippingSuccess) {
          cities = state.cities;
          final selectedName = state.selectedCity?.cityName;
          final exists = cities.any((c) => c.cityName == selectedName);
          selectedCityName = exists ? selectedName : null;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "المدينة",
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: 'Cairo',
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.h),
            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF4A4A4A), // ✅ لون الـ menu بس
                value: selectedCityName,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[400]),
                hint: Row(
                  children: [
                    SizedBox(width: 4.w),
                    Text(
                      state is ShippingLoading
                          ? "جاري التحميل..."
                          : "اختر مدينتك...",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[400],
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    size: 20.sp,
                    color: const Color(0xFFD4AF37),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide:
                        const BorderSide(color: Color(0xFFD4AF37), width: 1.5),
                  ),
                ),
                items: cities.map<DropdownMenuItem<String>>((city) {
                  final isSelected = city.cityName == selectedCityName;
                  return DropdownMenuItem<String>(
                    value: city.cityName as String,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.help_outline,
                            size: 14.sp,
                            color:
                                isSelected ? Colors.grey[600] : Colors.white70),
                        const Spacer(),
                        Text(
                          "${city.cityName} (${city.price?.toStringAsFixed(2) ?? "0.00"})",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13.sp,
                            color: isSelected ? Colors.grey[800] : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<ShippingCubit>().selectCity(value);
                  }
                },
              ),
            ),
            if (state is ShippingSuccess && state.selectedCity != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "SAR ${state.selectedCity!.price?.toStringAsFixed(2) ?? "0.00"}",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13.sp,
                          color: const Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        ":رسوم الشحن",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (state is ShippingError)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  // لو الرسالة تحتوي على كلمة Timeout، اعرض رسالة مفهومة
                  state.message.contains("timeout")
                      ? "حدث تأخير في الاتصال، تأكد من جودة الإنترنت"
                      : "عذراً، فشل تحميل المدن، حاول لاحقاً",
                  style: TextStyle(
                      color: Colors.red, fontSize: 11.sp, fontFamily: 'Cairo'),
                ),
              ),
          ],
        );
      },
    );
  }
}
