import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class GroupProjectsSection extends StatelessWidget {
  final int groupId;
  const GroupProjectsSection({required this.groupId, super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Projets', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          const Center(child: Text('Aucun projet', style: TextStyle(color: AppColors.textSecondary))),
        ]),
      );
}
