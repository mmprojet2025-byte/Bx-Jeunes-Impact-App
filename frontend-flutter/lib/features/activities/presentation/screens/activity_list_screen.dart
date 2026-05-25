import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_bar/custom_app_bar.dart';
import '../../../../shared/widgets/error_states/error_widget.dart';
import '../../../../shared/widgets/loaders/skeleton_loader.dart';
import '../../application/activity_list_provider.dart';
import '../../data/activity.dart';
import '../widgets/activity_card.dart';
import '../widgets/activity_filters.dart';

class ActivityListScreen extends ConsumerStatefulWidget {
  const ActivityListScreen({super.key});

  @override
  ConsumerState<ActivityListScreen> createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends ConsumerState<ActivityListScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  ActivityCategory? _selectedCategory;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(activityListProvider.notifier).load();
    }
  }

  List<Activity> _applySearch(List<Activity> items) {
    if (_searchQuery.isEmpty) return items;
    return items
        .where((a) =>
            a.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (a.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
                false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(activityListProvider);
    final filtered = _applySearch(state.items);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Activités',
        showBack: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.red,
        onRefresh: () => ref.read(activityListProvider.notifier).refresh(),
        child: Column(
          children: [
            // ── Barre de recherche ────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Rechercher une activité...',
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

            // ── Filtres par catégorie ─────────────────────────────
            const SizedBox(height: 12),
            ActivityFilters(
              selected: _selectedCategory,
              onChanged: (cat) {
                setState(() => _selectedCategory = cat);
                ref
                    .read(activityListProvider.notifier)
                    .setCategory(cat?.jsonValue);
              },
            ),
            const SizedBox(height: 8),

            // ── Compteur ──────────────────────────────────────────
            if (!state.isLoading || state.items.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      '${filtered.length} activité${filtered.length > 1 ? 's' : ''}',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),

            // ── Liste ─────────────────────────────────────────────
            Expanded(
              child: state.isLoading && state.items.isEmpty
                  ? _LoadingSkeleton()
                  : state.error != null && state.items.isEmpty
                      ? AppErrorWidget(
                          message: state.error!,
                          onRetry: () =>
                              ref.read(activityListProvider.notifier).refresh(),
                        )
                      : filtered.isEmpty
                          ? _EmptyState(hasFilter: _searchQuery.isNotEmpty || _selectedCategory != null)
                          : ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.only(top: 4, bottom: 24),
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
                                return ActivityCard(
                                  activity: filtered[i],
                                  onTap: () => context.goNamed(
                                    RouteNames.activityDetail,
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

// ── Skeleton loader ──────────────────────────────────────────────────────────
class _LoadingSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 6,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: SkeletonLoader(
          child: Container(
            height: 84,
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
              child: const Icon(Icons.event_busy_outlined,
                  color: AppColors.primary, size: 36),
            ),
            const SizedBox(height: 20),
            Text(
              hasFilter
                  ? 'Aucune activité trouvée'
                  : 'Pas encore d\'activités',
              style: AppTypography.h4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              hasFilter
                  ? 'Essaie un autre filtre ou une autre recherche.'
                  : 'Les prochaines activités apparaîtront ici.',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
