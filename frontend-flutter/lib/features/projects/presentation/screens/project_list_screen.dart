import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
 
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_bar/custom_app_bar.dart';
import '../../../../shared/widgets/app_bar/bottom_nav_bar.dart';
import '../../../../shared/widgets/responsive_builder.dart';
 
class _MockProject {
  final int id;
  final String title;
  final String description;
  final String status;
  final Color statusColor;
 
  const _MockProject({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.statusColor,
  });
}
 
class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});
 
  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}
 
class _ProjectListScreenState extends State<ProjectListScreen> {
  int _navIndex = 2;
  String _filter = 'Tous';
 
  static const _mockProjects = [
    _MockProject(id: 1, title: 'Clean City Challenge',
        description: 'Nettoyage des espaces publics',
        status: 'En cours', statusColor: AppColors.enCours),
    _MockProject(id: 2, title: 'Jeunes & Tech',
        description: 'Formation et innovation pour les jeunes',
        status: 'En cours', statusColor: AppColors.enCours),
    _MockProject(id: 3, title: 'Festival des Cultures',
        description: 'Célébrons la diversité ensemble',
        status: 'En attente', statusColor: AppColors.enAttente),
    _MockProject(id: 4, title: 'Sport pour Tous',
        description: 'Rendre le sport accessible',
        status: 'Refusé', statusColor: AppColors.refuse),
    _MockProject(id: 5, title: 'Jardin Collectif',
        description: 'Maraîchage urbain solidaire',
        status: 'En cours', statusColor: AppColors.enCours),
    _MockProject(id: 6, title: 'Studio Musical',
        description: 'Espace créatif pour les jeunes',
        status: 'En attente', statusColor: AppColors.enAttente),
  ];
 
  static const _filters = ['Tous', 'En cours', 'En attente', 'Terminés'];
 
  List<_MockProject> get _filtered => _filter == 'Tous'
      ? _mockProjects
      : _mockProjects.where((p) => p.status == _filter).toList();
 
  @override
  Widget build(BuildContext context) {
    final bp = Breakpoints.of(context);
 
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Projets', showBack: false),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(RouteNames.projectNew),
        child: const Icon(Icons.add),
      ),
      body: ResponsiveGrid(
        itemCount: _filtered.length,
        padding:   EdgeInsets.all(bp.horizontalPadding),
        header:    _FiltersRow(
          selected:  _filter,
          filters:   _filters,
          onChanged: (f) => setState(() => _filter = f),
        ),
        emptyState: Center(
          child: Text('Aucun projet dans cette catégorie',
              style: AppTypography.bodySmall),
        ),
        itemBuilder: (_, i) => _ProjectCard(
          project: _filtered[i],
          bp:      bp,
          onTap:   () => context.goNamed(
              RouteNames.projectDetail,
              pathParameters: {'id': _filtered[i].id.toString()}),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          switch (i) {
            case 0: context.goNamed(RouteNames.home);       break;
            case 1: context.goNamed(RouteNames.activities); break;
            case 3: context.goNamed(RouteNames.profile);    break;
          }
        },
      ),
    );
  }
}
 
class _FiltersRow extends StatelessWidget {
  final String selected;
  final List<String> filters;
  final void Function(String) onChanged;
 
  const _FiltersRow({
    required this.selected,
    required this.filters,
    required this.onChanged,
  });
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((f) {
            final active = f == selected;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(f),
                selected: active,
                onSelected: (_) => onChanged(f),
                selectedColor: AppColors.primary,
                labelStyle: AppTypography.caption.copyWith(
                  color: active ? AppColors.white : AppColors.textPrimary,
                  fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
 
class _ProjectCard extends StatelessWidget {
  final _MockProject project;
  final BreakpointData bp;
  final VoidCallback onTap;
 
  const _ProjectCard({
    required this.project,
    required this.bp,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color:        project.statusColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.rocket_launch_outlined,
                    color: project.statusColor, size: 20),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color:        project.statusColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(project.status,
                    style: AppTypography.badge.copyWith(
                        color: project.statusColor)),
              ),
            ]),
            const SizedBox(height: 10),
            Text(project.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.h5),
            const SizedBox(height: 4),
            Text(project.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySmall),
          ],
        ),
      ),
    );
  }
}
