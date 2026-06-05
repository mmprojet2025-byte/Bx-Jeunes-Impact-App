import 'package:bx_jeunes_impact/features/projects/data/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/badges/role_badge.dart';
import '../../../../shared/widgets/badges/status_badge.dart';
import '../../../../shared/widgets/error_states/error_widget.dart';
import '../../../../shared/widgets/skeleton_loader.dart';
import '../../../dashboard/application/stats_provider.dart';
import '../../../dashboard/data/statistics_models.dart';
import '../../../members/application/member_list_provider.dart';
import '../../../members/data/member_models.dart';
import '../../../projects/application/project_list_provider.dart';
import '../../../projects/application/project_validation_provider.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _AdminAppBar(tabController: _tabController),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _OverviewTab(),
          _MembersTab(),
          _ProjectsTab(),
          _StatsTab(),
        ],
      ),
    );
  }
}

// ── AppBar admin avec TabBar ──────────────────────────────────────────────────
class _AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  const _AdminAppBar({required this.tabController});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.admin_panel_settings_outlined,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Espace Admin',
                  style: AppTypography.h5
                      .copyWith(color: AppColors.textPrimary)),
              Text('Bx-Jeunes Impact',
                  style: AppTypography.caption),
            ],
          ),
        ],
      ),
      actions: [
        Consumer(builder: (_, ref, __) {
          return IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: AppColors.textPrimary),
            onPressed: () => context.goNamed(RouteNames.notifications),
          );
        }),
      ],
      bottom: TabBar(
        controller: tabController,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorWeight: 2.5,
        labelStyle: const TextStyle(
            fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(
            fontFamily: 'Inter', fontSize: 12),
        tabs: const [
          Tab(icon: Icon(Icons.dashboard_outlined, size: 18), text: 'Aperçu'),
          Tab(icon: Icon(Icons.people_outline, size: 18), text: 'Membres'),
          Tab(icon: Icon(Icons.folder_outlined, size: 18), text: 'Projets'),
          Tab(icon: Icon(Icons.bar_chart_outlined, size: 18), text: 'Stats'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ONGLET 1 — VUE D'ENSEMBLE
// ═══════════════════════════════════════════════════════════════════════════
class _OverviewTab extends ConsumerWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsProvider);
    final projectState = ref.watch(projectListProvider);

    // Projets en attente de validation admin
    final pending = projectState.items
        .where((p) =>
            p.status == ProjectStatus.pending ||
            p.status == ProjectStatus.validatedByReferent ||
            p.status == ProjectStatus.transmittedToAdmin)
        .toList();

    return RefreshIndicator(
      color: AppColors.red,
      onRefresh: () async {
        ref.refresh(statsProvider);
        ref.read(projectListProvider.notifier).refresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Salutation
            Text('Bonjour, Admin 👋', style: AppTypography.h2),
            const SizedBox(height: 4),
            Text('Aperçu de l\'activité de l\'association.',
                style: AppTypography.bodySmall),
            const SizedBox(height: 20),

            // KPI
            statsAsync.when(
              loading: () => _KpiSkeleton(),
              error: (e, _) => AppErrorWidget(
                  message: e.toString(),
                  onRetry: () => ref.refresh(statsProvider)),
              data: (stats) => _KpiGrid(stats: stats),
            ),

            const SizedBox(height: 24),

            // Projets à valider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('À valider', style: AppTypography.h3),
                if (pending.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${pending.length}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            if (projectState.isLoading && projectState.items.isEmpty)
              _listSkeleton()
            else if (pending.isEmpty)
              _EmptyValidation()
            else
              ...pending.take(3).map((p) => _PendingProjectCard(project: p)),

            const SizedBox(height: 24),

            // Accès rapides
            Text('Accès rapides', style: AppTypography.h3),
            const SizedBox(height: 12),
            _QuickActionsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _listSkeleton() => Column(
        children: List.generate(
          2,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SkeletonLoader(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.shimmerBase,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ),
      );
}

// ── KPI Grid ─────────────────────────────────────────────────────────────────
class _KpiGrid extends StatelessWidget {
  final AppStats stats;
  const _KpiGrid({required this.stats});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.6,
      children: [
        _KpiCard(
          label: 'Jeunes inscrits',
          value: '${stats.totalMembers}',
          icon: Icons.people_outline,
          color: AppColors.primary,
        ),
        _KpiCard(
          label: 'Activités',
          value: '${stats.totalActivities}',
          icon: Icons.event_outlined,
          color: AppColors.orange,
        ),
        _KpiCard(
          label: 'Projets',
          value: '${stats.totalProjects}',
          icon: Icons.folder_outlined,
          color: AppColors.success,
        ),
        _KpiCard(
          label: 'Groupes actifs',
          value: '${stats.activeGroups}',
          icon: Icons.group_outlined,
          color: AppColors.tertiary,
        ),
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(label, style: AppTypography.h5),
        ],
      ),
    );
  }
}

class _KpiSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.6,
      children: List.generate(
        4,
        (_) => SkeletonLoader(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Projet en attente ────────────────────────────────────────────────────────
class _PendingProjectCard extends ConsumerStatefulWidget {
  final Project project;
  const _PendingProjectCard({required this.project});

  @override
  ConsumerState<_PendingProjectCard> createState() =>
      _PendingProjectCardState();
}

class _PendingProjectCardState extends ConsumerState<_PendingProjectCard> {
  bool _done = false;
  bool _validated = false;

  Future<void> _act(bool validate) async {
    final newStatus = validate
        ? ProjectStatus.validatedByAdmin.jsonValue
        : ProjectStatus.refusedByAdmin.jsonValue;

    final ok = await ref
        .read(projectValidationProvider.notifier)
        .validate(widget.project.id, newStatus);

    if (ok && mounted) {
      setState(() {
        _done = true;
        _validated = validate;
      });
      ref.read(projectListProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final valState = ref.watch(projectValidationProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 6,
              offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.project.title,
                  style: AppTypography.h5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              StatusBadge(status: widget.project.status),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              if (widget.project.creatorName != null)
                _Meta(
                    icon: Icons.person_outline,
                    text: widget.project.creatorName!),
              if (widget.project.groupName != null)
                _Meta(
                    icon: Icons.group_outlined,
                    text: widget.project.groupName!),
            ],
          ),
          const SizedBox(height: 10),
          if (_done)
            Row(
              children: [
                Icon(
                  _validated
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  color: _validated ? AppColors.success : AppColors.error,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  _validated ? 'Projet validé ✓' : 'Projet refusé',
                  style: AppTypography.colored(
                    AppTypography.bodySmall,
                    _validated ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _ActionBtn(
                    label: '✓ Valider',
                    primary: true,
                    loading: valState.isLoading,
                    onTap: () => _act(true),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionBtn(
                    label: '✕ Refuser',
                    primary: false,
                    loading: valState.isLoading,
                    onTap: () => _act(false),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final bool primary;
  final bool loading;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.label,
    required this.primary,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          gradient: primary
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.orange])
              : null,
          color: primary ? null : AppColors.error.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: primary ? null : Border.all(color: AppColors.error),
        ),
        alignment: Alignment.center,
        child: loading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: primary ? Colors.white : AppColors.error,
                  strokeWidth: 2,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primary ? Colors.white : AppColors.error,
                ),
              ),
      ),
    );
  }
}

class _EmptyValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline,
              color: AppColors.success, size: 24),
          const SizedBox(width: 12),
          Text('Tout est à jour — aucun projet en attente.',
              style: AppTypography.colored(
                  AppTypography.body, AppColors.success)),
        ],
      ),
    );
  }
}

// ── Accès rapides ─────────────────────────────────────────────────────────────
class _QuickActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      (Icons.person_add_outlined, 'Ajouter\nmembre', RouteNames.memberList),
      (Icons.add_box_outlined, 'Nouvelle\nactivité', RouteNames.activityNew),
      (Icons.group_add_outlined, 'Nouveau\ngroupe', RouteNames.groupNew),
      (Icons.handshake_outlined, 'Partenaires', RouteNames.partnerList),
    ];

    return Row(
      children: actions
          .map(
            (a) => Expanded(
              child: GestureDetector(
                onTap: () => context.goNamed(a.$3),
                child: Container(
                  margin: EdgeInsets.only(
                      right: a == actions.last ? 0 : 10),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Icon(a.$1, color: AppColors.primary, size: 22),
                      const SizedBox(height: 6),
                      Text(
                        a.$2,
                        textAlign: TextAlign.center,
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ONGLET 2 — MEMBRES
// ═══════════════════════════════════════════════════════════════════════════
class _MembersTab extends ConsumerStatefulWidget {
  const _MembersTab();

  @override
  ConsumerState<_MembersTab> createState() => _MembersTabState();
}

class _MembersTabState extends ConsumerState<_MembersTab> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(memberListProvider);

    return Column(
      children: [
        // Barre de recherche
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (q) => ref
                      .read(memberListProvider.notifier)
                      .setSearch(q.isEmpty ? null : q),
                  decoration: InputDecoration(
                    hintText: 'Rechercher un membre...',
                    prefixIcon: const Icon(Icons.search_outlined,
                        color: AppColors.textHint, size: 20),
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: AppColors.primary, width: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => context.goNamed(RouteNames.memberList),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.orange],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.people_outline,
                      color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Compteur
        if (state.items.isNotEmpty)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text('${state.items.length} membres',
                    style: AppTypography.bodySmall),
              ],
            ),
          ),

        // Liste
        Expanded(
          child: state.isLoading && state.items.isEmpty
              ? _memberSkeleton()
              : state.error != null && state.items.isEmpty
                  ? AppErrorWidget(
                      message: state.error!,
                      onRetry: () =>
                          ref.read(memberListProvider.notifier).refresh())
                  : state.items.isEmpty
                      ? Center(
                          child: Text('Aucun membre trouvé',
                              style: AppTypography.bodySmall))
                      : RefreshIndicator(
                          color: AppColors.red,
                          onRefresh: () =>
                              ref.read(memberListProvider.notifier).refresh(),
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                16, 4, 16, 24),
                            itemCount: state.items.length,
                            itemBuilder: (_, i) =>
                                _MemberCard(member: state.items[i]),
                          ),
                        ),
        ),
      ],
    );
  }

  Widget _memberSkeleton() => ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        itemCount: 6,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SkeletonLoader(
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      );
}

class _MemberCard extends StatelessWidget {
  final MemberSummary member;
  const _MemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(
        RouteNames.memberDetail,
        pathParameters: {'id': member.id.toString()},
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withOpacity(0.12),
              child: Text(
                member.initials,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.fullName, style: AppTypography.h5),
                  const SizedBox(height: 2),
                  Text(member.email, style: AppTypography.caption),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      RoleBadge(role: member.primaryRole),
                      if (member.groupName != null) ...[
                        const SizedBox(width: 6),
                        Text('• ${member.groupName}',
                            style: AppTypography.caption),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Icon(Icons.chevron_right,
                    size: 18, color: AppColors.textSecondary),
                if (!member.active)
                  const Icon(Icons.block_outlined,
                      size: 14, color: AppColors.error),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ONGLET 3 — PROJETS (gestion complète)
// ═══════════════════════════════════════════════════════════════════════════
class _ProjectsTab extends ConsumerStatefulWidget {
  const _ProjectsTab();

  @override
  ConsumerState<_ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends ConsumerState<_ProjectsTab> {
  ProjectStatus? _filter;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(projectListProvider);
    final filtered = _filter == null
        ? state.items
        : state.items.where((p) => p.status == _filter).toList();

    return Column(
      children: [
        // Filtres
        const SizedBox(height: 12),
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _FilterPill(
                  label: 'Tous', selected: _filter == null,
                  color: AppColors.primary,
                  onTap: () => setState(() => _filter = null)),
              _FilterPill(
                  label: 'En attente',
                  selected: _filter == ProjectStatus.pending,
                  color: AppColors.enAttente,
                  onTap: () =>
                      setState(() => _filter = ProjectStatus.pending)),
              _FilterPill(
                  label: 'Validé référent',
                  selected: _filter == ProjectStatus.validatedByReferent,
                  color: AppColors.enCours,
                  onTap: () => setState(
                      () => _filter = ProjectStatus.validatedByReferent)),
              _FilterPill(
                  label: 'Validé admin',
                  selected: _filter == ProjectStatus.validatedByAdmin,
                  color: AppColors.valide,
                  onTap: () => setState(
                      () => _filter = ProjectStatus.validatedByAdmin)),
              _FilterPill(
                  label: 'Refusé',
                  selected: _filter == ProjectStatus.refusedByAdmin,
                  color: AppColors.refuse,
                  onTap: () => setState(
                      () => _filter = ProjectStatus.refusedByAdmin)),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Liste
        Expanded(
          child: state.isLoading && state.items.isEmpty
              ? _projSkeleton()
              : RefreshIndicator(
                  color: AppColors.red,
                  onRefresh: () =>
                      ref.read(projectListProvider.notifier).refresh(),
                  child: filtered.isEmpty
                      ? Center(
                          child: Text('Aucun projet',
                              style: AppTypography.bodySmall))
                      : ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(16, 4, 16, 24),
                          itemCount: filtered.length,
                          itemBuilder: (_, i) =>
                              _AdminProjectCard(project: filtered[i]),
                        ),
                ),
        ),
      ],
    );
  }

  Widget _projSkeleton() => ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        itemCount: 4,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SkeletonLoader(
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      );
}

class _AdminProjectCard extends ConsumerStatefulWidget {
  final Project project;
  const _AdminProjectCard({required this.project});

  @override
  ConsumerState<_AdminProjectCard> createState() => _AdminProjectCardState();
}

class _AdminProjectCardState extends ConsumerState<_AdminProjectCard> {
  bool _done = false;
  bool _validated = false;

  bool get _actionable =>
      widget.project.status == ProjectStatus.pending ||
      widget.project.status == ProjectStatus.validatedByReferent ||
      widget.project.status == ProjectStatus.transmittedToAdmin;

  Future<void> _act(bool validate) async {
    final newStatus = validate
        ? ProjectStatus.validatedByAdmin.jsonValue
        : ProjectStatus.refusedByAdmin.jsonValue;
    final ok = await ref
        .read(projectValidationProvider.notifier)
        .validate(widget.project.id, newStatus);
    if (ok && mounted) {
      setState(() {
        _done = true;
        _validated = validate;
      });
      ref.read(projectListProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final valState = ref.watch(projectValidationProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 6,
              offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(widget.project.title,
                    style: AppTypography.h5,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(width: 8),
              StatusBadge(status: widget.project.status),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              if (widget.project.creatorName != null)
                _Meta(
                    icon: Icons.person_outline,
                    text: widget.project.creatorName!),
              if (widget.project.groupName != null)
                _Meta(
                    icon: Icons.group_outlined,
                    text: widget.project.groupName!),
            ],
          ),
          if (_actionable && !_done) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _ActionBtn(
                    label: '✓ Valider',
                    primary: true,
                    loading: valState.isLoading,
                    onTap: () => _act(true),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionBtn(
                    label: '✕ Refuser',
                    primary: false,
                    loading: valState.isLoading,
                    onTap: () => _act(false),
                  ),
                ),
              ],
            ),
          ] else if (_done) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  _validated
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  color: _validated ? AppColors.success : AppColors.error,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  _validated ? 'Validé ✓' : 'Refusé',
                  style: AppTypography.colored(
                    AppTypography.bodySmall,
                    _validated ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ONGLET 4 — STATISTIQUES
// ═══════════════════════════════════════════════════════════════════════════
class _StatsTab extends ConsumerWidget {
  const _StatsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsProvider);

    return statsAsync.when(
      loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.red)),
      error: (e, _) => AppErrorWidget(
          message: e.toString(),
          onRetry: () => ref.refresh(statsProvider)),
      data: (stats) => RefreshIndicator(
        color: AppColors.red,
        onRefresh: () => ref.read(statsProvider.notifier).refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Statistiques', style: AppTypography.h2),
              const SizedBox(height: 4),
              Text('Données globales de l\'association',
                  style: AppTypography.bodySmall),
              const SizedBox(height: 20),

              // Membres par rôle
              Text('Membres par rôle', style: AppTypography.h3),
              const SizedBox(height: 12),
              ...stats.membersByRole.entries.map(
                (e) => _StatBar(
                  label: e.key,
                  count: e.value,
                  total: stats.totalMembers,
                  color: _roleColor(e.key),
                ),
              ),

              const SizedBox(height: 24),

              // Projets par statut
              Text('Projets par statut', style: AppTypography.h3),
              const SizedBox(height: 12),
              if (stats.projectsByStatus.isNotEmpty)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: stats.projectsByStatus.entries
                      .map((e) => _StatChip(
                            label: e.key,
                            count: e.value,
                          ))
                      .toList(),
                ),

              const SizedBox(height: 24),

              // Grille KPI
              Text('Chiffres clés', style: AppTypography.h3),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.6,
                children: [
                  _KpiCard(
                    label: 'Total membres',
                    value: '${stats.totalMembers}',
                    icon: Icons.people_outline,
                    color: AppColors.primary,
                  ),
                  _KpiCard(
                    label: 'Activités',
                    value: '${stats.totalActivities}',
                    icon: Icons.event_outlined,
                    color: AppColors.orange,
                  ),
                  _KpiCard(
                    label: 'Projets totaux',
                    value: '${stats.totalProjects}',
                    icon: Icons.folder_outlined,
                    color: AppColors.success,
                  ),
                  _KpiCard(
                    label: 'Groupes actifs',
                    value: '${stats.activeGroups}',
                    icon: Icons.group_outlined,
                    color: AppColors.tertiary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _roleColor(String role) {
    switch (role.toUpperCase()) {
      case 'YOUTH':
        return AppColors.roleYouth;
      case 'ADMIN':
        return AppColors.roleAdmin;
      case 'GROUP_REFERENT':
        return AppColors.roleReferent;
      case 'PARTNER':
        return AppColors.rolePartner;
      default:
        return AppColors.textSecondary;
    }
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;

  const _StatBar({
    required this.label,
    required this.count,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = total > 0 ? count / total : 0.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTypography.body),
              Text('$count', style: AppTypography.h5),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: ratio.toDouble(),
              minHeight: 8,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int count;
  const _StatChip({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$count',
              style: AppTypography.h3.copyWith(color: AppColors.primary)),
          const SizedBox(height: 2),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}

// ── Widgets helpers partagés ──────────────────────────────────────────────────

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.textSecondary),
        const SizedBox(width: 3),
        Text(text, style: AppTypography.bodySmall),
      ],
    );
  }
}

class _FilterPill extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _FilterPill({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? color : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
