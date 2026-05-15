import 'package:flutter/material.dart';
import 'app_colors.dart';
 
abstract class AppTypography {
  static const String fontFamily = 'SF Pro Display';
 
  static const TextStyle h1 = TextStyle(
    fontSize: 28, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, letterSpacing: -0.5,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 22, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, letterSpacing: -0.3,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 18, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static const TextStyle h4 = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 15, color: AppColors.textPrimary, height: 1.5,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14, color: AppColors.textPrimary, height: 1.5,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 13, color: AppColors.textSecondary, height: 1.4,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 11, color: AppColors.textSecondary, letterSpacing: 0.2,
  );
  static const TextStyle label = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary,
  );
  static const TextStyle button = TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white,
  );
  static const TextStyle link = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.red,
  );
}
