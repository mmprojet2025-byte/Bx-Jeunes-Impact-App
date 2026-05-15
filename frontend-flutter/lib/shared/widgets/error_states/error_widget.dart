import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
class AppErrorWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
 
  const AppErrorWidget({super.key, this.message, this.onRetry});
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              color: AppColors.refuse.withOpacity(.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.wifi_off_rounded, size: 32, color: AppColors.refuse),
          ),
          const SizedBox(height: 16),
          const Text('Oups, une erreur est survenue',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text(
            message ?? 'Vérifiez votre connexion et réessayez.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Réessayer'),
            ),
          ],
        ],
        ),
      ),
    );
  }
}
