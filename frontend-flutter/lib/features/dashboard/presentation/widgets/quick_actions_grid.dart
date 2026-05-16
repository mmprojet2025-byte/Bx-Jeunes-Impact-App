// Section 6 — Raccourcis rapides.
// Grille de 3 boutons : Activités / Projets / Groupes.
 
import 'package:flutter/material.dart';
 
import '../../../../core/theme/app_colors.dart';
 
class QuickActionsGrid extends StatelessWidget {
  final VoidCallback onActivitiesTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onGroupsTap;
 
  const QuickActionsGrid({
    required this.onActivitiesTap, required this.onProjectsTap, required this.onGroupsTap, super.key,
  });
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'Accès rapide',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.calendar_today_rounded,
                  label: 'Toutes les\nactivités',
                  color: AppColors.sport,
                  onTap: onActivitiesTap,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.work_outline_rounded,
                  label: 'Tous les\nprojets',
                  color: AppColors.red,
                  onTap: onProjectsTap,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _QuickActionButton(
                  icon: Icons.groups_outlined,
                  label: 'Tous les\ngroupes',
                  color: AppColors.culture,
                  onTap: onGroupsTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
 
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
 
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}