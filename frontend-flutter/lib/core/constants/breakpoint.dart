abstract class Breakpoints {
  // ── Seuils en pixels logiques ─────────────────────────────
 
  /// En-dessous → téléphone
  static const double tabletMin  = 600.0;
 
  /// Maximum ciblé (tablette large)
  static const double tabletMax  = 1024.0;
 
  /// Cible minimale téléphone (iPhone SE)
  static const double phoneMin   = 375.0;
 
  // ── Colonnes de grille selon la largeur ───────────────────
 
  /// Grille 1 colonne → téléphone
  static const int phoneColumns  = 1;
 
  /// Grille 2 colonnes → tablette
  static const int tabletColumns = 2;
 
  // ── Espacements adaptatifs ────────────────────────────────
 
  /// Padding horizontal — téléphone
  static const double phonePadding  = 16.0;
 
  /// Padding horizontal — tablette
  static const double tabletPadding = 24.0;
 
  /// Espacement entre cards — téléphone
  static const double phoneCardGap  = 10.0;
 
  /// Espacement entre cards — tablette
  static const double tabletCardGap = 14.0;
 
  // ── Factory contextuelle ──────────────────────────────────
 
  /// Retourne les dimensions adaptées au contexte courant.
  /// Usage : `final bp = Breakpoints.of(context);`
  static BreakpointData of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BreakpointData(width: width);
  }
}
 
// ─────────────────────────────────────────────────────────────
//  BreakpointData — valeurs calculées pour un contexte donné
// ─────────────────────────────────────────────────────────────
 
import 'package:flutter/material.dart';
 
class BreakpointData {
  final double width;
 
  const BreakpointData({required this.width});
 
  // ── Détection ────────────────────────────────────────────
 
  bool get isPhone  => width <  Breakpoints.tabletMin;
  bool get isTablet => width >= Breakpoints.tabletMin;
 
  // ── Valeurs adaptatives ───────────────────────────────────
 
  /// Nombre de colonnes pour GridView
  int get columns => isTablet ? Breakpoints.tabletColumns : Breakpoints.phoneColumns;
 
  /// Padding horizontal des écrans
  double get horizontalPadding =>
      isTablet ? Breakpoints.tabletPadding : Breakpoints.phonePadding;
 
  /// Espacement entre les cards
  double get cardGap =>
      isTablet ? Breakpoints.tabletCardGap : Breakpoints.phoneCardGap;
 
  /// Rapport d'aspect pour GridView (plus large sur tablette)
  double get cardAspectRatio => isTablet ? 1.6 : 2.2;
 
  // ── Sélecteur générique ───────────────────────────────────
 
  /// Retourne [phoneValue] ou [tabletValue] selon la largeur.
  T select<T>({required T phone, required T tablet}) =>
      isTablet ? tablet : phone;
}