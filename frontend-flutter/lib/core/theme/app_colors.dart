import 'package:flutter/material.dart';
 
abstract class AppColors {
  // ── Brand ────────────────────────────────────────────────
  static const Color red         = Color(0xFFE8251A);
  static const Color orange      = Color(0xFFF5A623);
  static const Color orangeLight = Color(0xFFFFBF47);
 
  // ── Neutres ──────────────────────────────────────────────
  static const Color white      = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFAFAFA);
  static const Color inputBg    = Color(0xFFF5F5F5);
  static const Color border     = Color(0xFFE8E8E8);
  static const Color divider    = Color(0xFFF0F0F0);
  static const Color shimmer    = Color(0xFFEEEEEE);
 
  // ── Texte ─────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF888888);
  static const Color textHint      = Color(0xFFBBBBBB);
 
  // ── Statuts projet ────────────────────────────────────────
  static const Color enCours   = Color(0xFF27AE60);
  static const Color enAttente = Color(0xFFF39C12);
  static const Color refuse    = Color(0xFFE74C3C);
  static const Color valide    = Color(0xFF2ECC71);
  static const Color brouillon = Color(0xFF95A5A6);
 
  // ── Catégories activité ───────────────────────────────────
  // Référencées dans ActivityCategory.color (activity.dart)
  static const Color sport      = Color(0xFF2E86C1);
  static const Color culture    = Color(0xFF8E44AD);
  static const Color solidarite = Color(0xFF27AE60);
  static const Color autre      = Color(0xFF7F8C8D);
 
  // ── Rôles utilisateur ─────────────────────────────────────
  // Référencées dans Role.color (role.dart)
  static const Color roleYouth          = Color(0xFF2E86C1);
  static const Color roleReferent       = Color(0xFF8E44AD);
  static const Color roleAdmin          = Color(0xFFE8251A);
  static const Color rolePartner        = Color(0xFFF5A623);
  static const Color roleSuperAdmin     = Color(0xFF1A1A2E);
  static const Color roleProjectManager = Color(0xFF27AE60);
}