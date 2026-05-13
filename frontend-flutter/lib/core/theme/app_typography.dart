// Système typographique Bx-Jeunes Impact
// ═══════════════════════════════════════
//
// Police : Inter (Google Fonts, open source, excellente lisibilité mobile)
// Déclarer dans pubspec.yaml :
//   dependencies:
//     google_fonts: ^6.2.1
//
// Puis dans app_theme.dart :
//   import 'package:google_fonts/google_fonts.dart';
//   textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme)
//
// Si Google Fonts non disponible hors-ligne, utiliser le fallback système :
//   fontFamily: 'SF Pro Display' (iOS) / 'Roboto' (Android) → géré par Flutter
 
import 'package:flutter/material.dart';
import 'app_colors.dart';
 
abstract class AppTypography {
  static const String fontFamily = 'Inter';
 
  // ════════════════════════════════════════════════════════
  //  TITRES
  // ════════════════════════════════════════════════════════
 
  /// H1 — Titre principal (logo, écrans auth)
  /// Exemple : "Bx-Jeunes" sur la page de login
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize:   30,
    fontWeight: FontWeight.bold,
    color:      AppColors.textPrimary,
    letterSpacing: -0.5,
    height:     1.2,
  );
 
  /// H2 — Titre de page (ex: "Activités", "Projets", "Bonjour !")
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize:   24,
    fontWeight: FontWeight.bold,
    color:      AppColors.textPrimary,
    letterSpacing: -0.3,
    height:     1.25,
  );
 
  /// H3 — En-tête de section (ex: "Activités à venir", "Mes projets")
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize:   18,
    fontWeight: FontWeight.bold,
    color:      AppColors.textPrimary,
    height:     1.3,
  );
 
  /// H4 — Sous-titre, titre de card
  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize:   16,
    fontWeight: FontWeight.w600,
    color:      AppColors.textPrimary,
    height:     1.35,
  );
 
  /// H5 — Label important, nom dans une card
  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize:   14,
    fontWeight: FontWeight.w600,
    color:      AppColors.textPrimary,
    height:     1.4,
  );
 
  // ════════════════════════════════════════════════════════
  //  CORPS DE TEXTE
  // ════════════════════════════════════════════════════════
 
  /// Corps large — descriptions principales dans les écrans de détail
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize:   16,
    fontWeight: FontWeight.normal,
    color:      AppColors.textPrimary,
    height:     1.55,
  );
 
  /// Corps standard — texte courant, labels de formulaire
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize:   14,
    fontWeight: FontWeight.normal,
    color:      AppColors.textPrimary,
    height:     1.5,
  );
 
  /// Corps petit — metadata (dates, lieux, nombres)
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize:   13,
    fontWeight: FontWeight.normal,
    color:      AppColors.textSecondary,
    height:     1.4,
  );
 
  // ════════════════════════════════════════════════════════
  //  LABELS & UI
  // ════════════════════════════════════════════════════════
 
  /// Label de champ de formulaire
  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize:   14,
    fontWeight: FontWeight.w500,
    color:      AppColors.textPrimary,
  );
 
  /// Texte de bouton
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize:   16,
    fontWeight: FontWeight.bold,
    color:      AppColors.textOnPrimary,
    letterSpacing: 0.2,
  );
 
  /// Texte de bouton petit (secondaire, outline)
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize:   14,
    fontWeight: FontWeight.w600,
    color:      AppColors.primary,
  );
 
  // ════════════════════════════════════════════════════════
  //  CAPTION & BADGE
  // ════════════════════════════════════════════════════════
 
  /// Caption — texte très petit (labels nav bar, badges, timestamps)
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize:   11,
    fontWeight: FontWeight.normal,
    color:      AppColors.textSecondary,
    letterSpacing: 0.2,
  );
 
  /// Badge / chip — texte dans les chips de statut ou catégorie
  static const TextStyle badge = TextStyle(
    fontFamily: fontFamily,
    fontSize:   11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );
 
  /// Lien — texte cliquable (ex: "Mot de passe oublié ?", "Voir tout")
  static const TextStyle link = TextStyle(
    fontFamily: fontFamily,
    fontSize:   14,
    fontWeight: FontWeight.w500,
    color:      AppColors.primary,
  );
 
  /// Hint — placeholder input
  static const TextStyle hint = TextStyle(
    fontFamily: fontFamily,
    fontSize:   14,
    fontWeight: FontWeight.normal,
    color:      AppColors.textHint,
  );
 
  // ════════════════════════════════════════════════════════
  //  HELPERS — variantes colorées
  // ════════════════════════════════════════════════════════
 
  /// Applique une couleur custom à un style existant
  static TextStyle colored(TextStyle base, Color color) =>
      base.copyWith(color: color);
 
  /// Version blanche d'un style (pour texte sur fond coloré)
  static TextStyle onDark(TextStyle base) =>
      base.copyWith(color: AppColors.textOnPrimary);
}
