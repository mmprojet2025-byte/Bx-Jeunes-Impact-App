import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_helpers.dart';
import '../../data/activity.dart';
import 'category_chip.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback? onTap;
  final bool compact;

  const ActivityCard(
      {required this.activity, super.key, this.onTap, this.compact = false,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2),),
          ],
        ),
        child: Row(children: [
          // ── Date badge ──────────────────────────────────
          Container(
            width: 48,
            height: 56,
            decoration: BoxDecoration(
              color: activity.category.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(activity.dayNumber,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: activity.category.color,),),
                Text(activity.monthAbbr,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: activity.category.color,),),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // ── Info ─────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,),),
                const SizedBox(height: 4),
                Text(DateHelpers.formatDateTime(activity.date),
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary,),),
                const SizedBox(height: 6),
                CategoryChip(category: activity.category, compact: true),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              size: 18, color: AppColors.textSecondary,),
        ],),
      ),
    );
  }
}