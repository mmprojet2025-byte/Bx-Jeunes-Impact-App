// Section 4 — "Mes projets en cours"
// Affiche les projets dont l'utilisateur est créateur ou membre actif.
 
import 'package:flutter/material.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/empty_states/empty_state.dart';
import '../../../../shared/widgets/loaders/skeleton_loader.dart';
import '../../../projects/data/project.dart';
 
class MyProjectsSection extends StatelessWidget {
  /// null = loading, [] = empty, list = données
  final List<Project>? projects;
  final VoidCallback? onSeeAll;
  final void Function(Project)? onProjectTap;
 
  const MyProjectsSection({
    required this.projects, super.key,
    this.onSeeAll,
    this.onProjectTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          onSeeAll: projects != null && projects!.isNotEmpty
              ? onSeeAll
              : null,
        ),
        const SizedBox(height: 8),
        _buildBody(),
      ],
    );
  }
 
  Widget _buildBody() {
    if (projects == null) {
      return Column(children: [const CardSkeleton(), const CardSkeleton()]);
    }
 
    if (projects!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: EmptyState(
          icon: Icons.work_off_outlined,
          title: 'Aucun projet en cours',
          subtitle: 'Propose une idée et rejoins l\'aventure !',
          actionLabel: 'Proposer un projet',
          onAction: onSeeAll,
        ),
      );
    }
 
    return Column(
      children: projects!
          .map((p) => _ProjectCard(
                project: p,
                onTap: () => onProjectTap?.call(p),
              ),)
          .toList(),
    );
  }
}
 
// ── Project Card ──────────────────────────────────────────────
 
class _ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;
 
  const _ProjectCard({required this.project, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    final status = project.status;
 
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
            // ── Icône projet ────────────────────────────
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: status.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.rocket_launch_outlined,
                color: status.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
 
            // ── Titre + groupe ──────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (project.groupName != null)
                    Row(
                      children: [
                        const Icon(Icons.groups_outlined,
                            size: 12, color: AppColors.textSecondary,),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            project.groupName!,
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
              ),
            ),
            const SizedBox(width: 8),
 
            // ── Badge statut ────────────────────────────
            _StatusBadge(project: project),
 
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right,
                size: 18, color: AppColors.textSecondary,),
          ],
        ),
      ),
    );
  }
}
 
// ── Status Badge ──────────────────────────────────────────────
 
class _StatusBadge extends StatelessWidget {
  final Project project;
 
  const _StatusBadge({required this.project});
 
  @override
  Widget build(BuildContext context) {
    final color = project.status.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        project.status.label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
 
// ── Section header ────────────────────────────────────────────
 
class _SectionHeader extends StatelessWidget {
  final VoidCallback? onSeeAll;
 
  const _SectionHeader({this.onSeeAll});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Mes projets',
            style: TextStyle(
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