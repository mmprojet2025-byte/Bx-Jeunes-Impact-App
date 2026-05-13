// ThemeData light — V1
// Dark mode reporté en V2 (cf. cahier des charges)
//
// Principe : TOUS les widgets Flutter héritent leurs couleurs depuis
// ce ThemeData. Les écrans NE doivent PAS hardcoder de couleurs.
// Utiliser Theme.of(context).colorScheme ou les constantes AppColors.
 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
import 'app_colors.dart';
import 'app_typography.dart';
 
class AppTheme {
  AppTheme._();
 
  // ─────────────────────────────────────────────────────────
  //  THÈME LIGHT (V1)
  // ─────────────────────────────────────────────────────────
 
  static ThemeData get light {
    // ColorScheme aligné sur la charte ASBL
    final colorScheme = ColorScheme.fromSeed(
      seedColor:    AppColors.primary,
      brightness:   Brightness.light,
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
 
      // ── System UI overlay ──────────────────────────────
      // Icônes de la barre de statut en sombre (fond clair)
      appBarTheme: AppBarTheme(
        backgroundColor:    AppColors.background,
        foregroundColor:    AppColors.textPrimary,
        elevation:          0,
        scrolledUnderElevation: 0,
        centerTitle:        true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.h3.copyWith(
          fontSize: 18,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimary,
          size:  24,
        ),
      ),
 
      // ── Boutons primaires ──────────────────────────────
      // Utilisé par ElevatedButton — fond rouge ASBL
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:         AppColors.primary,
          foregroundColor:         AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.primary.withOpacity(.5),
          disabledForegroundColor: AppColors.textOnPrimary.withOpacity(.7),
          elevation:               0,
          shadowColor:             Colors.transparent,
          minimumSize:             const Size(double.infinity, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          textStyle: AppTypography.button,
        ),
      ),
 
      // ── Boutons outline ────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          minimumSize: const Size(double.infinity, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          textStyle: AppTypography.button.copyWith(color: AppColors.primary),
        ),
      ),
 
      // ── Boutons texte ──────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.buttonSmall,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
 
      // ── FAB ────────────────────────────────────────────
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation:       4,
        shape: CircleBorder(),
      ),
 
      // ── Champs de formulaire ───────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled:       true,
        fillColor:    AppColors.inputBg,
        hintStyle:    AppTypography.hint,
        labelStyle:   AppTypography.label,
        errorStyle:   AppTypography.caption.copyWith(color: AppColors.error),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:   BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:   BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:   const BorderSide(
                color: AppColors.primary, width: 1.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:   const BorderSide(color: AppColors.error)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:   const BorderSide(
                color: AppColors.error, width: 1.5)),
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
      ),
 
      // ── Cards ──────────────────────────────────────────
      cardTheme: CardTheme(
        color:     AppColors.surface,
        elevation: 0,
        margin:    EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)),
      ),
 
      // ── Chips ──────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor:   AppColors.inputBg,
        selectedColor:     AppColors.primary.withOpacity(.12),
        disabledColor:     AppColors.backgroundSecondary,
        labelStyle:        AppTypography.caption.copyWith(
            color: AppColors.textPrimary),
        secondaryLabelStyle: AppTypography.caption.copyWith(
            color: AppColors.primary),
        side:              BorderSide.none,
        padding:           const EdgeInsets.symmetric(
            horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
      ),
 
      // ── BottomNavigationBar ────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor:      AppColors.surface,
        selectedItemColor:    AppColors.primary,
        unselectedItemColor:  AppColors.textSecondary,
        showSelectedLabels:   true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle:   TextStyle(
            fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 10),
      ),
 
      // ── Divider ────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color:     AppColors.divider,
        thickness: 1,
        space:     0,
      ),
 
      // ── Dialog ────────────────────────────────────────
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.surface,
        elevation:       8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        titleTextStyle:   AppTypography.h4,
        contentTextStyle: AppTypography.body.copyWith(
            color: AppColors.textSecondary),
      ),
 
      // ── SnackBar ───────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor:  AppColors.textPrimary,
        contentTextStyle: AppTypography.body.copyWith(
            color: AppColors.textOnPrimary),
        behavior:         SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        actionTextColor:  AppColors.tertiary,
      ),
 
      // ── Checkbox ───────────────────────────────────────
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(AppColors.textOnPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: AppColors.border, width: 1.5),
      ),
 
      // ── Switch ─────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.surface;
          }
          return AppColors.textSecondary;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.border;
        }),
      ),
 
      // ── ProgressIndicator ─────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color:            AppColors.primary,
        linearTrackColor: AppColors.border,
      ),
 
      // ── TextTheme ─────────────────────────────────────
      textTheme: TextTheme(
        displayLarge:  AppTypography.h1,
        displayMedium: AppTypography.h2,
        displaySmall:  AppTypography.h3,
        headlineLarge: AppTypography.h3,
        headlineMedium: AppTypography.h4,
        headlineSmall: AppTypography.h5,
        titleLarge:    AppTypography.h4,
        titleMedium:   AppTypography.h5,
        titleSmall:    AppTypography.label,
        bodyLarge:     AppTypography.bodyLarge,
        bodyMedium:    AppTypography.body,
        bodySmall:     AppTypography.bodySmall,
        labelLarge:    AppTypography.button,
        labelMedium:   AppTypography.label,
        labelSmall:    AppTypography.caption,
      ),
    );
  }
 
  // ─────────────────────────────────────────────────────────
  //  DARK MODE — reporté V2
  // ─────────────────────────────────────────────────────────
  // static ThemeData get dark { ... }
}
