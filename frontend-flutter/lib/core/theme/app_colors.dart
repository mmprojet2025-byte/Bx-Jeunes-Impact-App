// Charte graphique Bx-Jeunes Impact
// ══════════════════════════════════
//
// 3 couleurs ASBL (à confirmer avec l'ASBL si les hex changent) :
//   Rouge   #E8251A  → actions primaires, boutons, accents
//   Orange  #F5A623  → éléments secondaires, badges partenaires
//   Jaune   #FFBF47  → dégradés, illustrations, blob décoratif
//
// Règle fondamentale : toute couleur utilisée dans l'app doit référencer
// une constante de ce fichier. Jamais de Color(0x...) dans les widgets.
 
import 'package:flutter/material.dart';
 
abstract class AppColors {
  // ════════════════════════════════════════════════════════
  //  COULEURS ASBL — les 3 couleurs de la charte
  // ════════════════════════════════════════════════════════
 
  /// Rouge ASBL — couleur primaire
  /// Boutons, AppBar accents, liens, icônes actives nav bar
  static const Color primary = Color(0xFFE8251A);
 
  /// Alias lisible → même valeur que [primary]
  static const Color red = primary;
 
  /// Orange ASBL — couleur secondaire
  /// Badges partenaires, highlights, blob décoratif bas
  static const Color secondary = Color(0xFFF5A623);
 
  /// Alias lisible → même valeur que [secondary]
  static const Color orange = secondary;
 
  /// Jaune ASBL — couleur tertiaire / accent
  /// Dégradés, illustrations, reflets orange-clair
  static const Color tertiary = Color(0xFFFFBF47);
 
  /// Alias lisible → même valeur que [tertiary]
  static const Color yellow = tertiary;
 
  // ── Variantes de teinte (générées depuis les couleurs ASBL) ──
 
  /// Rouge clair — backgrounds de badges, chips rouges
  static const Color primaryLight    = Color(0xFFFDF0EF);
  static const Color primaryMedium   = Color(0xFFFF6B35); // rouge-orange (dégradé banner)
 
  /// Orange clair — backgrounds de badges orange
  static const Color secondaryLight  = Color(0xFFFFF3E0);
 
  /// Jaune clair — backgrounds légers, hover states
  static const Color tertiaryLight   = Color(0xFFFFF8E1);
 
  // ════════════════════════════════════════════════════════
  //  COULEURS SÉMANTIQUES
  // ════════════════════════════════════════════════════════
 
  /// Succès — confirmation, statuts validés, présence
  static const Color success        = Color(0xFF27AE60);
  static const Color successLight   = Color(0xFFEAF7EF);
 
  /// Erreur — erreurs formulaire, statuts refusés, destructif
  static const Color error          = Color(0xFFE74C3C);
  static const Color errorLight     = Color(0xFFFDF0EF);
 
  /// Avertissement — statuts "en attente", alertes non bloquantes
  static const Color warning        = Color(0xFFF39C12);
  static const Color warningLight   = Color(0xFFFFF8EC);
 
  /// Info — informations, statuts "transmis", aide contextuelle
  static const Color info           = Color(0xFF2E86C1);
  static const Color infoLight      = Color(0xFFEBF4FB);
 
  // ── Statuts projets (mappés sur les couleurs sémantiques) ────
 
  /// En cours   → success
  static const Color enCours        = success;
 
  /// En attente → warning
  static const Color enAttente      = warning;
 
  /// Refusé     → error
  static const Color refuse         = error;
 
  /// Validé     → success (variante plus claire)
  static const Color valide         = Color(0xFF2ECC71);
 
  /// Brouillon  → gris neutre
  static const Color brouillon      = Color(0xFF95A5A6);
 
  // ════════════════════════════════════════════════════════
  //  COULEURS NEUTRES
  // ════════════════════════════════════════════════════════
 
  // ── Backgrounds ──────────────────────────────────────────
 
  /// Fond général des écrans
  static const Color background     = Color(0xFFFAFAFA);
 
  /// Fond des cards, dialogs, bottom nav, surfaces élevées
  static const Color surface        = Color(0xFFFFFFFF);
 
  /// Alias → même valeur que [surface]
  static const Color white          = surface;
 
  /// Fond des champs de formulaire (légèrement gris)
  static const Color inputBg        = Color(0xFFF5F5F5);
 
  /// Fond secondaire — hover states, sections alternées
  static const Color backgroundSecondary = Color(0xFFF0F0F0);
 
  // ── Borders & Dividers ────────────────────────────────────
 
  /// Bordure standard des cards, inputs disabled
  static const Color border         = Color(0xFFE8E8E8);
 
  /// Séparateur horizontal (plus discret que [border])
  static const Color divider        = Color(0xFFF0F0F0);
 
  // ── Loading / Skeleton ────────────────────────────────────
 
  /// Couleur de base du skeleton loader
  static const Color shimmerBase    = Color(0xFFEEEEEE);
 
  /// Couleur de highlight du skeleton loader (animation)
  static const Color shimmerHighlight = Color(0xFFF8F8F8);
 
  // ── Ombres ────────────────────────────────────────────────
 
  /// Ombre légère des cards (8% opacité)
  static const Color shadowLight    = Color(0x14000000);
 
  /// Ombre moyenne des cards en survol (12% opacité)
  static const Color shadowMedium   = Color(0x1F000000);
 
  /// Ombre du FAB / éléments flottants (20% opacité)
  static const Color shadowStrong   = Color(0x33000000);
 
  // ════════════════════════════════════════════════════════
  //  TYPOGRAPHIE
  // ════════════════════════════════════════════════════════
 
  /// Titres, texte principal — quasi-noir pour contraste maximal
  static const Color textPrimary    = Color(0xFF1A1A1A);
 
  /// Labels, descriptions, metadata
  static const Color textSecondary  = Color(0xFF888888);
 
  /// Placeholder des inputs
  static const Color textHint       = Color(0xFFBBBBBB);
 
  /// Texte désactivé (disabled state)
  static const Color textDisabled   = Color(0xFFCCCCCC);
 
  /// Texte inversé — sur fond coloré (rouge, orange)
  static const Color textOnPrimary  = Color(0xFFFFFFFF);
 
  // ════════════════════════════════════════════════════════
  //  CATÉGORIES D'ACTIVITÉS
  // ════════════════════════════════════════════════════════
  // Ces couleurs servent de code visuel pour différencier les types d'activité.
 
  static const Color categoryWorkshop = Color(0xFFF5A623); // Atelier   → orange ASBL
  static const Color categoryTraining  = Color(0xFF8E44AD); // Formation → violet
  static const Color categoryMeeting   = Color(0xFF27AE60); // Réunion   → vert
  static const Color categoryOuting    = Color(0xFF2E86C1); // Sortie    → bleu
  static const Color categoryEvent     = Color(0xFFE8251A); // Événement → rouge ASBL
  static const Color categoryOther     = Color(0xFF7F8C8D); // Autre     → gris
 
  // Aliases courts utilisés dans ActivityCategory.color
  static const Color sport      = categoryOuting;
  static const Color culture    = categoryTraining;
  static const Color solidarite = categoryMeeting;
  static const Color autre      = categoryOther;
 
  // ════════════════════════════════════════════════════════
  //  RÔLES UTILISATEURS
  // ════════════════════════════════════════════════════════
 
  static const Color roleYouth          = Color(0xFF2E86C1); // bleu info
  static const Color roleReferent       = Color(0xFF8E44AD); // violet
  static const Color roleAdmin          = Color(0xFFE8251A); // rouge ASBL
  static const Color rolePartner        = Color(0xFFF5A623); // orange ASBL
  static const Color roleSuperAdmin     = Color(0xFF1A1A2E); // navy
  static const Color roleProjectManager = Color(0xFF27AE60); // vert
 
  // ════════════════════════════════════════════════════════
  //  ENV BADGE (environnement de développement)
  // ════════════════════════════════════════════════════════
 
  static const Color envLocal  = Color(0xFFFF9800); // orange Material
  static const Color envDev    = Color(0xFF2196F3); // bleu Material
  static const Color envOther  = Color(0xFF9E9E9E); // gris
}
