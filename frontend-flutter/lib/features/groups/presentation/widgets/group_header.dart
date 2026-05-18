import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'group_card.dart';

class GroupHeader extends StatelessWidget {
  final Group group;
  const GroupHeader({required this.group, super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        color: AppColors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: AppColors.culture.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.groups_outlined, color: AppColors.culture, size: 32),
          ),
          const SizedBox(height: 12),
          Text(group.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          if (group.description != null) ...[
            const SizedBox(height: 6),
            Text(group.description!, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4)),
          ],
          const SizedBox(height: 10),
          Text('${group.memberCount} membres', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ]),
      );
}