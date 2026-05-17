import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileStatsCard extends StatelessWidget {
  final int activitiesCount;
  final int projectsCount;
  final int groupsCount;
  const ProfileStatsCard({required this.activitiesCount, required this.projectsCount,
      required this.groupsCount, super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Expanded(child: _Stat('$activitiesCount', 'Activités', AppColors.sport)),
          Container(width: 1, height: 36, color: AppColors.border),
          Expanded(child: _Stat('$projectsCount', 'Projets', AppColors.red)),
          Container(width: 1, height: 36, color: AppColors.border),
          Expanded(child: _Stat('$groupsCount', 'Groupes', AppColors.culture)),
        ]),
      );
}

class _Stat extends StatelessWidget {
  final String value, label; final Color color;
  const _Stat(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Column(mainAxisSize: MainAxisSize.min, children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ]);
}
