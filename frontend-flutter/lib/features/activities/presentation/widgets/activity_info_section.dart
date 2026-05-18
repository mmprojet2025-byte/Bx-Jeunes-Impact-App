import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_helpers.dart';
import '../../data/activity.dart';
import 'category_chip.dart';

class ActivityInfoSection extends StatelessWidget {
  final Activity activity;
  const ActivityInfoSection({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CategoryChip(category: activity.category),
        const SizedBox(height: 12),
        Text(activity.name,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary)),
        if (activity.description != null) ...[
          const SizedBox(height: 8),
          Text(activity.description!,
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5)),
        ],
        const SizedBox(height: 16),
        const Divider(color: AppColors.border, height: 1),
        const SizedBox(height: 16),
        _InfoRow(
            icon: Icons.calendar_today_outlined,
            text: DateHelpers.formatDateTime(activity.date)),
        if (activity.groupName != null) ...[
          const SizedBox(height: 10),
          _InfoRow(
              icon: Icons.groups_outlined, text: activity.groupName!),
        ],
        if (activity.maxParticipants != null) ...[
          const SizedBox(height: 10),
          _InfoRow(
              icon: Icons.people_outline,
              text:
                  '${activity.currentParticipants ?? 0} / ${activity.maxParticipants} participants'),
        ],
      ]),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Row(children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textPrimary))),
      ]);
}