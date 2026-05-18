import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Carte d'information générique avec icône, titre et contenu.
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String   title;
  final String   content;
  final Color?   iconColor;
  final VoidCallback? onTap;

  const InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    super.key,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(content,
                      style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.4)),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(Icons.chevron_right,
                  size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
