import 'package:bx_jeunes_impact/features/projects/data/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/widgets/app_bar/custom_app_bar.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/buttons/secondary_button.dart';
import '../../../../shared/widgets/error_states/error_widget.dart';
import '../../application/participation_requests_provider.dart';
import '../../application/project_detail_provider.dart';
import '../../application/project_validation_provider.dart';

class ProjectDetailScreen extends ConsumerWidget {
  final int projectId;
  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectDetailProvider(projectId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Projet',
        actions: [
          projectAsync.whenData((p) {
            final user = ref.watch(currentUserProvider);
            if (user == null) return const SizedBox.shrink();
            final canEdit = user.id == p.creatorId || user.isAdmin || user.isReferent;
            if (!canEdit) return const SizedBox.shrink();
            return IconButton(
              icon: const Icon(Icons.edit_outlined, color: AppColors.textPrimary),
              onPressed: () => context.goNamed(RouteNames.projectEdit,
                  pathParameters: {'id': p.id.toString()}),
            );
          }).valueOrNull ?? const SizedBox.shrink(),
        ],
      ),
      body: projectAsync.when(
        loading: () => const _DetailSkeleton(),
        error:   (err, _) => AppErrorWidget(
            message: err.toString(),
            onRetry: () => ref.refresh(projectDetailProvider(projectId))),
        data: (project) => _ProjectBody(project: project, projectId: projectId),
      ),
    );
  }
}

class _ProjectBody extends ConsumerWidget {
  final Project project;
  final int projectId;   // explicit int type
  const _ProjectBody({required this.project, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user            = ref.watch(currentUserProvider);
    final validationState = ref.watch(projectValidationProvider);
    final isCreator  = user?.id == project.creatorId;
    final isAdmin    = user?.isAdmin   ?? false;
    final isReferent = user?.isReferent ?? false;

    return RefreshIndicator(
      color: AppColors.red,
      onRefresh: () async => ref.refresh(projectDetailProvider(projectId)),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          _StatusBanner(status: project.status),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Text(project.title, style: AppTypography.h2),
              const SizedBox(height: 8),

              Row(children: [
                const Icon(Icons.person_outline, size: 15, color: AppColors.textSecondary),
                const SizedBox(width: 5),
                Text(project.creatorName ?? 'Inconnu', style: AppTypography.bodySmall),
                if (project.groupName != null) ...[
                  const SizedBox(width: 12),
                  const Icon(Icons.group_outlined, size: 15, color: AppColors.textSecondary),
                  const SizedBox(width: 5),
                  Text(project.groupName!, style: AppTypography.bodySmall),
                ],
              ]),

              if (project.createdAt != null) ...[
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 5),
                  Text(_fmt(project.createdAt!), style: AppTypography.caption),
                ]),
              ],

              const SizedBox(height: 24),
              Text('Description', style: AppTypography.h4),
              const SizedBox(height: 8),
              Text(project.description, style: AppTypography.bodyLarge),

              const SizedBox(height: 24),
              _ValidationTimeline(project: project),
              const SizedBox(height: 24),

              if (validationState.error != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.errorLight, borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Text(validationState.error!,
                      style: AppTypography.colored(AppTypography.bodySmall, AppColors.error)),
                ),

              _ActionButtons(
                project: project,
                isCreator: isCreator, isAdmin: isAdmin, isReferent: isReferent,
                isLoading: validationState.isLoading,
                onValidateReferent: () => _validate(context, ref, ProjectStatus.validatedByReferent),
                onRefuseReferent:   () => _refuse(context, ref, isAdmin: false),
                onTransmit:         () => _validate(context, ref, ProjectStatus.transmittedToAdmin),
                onValidateAdmin:    () => _validate(context, ref, ProjectStatus.validatedByAdmin),
                onRefuseAdmin:      () => _refuse(context, ref, isAdmin: true),
                onMakeVisible:      () => _validate(context, ref, ProjectStatus.visibleToPartners),
                onParticipate:      () => _requestParticipation(context, ref),
                onViewMembers: () => context.goNamed(RouteNames.projectMembers,
                    pathParameters: {'id': project.id.toString()}),
              ),

              const SizedBox(height: 24),
            ]),
          ),
        ]),
      ),
    );
  }

  Future<void> _validate(BuildContext context, WidgetRef ref, ProjectStatus s) async {
    final ok = await ref.read(projectValidationProvider.notifier)
      .validate(projectId as int, s.jsonValue);
    if (ok && context.mounted) {
      ref.refresh(projectDetailProvider(projectId as int));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Statut mis à jour'),
        backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ));
    }
  }

  Future<void> _refuse(BuildContext context, WidgetRef ref, {required bool isAdmin}) async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Refuser le projet'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Motif (optionnel) :'),
          const SizedBox(height: 8),
          TextField(controller: ctrl, maxLines: 3,
              decoration: const InputDecoration(hintText: 'Expliquez la raison…')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error, foregroundColor: Colors.white),
            child: const Text('Refuser'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await _validate(context, ref,
          isAdmin ? ProjectStatus.refusedByAdmin : ProjectStatus.refusedByReferent);
    }
  }

  Future<void> _requestParticipation(BuildContext context, WidgetRef ref) async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Demander à participer'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Message de motivation (optionnel) :'),
          const SizedBox(height: 8),
          TextField(controller: ctrl, maxLines: 3,
              decoration: const InputDecoration(hintText: 'Pourquoi souhaitez-vous rejoindre ce projet ?')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
            child: const Text('Envoyer'),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await ref.read(participationRequestsProvider(projectId).notifier)
          .sendRequest(message: ctrl.text.trim().isEmpty ? null : ctrl.text.trim());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Demande de participation envoyée !'),
          backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
        ));
      }
    }
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _StatusBanner extends StatelessWidget {
  final ProjectStatus status;
  const _StatusBanner({required this.status});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    color: status.color.withOpacity(0.1),
    child: Row(children: [
      Container(width: 10, height: 10,
          decoration: BoxDecoration(color: status.color, shape: BoxShape.circle)),
      const SizedBox(width: 10),
      Text(status.label,
          style: AppTypography.colored(
              AppTypography.label.copyWith(fontWeight: FontWeight.w600), status.color)),
    ]),
  );
}

class _ValidationTimeline extends StatelessWidget {
  final Project project;
  const _ValidationTimeline({required this.project});

  @override
  Widget build(BuildContext context) {
    final steps = [
      (label: 'Soumis',                 done: true,                                                                                                   date: project.createdAt),
      (label: 'Validé par le référent', done: !project.status.isRefused && project.status.index >= ProjectStatus.validatedByReferent.index,           date: project.referentValidationDate),
      (label: 'Transmis à l\'admin',    done: !project.status.isRefused && project.status.index >= ProjectStatus.transmittedToAdmin.index,            date: null as DateTime?),
      (label: 'Validé par l\'admin',    done: !project.status.isRefused && project.status.index >= ProjectStatus.validatedByAdmin.index,              date: project.adminValidationDate),
      (label: 'Visible aux partenaires',done: project.status == ProjectStatus.visibleToPartners || project.status == ProjectStatus.completed,         date: null as DateTime?),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Circuit de validation', style: AppTypography.h5),
        const SizedBox(height: 14),
        ...steps.asMap().entries.map((e) => _TimelineStep(
          label: e.value.label,
          done: e.value.done,
          refused: project.status.isRefused && e.key == 1,
          isLast: e.key == steps.length - 1,
          date: e.value.date,
        )),
      ]),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final String label;
  final bool done, refused, isLast;
  final DateTime? date;
  const _TimelineStep({required this.label, required this.done, required this.refused, required this.isLast, this.date});

  @override
  Widget build(BuildContext context) {
    final color = refused ? AppColors.error : done ? AppColors.success : AppColors.border;
    return IntrinsicHeight(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 24, child: Column(children: [
          Container(
            width: 20, height: 20,
            decoration: BoxDecoration(
                color: done || refused ? color : AppColors.white, shape: BoxShape.circle,
                border: Border.all(color: color, width: 2)),
            child: done || refused
                ? Icon(refused ? Icons.close : Icons.check, size: 12, color: Colors.white)
                : null,
          ),
          if (!isLast) Expanded(child: Container(width: 2, color: done ? AppColors.success : AppColors.border)),
        ])),
        const SizedBox(width: 10),
        Expanded(child: Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: AppTypography.body.copyWith(
                color: done || refused ? AppColors.textPrimary : AppColors.textSecondary)),
            if (date != null)
              Text('${date!.day}/${date!.month}/${date!.year}', style: AppTypography.caption),
          ]),
        )),
      ]),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final Project project;
  final bool isCreator, isAdmin, isReferent, isLoading;
  final VoidCallback onValidateReferent, onRefuseReferent, onTransmit,
      onValidateAdmin, onRefuseAdmin, onMakeVisible, onParticipate, onViewMembers;
  const _ActionButtons({
    required this.project, required this.isCreator, required this.isAdmin,
    required this.isReferent, required this.isLoading, required this.onValidateReferent,
    required this.onRefuseReferent, required this.onTransmit, required this.onValidateAdmin,
    required this.onRefuseAdmin, required this.onMakeVisible, required this.onParticipate,
    required this.onViewMembers,
  });

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    if (isReferent && project.status == ProjectStatus.pending) {
      widgets.addAll([
        PrimaryButton(label: 'Valider', loading: isLoading, onTap: onValidateReferent),
        const SizedBox(height: 10),
        SecondaryButton(label: 'Refuser', onTap: onRefuseReferent),
        const SizedBox(height: 10),
      ]);
    }
    if (isReferent && project.status == ProjectStatus.validatedByReferent) {
      widgets.addAll([
        PrimaryButton(label: 'Transmettre à l\'admin', loading: isLoading, onTap: onTransmit),
        const SizedBox(height: 10),
      ]);
    }
    if (isAdmin && project.status == ProjectStatus.transmittedToAdmin) {
      widgets.addAll([
        PrimaryButton(label: 'Valider définitivement', loading: isLoading, onTap: onValidateAdmin),
        const SizedBox(height: 10),
        SecondaryButton(label: 'Refuser', onTap: onRefuseAdmin),
        const SizedBox(height: 10),
      ]);
    }
    if (isAdmin && project.status == ProjectStatus.validatedByAdmin) {
      widgets.addAll([
        PrimaryButton(label: 'Rendre visible aux partenaires', loading: isLoading, onTap: onMakeVisible),
        const SizedBox(height: 10),
      ]);
    }
    if (!isCreator && !isAdmin && !isReferent && project.status.isActive) {
      widgets.addAll([
        PrimaryButton(label: 'Demander à participer', loading: false, onTap: onParticipate),
        const SizedBox(height: 10),
      ]);
    }
    if (project.status != ProjectStatus.pending) {
      widgets.add(SecondaryButton(label: 'Voir les membres', onTap: onViewMembers));
    }

    if (widgets.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: widgets);
  }
}

class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SkeletonLoader(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SkeletonLoader(
            child: Container(
              height: 24,
              width: 200,
              color: AppColors.shimmerBase,
            ),
          ),
          const SizedBox(height: 12),
          SkeletonLoader(
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SkeletonLoader(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
