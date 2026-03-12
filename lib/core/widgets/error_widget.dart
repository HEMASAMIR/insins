import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const CustomErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.error_outline, color: Colors.red[300], size: 40.sp),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo', fontSize: 13.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: onRetry,
            child: Text(
              'إعادة المحاولة',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
