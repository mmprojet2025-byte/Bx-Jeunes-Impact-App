import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_bar/custom_app_bar.dart';
import '../../../../shared/widgets/badges/status_badge.dart';
import '../../../../shared/widgets/error_states/error_widget.dart';
import '../../../../shared/widgets/loaders/skeleton_loader.dart';
import '../../application/project_list_provider.dart';
import '../../data/project.dart';

class ProjectListScreen extends ConsumerStatefulWidget {
  const ProjectListScreen({super.key});

  @override
  ConsumerState<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends ConsumerState<ProjectListScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  ProjectStatus? _selectedStatus;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(projectListProvider.notifier).load();
    }
  }

  List<Project> _applySearch(List<Project> items) {
    if (_searchQuery.isEmpty) return items;
    return items
        .where((p) =>
            p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.description.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(projectListProvider);
    final filtered = _applySearch(state.items);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Projets',
        showBack: false,
        actions: [
          // Bouton proposer un projet
          GestureDetector(
            onTap: () => context.goNamed(RouteNames.projectNew),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Proposer',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.red,
        onRefresh: () => ref.read(projectListProvider.notifier).refresh(),
        child: Column(
          children: [
            // ── Recherche ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Rechercher un projet...',
                  prefixIcon: const Icon(Icons.search_outlined,
                      color: AppColors.textHint, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close,
                              color: AppColors.textHint, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
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
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
            ),

            // ── Filtres par statut ────────────────────────────────
            const SizedBox(height: 12),
            _StatusFilters(
              selected: _selectedStatus,
              onChanged: (s) {
                setState(() => _selectedStatus = s);
                ref
                    .read(projectListProvider.notifier)
                    .setStatus(s?.jsonValue);
              },
            ),
            const SizedBox(height: 8),

            // ── Liste ─────────────────────────────────────────────
            Expanded(
              child: state.isLoading && state.items.isEmpty
                  ? _LoadingSkeleton()
                  : state.error != null && state.items.isEmpty
                      ? AppErrorWidget(
                          message: state.error!,
                          onRetry: () =>
                              ref.read(projectListProvider.notifier).refresh(),
                        )
                      : filtered.isEmpty
                          ? _EmptyState(hasFilter: _searchQuery.isNotEmpty || _selectedStatus != null)
                          : ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                              itemCount:
                                  filtered.length + (state.hasMore ? 1 : 0),
                              itemBuilder: (_, i) {
                                if (i == filtered.length) {
                                  return const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.red,
                                          strokeWidth: 2),
                                    ),
                                  );
                                }
                                return _ProjectCard(
                                  project: filtered[i],
                                  onTap: () => context.goNamed(
                                    RouteNames.projectDetail,
                                    pathParameters: {
                                      'id': filtered[i].id.toString()
                                    },
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Filtres statuts ──────────────────────────────────────────────────────────
class _StatusFilters extends StatelessWidget {
  final ProjectStatus? selected;
  final void Function(ProjectStatus?) onChanged;

  const _StatusFilters({required this.selected, required this.onChanged});

  static const _filters = [
    null, // Tous
    ProjectStatus.pending,
    ProjectStatus.validatedByReferent,
    ProjectStatus.transmittedToAdmin,
    ProjectStatus.validatedByAdmin,
    ProjectStatus.visibleToPartners,
    ProjectStatus.completed,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (_, i) {
          final s = _filters[i];
          final isSelected = selected == s;
          final label = s == null ? 'Tous' : s.label;
          final color = s == null ? AppColors.primary : s.color;

          return GestureDetector(
            onTap: () => onChanged(s),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? color : AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? color : AppColors.border,
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Carte projet ─────────────────────────────────────────────────────────────
class _ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const _ProjectCard({required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            // Icône groupe / statut
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: project.status.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.folder_outlined,
                  color: project.status.color, size: 26),
            ),
            const SizedBox(width: 12),

            // Infos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          project.title,
                          style: AppTypography.h5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      StatusBadge(status: _toStatusBadge(project.status)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.description,
                    style: AppTypography.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (project.groupName != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.group_outlined,
                            size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(project.groupName!,
                            style: AppTypography.bodySmall),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 8),
            const Icon(Icons.chevron_right,
                size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  // Convertit ProjectStatus → ProjectStatus du badge (même enum dans ce projet)
  ProjectStatus _toStatusBadge(ProjectStatus s) => s;
}

// ── Skeleton ─────────────────────────────────────────────────────────────────
class _LoadingSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: 5,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: SkeletonLoader(
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}

// ── État vide ────────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final bool hasFilter;
  const _EmptyState({required this.hasFilter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.folder_off_outlined,
                  color: AppColors.primary, size: 36),
            ),
            const SizedBox(height: 20),
            Text(
              hasFilter ? 'Aucun projet trouvé' : 'Pas encore de projets',
              style: AppTypography.h4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              hasFilter
                  ? 'Essaie un autre filtre ou recherche.'
                  : 'Sois le premier à proposer un projet !',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
