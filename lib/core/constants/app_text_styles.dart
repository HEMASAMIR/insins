import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle displayLarge = TextStyle(
    fontSize: 32, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, height: 1.3,
  );
  static const TextStyle displayMedium = TextStyle(
    fontSize: 26, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, height: 1.3,
  );
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 22, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 18, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16, fontWeight: FontWeight.normal,
    color: AppColors.textSecondary, height: 1.6,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14, fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary, letterSpacing: 0.5,
  );
  static const TextStyle priceStyle = TextStyle(
    fontSize: 18, fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );
}
