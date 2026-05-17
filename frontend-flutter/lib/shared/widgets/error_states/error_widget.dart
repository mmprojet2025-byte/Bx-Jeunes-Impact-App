import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Widget d'état d'erreur générique.
/// Affiché quand une requête API échoue ou qu'une exception est levée.
///
/// Usage :
///   AppErrorWidget(
///     message: error.toString(),
///     onRetry: () => ref.refresh(someProvider),
///   )
class AppErrorWidget extends StatelessWidget {
  final String    message;
  final VoidCallback? onRetry;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icône ───────────────────────────────────────────
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.errorLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 36,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 16),

            // ── Titre ────────────────────────────────────────────
            const Text(
              'Une erreur est survenue',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:   16,
                fontWeight: FontWeight.bold,
                color:      AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            // ── Message technique ─────────────────────────────────
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color:    AppColors.textSecondary,
                height:   1.4,
              ),
            ),

            // ── Bouton Réessayer ──────────────────────────────────
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon:  const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Réessayer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation:       0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
