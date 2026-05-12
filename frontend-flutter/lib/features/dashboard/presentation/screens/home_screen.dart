// Écran d'accueil — 6 sections :
//   1. WelcomeBanner       (prénom + avatar)
//   2. NewsPinnedCarousel  (actualités épinglées, max 2)
//   3. UpcomingActivitiesSection — "Mes activités à venir"
//   4. MyProjectsSection   (projets en cours)
//   5. UpcomingActivitiesSection — "Activités proposées par l'ASBL"
//   6. QuickActionsGrid    (raccourcis)
//
// Comportements :
//   - Appels parallèles au chargement (Future.wait via HomeProvider)
//   - Skeleton loaders pendant AsyncLoading
//   - Empty states par section
//   - Pull-to-refresh via RefreshIndicator
//   - Layout tablette : 2 colonnes (>= 768px)
//   - Navigation vers les écrans de détail via RouteNames
 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_config.dart';
import '../../../../core/router/route_names.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/widgets/app_bar/bottom_nav_bar.dart';
import '../../../../shared/widgets/error_states/error_widget.dart';
import '../../../activities/data/activity.dart';
import '../../../activities/data/registration.dart';
import '../../../projects/data/project.dart';
import '../../application/home_provider.dart';
import '../../data/news.dart';
import '../widgets/welcome_banner.dart';
import '../widgets/news_pinned_carousel.dart';
import '../widgets/upcoming_activities_section.dart';
import '../widgets/my_projects_section.dart';
import '../widgets/quick_actions_grid.dart';
 
// ── Breakpoint tablette ───────────────────────────────────────
 
const double _tabletBreakpoint = 768.0;
 
// ── Screen ────────────────────────────────────────────────────
 
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
 
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _navIndex = 0;
 
  @override
  Widget build(BuildContext context) {
    final homeAsync  = ref.watch(homeProvider);
    final currentUser = ref.watch(currentUserProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet    = screenWidth >= _tabletBreakpoint;
 
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: homeAsync.when(
          // ── Erreur globale ────────────────────────────
          error: (error, _) => AppErrorWidget(
            message: error.toString(),
            onRetry: () => ref.refresh(homeProvider),
          ),
 
          // ── Loading + Data : même layout ─────────────
          // Les widgets individuels gèrent leur propre skeleton.
          loading: () => _buildContent(
            context: context,
            data: null,
            user: currentUser,
            isTablet: isTablet,
            isLoading: true,
          ),
          data: (data) => _buildContent(
            context: context,
            data: data,
            user: currentUser,
            isTablet: isTablet,
            isLoading: false,
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          switch (i) {
            case 1: Navigator.pushNamed(context, RouteNames.activities); break;
            case 2: Navigator.pushNamed(context, RouteNames.projects);   break;
            case 3: Navigator.pushNamed(context, RouteNames.profile);    break;
          }
        },
      ),
    );
  }
 
  // ── Content builder ───────────────────────────────────────
 
  Widget _buildContent({
    required BuildContext context,
    required HomeData? data,
    required AppUser? user,
    required bool isTablet,
    required bool isLoading,
  }) {
    return RefreshIndicator(
      color: AppColors.red,
      onRefresh: () => ref.read(homeProvider.notifier).refresh(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // nécessaire pour pull-to-refresh même quand peu de contenu
        slivers: [
 
          // ── 1. Bandeau de bienvenue ───────────────────
          SliverToBoxAdapter(
            child: user != null
                ? WelcomeBanner(
                    user: user,
                    notificationCount: 0, // TODO: brancher notifications provider
                    onProfileTap: () =>
                        Navigator.pushNamed(context, RouteNames.profile),
                    onNotificationTap: () {}, // TODO: ouvrir notifications
                  )
                : const SizedBox(height: 70), // placeholder pendant auth
          ),
 
          // ── 2. Actualités épinglées ───────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: NewsPinnedCarousel(
                news: isLoading ? null : data!.pinnedNews,
                onNewsTap: (news) => _openNewsDetail(context, news),
              ),
            ),
          ),
 
          // ── Layout adaptatif : mobile vs tablette ─────
          SliverToBoxAdapter(
            child: isTablet
                ? _buildTabletLayout(context, data, isLoading)
                : _buildMobileLayout(context, data, isLoading),
          ),
 
          // ── 6. Raccourcis ─────────────────────────────
          SliverToBoxAdapter(
            child: QuickActionsGrid(
              onActivitiesTap: () =>
                  Navigator.pushNamed(context, RouteNames.activities),
              onProjectsTap: () =>
                  Navigator.pushNamed(context, RouteNames.projects),
              onGroupsTap: () =>
                  Navigator.pushNamed(context, RouteNames.groups),
            ),
          ),
 
          // ── Padding bas ───────────────────────────────
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
 
  // ── Mobile layout (1 colonne) ─────────────────────────────
 
  Widget _buildMobileLayout(
    BuildContext context,
    HomeData? data,
    bool isLoading,
  ) {
    return Column(
      children: [
        // 3. Mes activités à venir
        UpcomingActivitiesSection(
          title: 'Mes activités à venir',
          activities: isLoading
              ? null
              : data!.nextThreeRegistrations
                  .map((r) => r.activity)
                  .toList(),
          emptyTitle: 'Aucune activité à venir',
          emptySubtitle: 'Parcourez le catalogue et inscrivez-vous !',
          emptyActionLabel: 'Voir les activités',
          onEmptyAction: () =>
              Navigator.pushNamed(context, RouteNames.activities),
          onSeeAll: () =>
              Navigator.pushNamed(context, RouteNames.activities),
          onActivityTap: (a) => _openActivityDetail(context, a),
        ),
 
        // 4. Mes projets
        MyProjectsSection(
          projects: isLoading ? null : data!.myProjects,
          onSeeAll: () =>
              Navigator.pushNamed(context, RouteNames.projects),
          onProjectTap: (p) => _openProjectDetail(context, p),
        ),
 
        // 5. Activités proposées par l'ASBL
        UpcomingActivitiesSection(
          title: 'Activités proposées par l\'ASBL',
          activities: isLoading ? null : data!.asblActivities,
          emptyTitle: 'Aucune activité planifiée',
          emptySubtitle: 'Revenez bientôt pour découvrir les prochains événements.',
          onSeeAll: () =>
              Navigator.pushNamed(context, RouteNames.activities),
          onActivityTap: (a) => _openActivityDetail(context, a),
        ),
      ],
    );
  }
 
  // ── Tablet layout (2 colonnes) ────────────────────────────
  //
  // Colonne gauche  : Mes activités + Mes projets
  // Colonne droite  : Activités ASBL
 
  Widget _buildTabletLayout(
    BuildContext context,
    HomeData? data,
    bool isLoading,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Gauche ──────────────────────────────────
          Expanded(
            child: Column(
              children: [
                UpcomingActivitiesSection(
                  title: 'Mes activités à venir',
                  activities: isLoading
                      ? null
                      : data!.nextThreeRegistrations
                          .map((r) => r.activity)
                          .toList(),
                  emptyTitle: 'Aucune activité à venir',
                  emptySubtitle: 'Parcourez le catalogue !',
                  emptyActionLabel: 'Voir les activités',
                  onEmptyAction: () =>
                      Navigator.pushNamed(context, RouteNames.activities),
                  onSeeAll: () =>
                      Navigator.pushNamed(context, RouteNames.activities),
                  onActivityTap: (a) => _openActivityDetail(context, a),
                ),
                MyProjectsSection(
                  projects: isLoading ? null : data!.myProjects,
                  onSeeAll: () =>
                      Navigator.pushNamed(context, RouteNames.projects),
                  onProjectTap: (p) => _openProjectDetail(context, p),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
 
          // ── Droite ──────────────────────────────────
          Expanded(
            child: UpcomingActivitiesSection(
              title: 'Activités de l\'ASBL',
              activities: isLoading ? null : data!.asblActivities,
              emptyTitle: 'Aucune activité planifiée',
              emptySubtitle: 'Revenez bientôt.',
              onSeeAll: () =>
                  Navigator.pushNamed(context, RouteNames.activities),
              onActivityTap: (a) => _openActivityDetail(context, a),
            ),
          ),
        ],
      ),
    );
  }
 
  // ── Navigation helpers ────────────────────────────────────
 
  void _openActivityDetail(BuildContext context, Activity activity) {
    Navigator.pushNamed(
      context,
      RouteNames.activityDetail.replaceFirst(':id', activity.id.toString()),
    );
  }
 
  void _openProjectDetail(BuildContext context, Project project) {
    Navigator.pushNamed(
      context,
      RouteNames.projectDetail.replaceFirst(':id', project.id.toString()),
    );
  }
 
  void _openNewsDetail(BuildContext context, News news) {
    // TODO: implémenter quand NewsDetailScreen est disponible
    // Navigator.pushNamed(context, RouteNames.newsDetail.replaceFirst(':id', news.id.toString()));
  }
}
 