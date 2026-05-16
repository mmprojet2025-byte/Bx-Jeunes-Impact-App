import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
 
/// Widget empty state générique.
/// Affiché quand une liste est vide.
///
/// Usage :
///   EmptyState(
///     icon: Icons.event_busy_outlined,
///     title: 'Aucune activité à venir',
///     subtitle: 'Parcourez le catalogue et inscrivez-vous !',
///     actionLabel: 'Voir les activités',
///     onAction: () => context.goNamed(RouteNames.activities),
///   )
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String   title;
  final String?  subtitle;
  final String?  actionLabel;
  final VoidCallback? onAction;
 
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icône ────────────────────────────────────────
            Container(
              width:  72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.inputBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
 
            // ── Titre ─────────────────────────────────────────
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize:   16,
                fontWeight: FontWeight.bold,
                color:      AppColors.textPrimary,
              ),
            ),
 
            // ── Sous-titre ────────────────────────────────────
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color:    AppColors.textSecondary,
                  height:   1.4,
                ),
              ),
            ],
 
            // ── Action CTA ────────────────────────────────────
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation:       0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  actionLabel!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}