import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor:    AppColors.primary,
      primary:      AppColors.primary,
      secondary:    AppColors.secondary,
      tertiary:     AppColors.tertiary,
      error:        AppColors.error,
      surface:      AppColors.surface,
      background:   AppColors.background,
      onPrimary:    AppColors.textOnPrimary,
      onSecondary:  AppColors.textOnPrimary,
      onSurface:    AppColors.textPrimary,
      onBackground: AppColors.textPrimary,
      onError:      AppColors.textOnPrimary,
    );

    return ThemeData(
      useMaterial3:            true,
      colorScheme:             colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily:              AppTypography.fontFamily,
      textTheme:               GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),

      appBarTheme: AppBarTheme(
        backgroundColor:    AppColors.background,
        foregroundColor:    AppColors.textPrimary,
        elevation:          0,
        scrolledUnderElevation: 0,
        centerTitle:        true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.h3.copyWith(fontSize: 18, color: AppColors.textPrimary),
        iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:         AppColors.primary,
          foregroundColor:         AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.primary.withOpacity(.5),
          disabledForegroundColor: AppColors.textOnPrimary.withOpacity(.7),
          elevation: 0, shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: AppTypography.button,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          minimumSize: const Size(double.infinity, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: AppTypography.button.copyWith(color: AppColors.primary),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.buttonSmall,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary, foregroundColor: AppColors.textOnPrimary,
        elevation: 4, shape: CircleBorder(),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: AppColors.inputBg,
        hintStyle: AppTypography.hint, labelStyle: AppTypography.label,
        errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border:             OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder:      OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder:      OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
        errorBorder:        OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error, width: 1.5)),
        prefixIconColor: AppColors.textSecondary, suffixIconColor: AppColors.textSecondary,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface, elevation: 0, margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.inputBg, selectedColor: AppColors.primary.withOpacity(.12),
        disabledColor: AppColors.backgroundSecondary,
        labelStyle: AppTypography.caption.copyWith(color: AppColors.textPrimary),
        secondaryLabelStyle: AppTypography.caption.copyWith(color: AppColors.primary),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1, space: 0),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface, elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: AppTypography.h4,
        contentTextStyle: AppTypography.body.copyWith(color: AppColors.textSecondary),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTypography.body.copyWith(color: AppColors.textOnPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actionTextColor: AppColors.tertiary,
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((s) =>
            s.contains(WidgetState.selected) ? AppColors.primary : Colors.transparent),
        checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: AppColors.border, width: 1.5),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((s) =>
            s.contains(WidgetState.selected) ? AppColors.surface : AppColors.textSecondary),
        trackColor: WidgetStateProperty.resolveWith((s) =>
            s.contains(WidgetState.selected) ? AppColors.primary : AppColors.border),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary, linearTrackColor: AppColors.border),
    );
  }
}
