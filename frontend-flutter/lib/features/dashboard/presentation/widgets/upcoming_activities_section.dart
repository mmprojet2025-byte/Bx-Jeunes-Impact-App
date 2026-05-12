// Widget réutilisable pour :
//   Section 3 — "Mes activités à venir"  (registrations de l'utilisateur)
//   Section 5 — "Activités proposées par l'ASBL"  (catalogue général)
//
// Paramétré par [title], [items], [emptyMessage] et [onSeeAll].
 
import 'package:flutter/material.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_helpers.dart';
import '../../../../shared/widgets/empty_states/empty_state.dart';
import '../../../../shared/widgets/loaders/skeleton_loader.dart';
import '../../../activities/data/activity.dart';
 
class UpcomingActivitiesSection extends StatelessWidget {
  final String title;
 
  /// null = chargement en cours (skeleton)
  /// []   = vide (empty state)
  /// list = données réelles
  final List<Activity>? activities;
 
  final String emptyTitle;
  final String? emptySubtitle;
  final String? emptyActionLabel;
  final VoidCallback? onEmptyAction;
  final VoidCallback? onSeeAll;
  final void Function(Activity)? onActivityTap;
 
  const UpcomingActivitiesSection({
    super.key,
    required this.title,
    required this.activities,
    this.emptyTitle = 'Aucune activité prochaine',
    this.emptySubtitle,
    this.emptyActionLabel,
    this.onEmptyAction,
    this.onSeeAll,
    this.onActivityTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: title,
          onSeeAll: activities != null && activities!.isNotEmpty
              ? onSeeAll
              : null,
        ),
        const SizedBox(height: 8),
        _buildBody(),
      ],
    );
  }
 
  Widget _buildBody() {
    // ── Loading ─────────────────────────────────────────
    if (activities == null) {
      return Column(children: const [
        CardSkeleton(),
        CardSkeleton(),
        CardSkeleton(),
      ]);
    }
 
    // ── Empty ───────────────────────────────────────────
    if (activities!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: EmptyState(
          icon: Icons.event_busy_outlined,
          title: emptyTitle,
          subtitle: emptySubtitle,
          actionLabel: emptyActionLabel,
          onAction: onEmptyAction,
        ),
      );
    }
 
    // ── Data ────────────────────────────────────────────
    return Column(
      children: activities!
          .map((a) => _ActivityCard(
                activity: a,
                onTap: () => onActivityTap?.call(a),
              ))
          .toList(),
    );
  }
}
 
// ── Activity Card ─────────────────────────────────────────────
 
class _ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback onTap;
 
  const _ActivityCard({required this.activity, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    final category = activity.category;
 
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
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Badge date ─────────────────────────────
            Container(
              width: 48,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    activity.dayNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    activity.monthAbbr,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
 
            // ── Infos ──────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.schedule,
                          size: 12, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        DateHelpers.formatDateTime(activity.date),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (activity.groupName != null) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            activity.groupName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
 
            // ── Catégorie chip ─────────────────────────
            _CategoryChip(category: category),
          ],
        ),
      ),
    );
  }
}
 
// ── Category chip ─────────────────────────────────────────────
 
class _CategoryChip extends StatelessWidget {
  final ActivityCategory category;
 
  const _CategoryChip({required this.category});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: category.color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(category.icon, size: 12, color: category.color),
          const SizedBox(width: 4),
          Text(
            category.label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: category.color,
            ),
          ),
        ],
      ),
    );
  }
}
 
// ── Section header ────────────────────────────────────────────
 
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
 
  const _SectionHeader({required this.title, this.onSeeAll});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: const Text(
                'Voir tout',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
 