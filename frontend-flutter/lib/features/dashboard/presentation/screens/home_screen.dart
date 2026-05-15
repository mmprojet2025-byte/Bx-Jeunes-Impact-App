import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
 
import '../../../../core/constants/breakpoints.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/widgets/app_bar/bottom_nav_bar.dart';
import '../../../../shared/widgets/error_states/error_widget.dart';
import '../../../activities/data/activity.dart';
import '../../../projects/data/project.dart';
import '../../application/home_provider.dart';
import '../../data/news.dart';
import '../widgets/my_projects_section.dart';
import '../widgets/news_pinned_carousel.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/upcoming_activities_section.dart';
import '../widgets/welcome_banner.dart';
 
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
 
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _navIndex = 0;
 
  @override
  Widget build(BuildContext context) {
    final homeAsync   = ref.watch(homeProvider);
    final currentUser = ref.watch(currentUserProvider);
    // FIX : utilise Breakpoints.of() au lieu de la constante locale 768.0
    final bp = Breakpoints.of(context);
 
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: homeAsync.when(
          error: (error, _) => AppErrorWidget(
            message: error.toString(),
            onRetry:  () => ref.refresh(homeProvider),
          ),
          loading: () => _buildContent(
              data: null, user: currentUser, bp: bp, isLoading: true),
          data: (data) => _buildContent(
              data: data, user: currentUser, bp: bp, isLoading: false),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          switch (i) {
            case 1: context.goNamed(RouteNames.activities); break;
            case 2: context.goNamed(RouteNames.projects);   break;
            case 3: context.goNamed(RouteNames.profile);    break;
          }
        },
      ),
    );
  }
 
  Widget _buildContent({
    required HomeData? data,
    required AppUser? user,
    required BreakpointData bp,
    required bool isLoading,
  }) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.read(homeProvider.notifier).refresh(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
 
          SliverToBoxAdapter(
            child: user != null
                ? WelcomeBanner(
                    user:              user,
                    notificationCount: 0,
                    onProfileTap: ()   => context.goNamed(RouteNames.profile),
                    onNotificationTap: () {},
                  )
                : const SizedBox(height: 70),
          ),
 
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: NewsPinnedCarousel(
                news:       isLoading ? null : data!.pinnedNews,
                onNewsTap:  (_) {},
              ),
            ),
          ),
 
          // FIX : passe bp au lieu de calculer isTablet localement
          SliverToBoxAdapter(
            child: bp.isTablet
                ? _buildTabletLayout(data, isLoading)
                : _buildMobileLayout(data, isLoading),
          ),
 
          SliverToBoxAdapter(
            child: QuickActionsGrid(
              onActivitiesTap: () => context.goNamed(RouteNames.activities),
              onProjectsTap:   () => context.goNamed(RouteNames.projects),
              onGroupsTap:     () => context.goNamed(RouteNames.groups),
            ),
          ),
 
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
 
  Widget _buildMobileLayout(HomeData? data, bool isLoading) {
    return Column(children: [
      UpcomingActivitiesSection(
        title:            'Mes activités à venir',
        activities:       isLoading
            ? null
            : data!.nextThreeRegistrations.map((r) => r.activity).toList(),
        emptyTitle:       'Aucune activité à venir',
        emptySubtitle:    'Parcourez le catalogue et inscrivez-vous !',
        emptyActionLabel: 'Voir les activités',
        onEmptyAction:    () => context.goNamed(RouteNames.activities),
        onSeeAll:         () => context.goNamed(RouteNames.activities),
        onActivityTap:    _openActivityDetail,
      ),
      MyProjectsSection(
        projects:    isLoading ? null : data!.myProjects,
        onSeeAll:    () => context.goNamed(RouteNames.projects),
        onProjectTap: _openProjectDetail,
      ),
      UpcomingActivitiesSection(
        title:         'Activités proposées par l\'ASBL',
        activities:    isLoading ? null : data!.asblActivities,
        emptyTitle:    'Aucune activité planifiée',
        emptySubtitle: 'Revenez bientôt pour découvrir les prochains événements.',
        onSeeAll:      () => context.goNamed(RouteNames.activities),
        onActivityTap: _openActivityDetail,
      ),
    ]);
  }
 
  Widget _buildTabletLayout(HomeData? data, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(children: [
          UpcomingActivitiesSection(
            title:            'Mes activités à venir',
            activities:       isLoading
                ? null
                : data!.nextThreeRegistrations.map((r) => r.activity).toList(),
            emptyTitle:       'Aucune activité à venir',
            emptySubtitle:    'Parcourez le catalogue !',
            emptyActionLabel: 'Voir les activités',
            onEmptyAction:    () => context.goNamed(RouteNames.activities),
            onSeeAll:         () => context.goNamed(RouteNames.activities),
            onActivityTap:    _openActivityDetail,
          ),
          MyProjectsSection(
            projects:    isLoading ? null : data!.myProjects,
            onSeeAll:    () => context.goNamed(RouteNames.projects),
            onProjectTap: _openProjectDetail,
          ),
        ])),
        const SizedBox(width: 12),
        Expanded(child: UpcomingActivitiesSection(
          title:         'Activités de l\'ASBL',
          activities:    isLoading ? null : data!.asblActivities,
          emptyTitle:    'Aucune activité planifiée',
          emptySubtitle: 'Revenez bientôt.',
          onSeeAll:      () => context.goNamed(RouteNames.activities),
          onActivityTap: _openActivityDetail,
        )),
      ]),
    );
  }
 
  void _openActivityDetail(Activity a) => context.goNamed(
      RouteNames.activityDetail, pathParameters: {'id': a.id.toString()});
 
  void _openProjectDetail(Project p) => context.goNamed(
      RouteNames.projectDetail, pathParameters: {'id': p.id.toString()});
}
