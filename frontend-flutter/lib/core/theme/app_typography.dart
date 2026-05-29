import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTypography {
  static const String fontFamily = 'Poppins';

  static const TextStyle h1 = TextStyle(fontFamily: fontFamily, fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.textPrimary, letterSpacing: -0.5, height: 1.2);
  static const TextStyle h2 = TextStyle(fontFamily: fontFamily, fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary, letterSpacing: -0.3, height: 1.25);
  static const TextStyle h3 = TextStyle(fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.3);
  static const TextStyle h4 = TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.35);
  static const TextStyle h5 = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.4);

  static const TextStyle bodyLarge = TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary, height: 1.55);
  static const TextStyle body      = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textPrimary, height: 1.5);
  static const TextStyle bodySmall = TextStyle(fontFamily: fontFamily, fontSize: 13, fontWeight: FontWeight.normal, color: AppColors.textSecondary, height: 1.4);

  static const TextStyle label       = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary);
  static const TextStyle button      = TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textOnPrimary, letterSpacing: 0.2);
  static const TextStyle buttonSmall = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary);
  static const TextStyle caption     = TextStyle(fontFamily: fontFamily, fontSize: 11, fontWeight: FontWeight.normal, color: AppColors.textSecondary, letterSpacing: 0.2);
  static const TextStyle badge       = TextStyle(fontFamily: fontFamily, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.3);
  static const TextStyle link        = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primary);
  static const TextStyle hint        = TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textHint);

  static TextStyle colored(TextStyle base, Color color) => base.copyWith(color: color);
  static TextStyle onDark(TextStyle base) => base.copyWith(color: AppColors.textOnPrimary);
}
