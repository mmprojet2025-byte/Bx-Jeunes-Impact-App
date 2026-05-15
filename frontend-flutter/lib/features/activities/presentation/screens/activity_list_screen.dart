import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
 
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_bar/custom_app_bar.dart';
import '../../../../shared/widgets/app_bar/bottom_nav_bar.dart';
import '../../../../shared/widgets/responsive_builder.dart';
 
// Mock model — remplacer par Activity.fromJson une fois le provider branché
class _MockActivity {
  final int id;
  final String name;
  final String date;
  final String category;
  final Color categoryColor;
 
  const _MockActivity({
    required this.id,
    required this.name,
    required this.date,
    required this.category,
    required this.categoryColor,
  });
}
 
class ActivityListScreen extends StatefulWidget {
  const ActivityListScreen({super.key});
 
  @override
  State<ActivityListScreen> createState() => _ActivityListScreenState();
}
 
class _ActivityListScreenState extends State<ActivityListScreen> {
  int _navIndex = 1;
 
  // Mock data — remplacer par ref.watch(activityListProvider)
  static const _mockActivities = [
    _MockActivity(id: 1, name: 'Tournoi de Basket', date: '25 Mai 2024 • 14:00',
        category: 'Événement', categoryColor: AppColors.primary),
    _MockActivity(id: 2, name: 'Atelier Art & Création', date: '28 Mai 2024 • 16:00',
        category: 'Atelier', categoryColor: AppColors.secondary),
    _MockActivity(id: 3, name: 'Journée de Reboisement', date: '02 Juin 2024 • 09:00',
        category: 'Sortie', categoryColor: AppColors.success),
    _MockActivity(id: 4, name: 'Atelier Prise de Parole', date: '10 Juin 2024 • 15:00',
        category: 'Formation', categoryColor: AppColors.culture),
    _MockActivity(id: 5, name: 'Match de Foot', date: '20 Mai 2024 • 15:00',
        category: 'Sport', categoryColor: AppColors.sport),
    _MockActivity(id: 6, name: 'Atelier Cuisine', date: '26 Mai 2024 • 14:00',
        category: 'Atelier', categoryColor: AppColors.secondary),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Activités', showBack: false),
      body: MasterDetailLayout<_MockActivity>(
        masterBuilder: (ctx, bp, onSelect) => _buildList(ctx, bp, onSelect),
        detailBuilder: (ctx, bp, selected) => selected != null
            ? _ActivityDetailPanel(activity: selected)
            : const NoSelectionPlaceholder(
                message: 'Sélectionnez une activité pour voir les détails',
                icon: Icons.event_outlined,
              ),
        onPhoneTap: (activity) => context.goNamed(
          RouteNames.activityDetail,
          pathParameters: {'id': activity.id.toString()},
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          switch (i) {
            case 0: context.goNamed(RouteNames.home);       break;
            case 2: context.goNamed(RouteNames.projects);   break;
            case 3: context.goNamed(RouteNames.profile);    break;
          }
        },
      ),
    );
  }
 
  Widget _buildList(
      BuildContext ctx,
      BreakpointData bp,
      void Function(_MockActivity) onSelect) {
    return ResponsiveGrid(
      itemCount: _mockActivities.length,
      padding: EdgeInsets.all(bp.horizontalPadding),
      header: _SearchAndFilters(bp: bp),
      itemBuilder: (_, i) => _ActivityCard(
        activity: _mockActivities[i],
        bp:       bp,
        onTap:    () => onSelect(_mockActivities[i]),
      ),
    );
  }
}
 
// ── Search + Filters ──────────────────────────────────────────
 
class _SearchAndFilters extends StatelessWidget {
  final BreakpointData bp;
  const _SearchAndFilters({required this.bp});
 
  static const _categories = ['Toutes', 'Sport', 'Culture', 'Solidarité', 'Autre'];
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Barre de recherche
        TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher une activité…',
            prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
            suffixIcon: const Icon(Icons.tune_outlined, color: AppColors.textSecondary, size: 20),
          ),
        ),
        const SizedBox(height: 12),
        // Chips de filtres
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.map((cat) {
              final isFirst = cat == 'Toutes';
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(cat),
                  selected: isFirst,
                  onSelected: (_) {},
                  selectedColor: AppColors.primary,
                  labelStyle: AppTypography.caption.copyWith(
                    color: isFirst ? AppColors.white : AppColors.textPrimary,
                    fontWeight: isFirst ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
 
// ── Activity Card (liste) ─────────────────────────────────────
 
class _ActivityCard extends StatelessWidget {
  final _MockActivity activity;
  final BreakpointData bp;
  final VoidCallback onTap;
 
  const _ActivityCard({
    required this.activity,
    required this.bp,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:        AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color:      AppColors.shadowLight,
              blurRadius: 8,
              offset:     Offset(0, 2),
            ),
          ],
        ),
        child: Row(children: [
          // Icône catégorie
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(
              color:        activity.categoryColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.event_outlined,
                color: activity.categoryColor, size: 22),
          ),
          const SizedBox(width: 12),
          // Infos
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(activity.name, maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.h5),
              const SizedBox(height: 4),
              Text(activity.date, style: AppTypography.caption),
            ],
          )),
          // Badge catégorie
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color:        activity.categoryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(activity.category,
                style: AppTypography.badge.copyWith(
                    color: activity.categoryColor)),
          ),
        ]),
      ),
    );
  }
}
 
// ── Detail panel (tablette uniquement) ───────────────────────
 
class _ActivityDetailPanel extends StatelessWidget {
  final _MockActivity activity;
  const _ActivityDetailPanel({required this.activity});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: activity.categoryColor.withOpacity(.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(Icons.event_outlined,
                  color: activity.categoryColor, size: 64),
            ),
          ),
          const SizedBox(height: 20),
          Text(activity.name, style: AppTypography.h2),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.schedule, size: 14,
                color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(activity.date, style: AppTypography.bodySmall),
          ]),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.goNamed(
                  RouteNames.activityDetail,
                  pathParameters: {'id': activity.id.toString()}),
              child: const Text('Voir le détail complet'),
            ),
          ),
        ],
      ),
    );
  }
}
