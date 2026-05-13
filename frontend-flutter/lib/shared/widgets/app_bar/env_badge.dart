// Badge d'environnement affiché dans l'AppBar quand ENV != 'prod'.
//
// Affiche :
//   [LOCAL]  fond orange  — backend localhost
//   [DEV]    fond amber   — backend Render
//   (rien)                — production
//
// Usage dans une AppBar :
//
//   AppBar(
//     title: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Text('Bx-Jeunes Impact'),
//         const EnvBadge(),         // ← s'affiche uniquement hors prod
//       ],
//     ),
//   )
//
//   // ou dans les actions :
//   actions: const [EnvBadge(), SizedBox(width: 8)],
 
import 'package:flutter/material.dart';
 
import '../../../core/constants/app_config.dart';
 
class EnvBadge extends StatelessWidget {
  const EnvBadge({super.key});
 
  @override
  Widget build(BuildContext context) {
    // En production, aucun widget rendu (zero overhead)
    if (!AppConfig.showDevBadge) return const SizedBox.shrink();
 
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: _badgeColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        AppConfig.envLabel,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: _textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
 
  /// Couleur de fond selon l'environnement
  Color get _badgeColor {
    if (AppConfig.isLocal) return const Color(0xFFFF9800); // orange
    if (AppConfig.isDev)   return const Color(0xFF2196F3); // bleu
    return const Color(0xFF9E9E9E);                        // gris (fallback)
  }
 
  /// Couleur du texte — toujours blanc sur ces fonds
  Color get _textColor => const Color(0xFFFFFFFF);
}