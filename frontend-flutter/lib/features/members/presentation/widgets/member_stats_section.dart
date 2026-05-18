import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MemberStatsSection extends StatelessWidget {
  final int activitiesCount;
  final int projectsCount;
  const MemberStatsSection({required this.activitiesCount, required this.projectsCount, super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Expanded(child: _Stat(icon: Icons.calendar_today_outlined, value: '$activitiesCount', label: 'Activités', color: AppColors.sport)),
          Container(width: 1, height: 40, color: AppColors.border),
          Expanded(child: _Stat(icon: Icons.work_outline_rounded, value: '$projectsCount', label: 'Projets', color: AppColors.red)),
        ]),
      );
}

class _Stat extends StatelessWidget {
  final IconData icon; final String value, label; final Color color;
  const _Stat({required this.icon, required this.value, required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ]);
}