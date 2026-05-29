import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/providers/current_user_provider.dart';
import '../../../../shared/widgets/app_bar/bottom_nav_bar.dart';
import '../../../../shared/widgets/error_states/error_widget.dart';
import '../../../activities/data/activity.dart';
import '../../../projects/data/project.dart';
import '../../application/home_provider.dart';
import '../widgets/my_projects_section.dart';
import '../widgets/news_pinned_carousel.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/upcoming_activities_section.dart';
import '../widgets/welcome_banner.dart';

const double _tabletBreakpoint = 768.0;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync   = ref.watch(homeProvider);
    final currentUser = ref.watch(currentUserProvider);
    final isTablet    = MediaQuery.of(context).size.width >= _tabletBreakpoint;

    // FIX: compute nav index from current route so the bar stays in sync
    final location = GoRouterState.of(context).matchedLocation;
    final navIndex = location.startsWith('/activities') ? 1
        : location.startsWith('/projects') ? 2
        : location.startsWith('/profile')  ? 3
        : 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: homeAsync.when(
          error: (err, _) => AppErrorWidget(
              message: err.toString(), onRetry: () => ref.refresh(homeProvider)),
          loading: () => _buildContent(
              data: null, user: currentUser, isTablet: isTablet, isLoading: true, ref: ref, context: context),
          data: (data) => _buildContent(
              data: data, user: currentUser, isTablet: isTablet, isLoading: false, ref: ref, context: context),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: navIndex,
        onTap: (i) {
          switch (i) {
            case 0: context.goNamed(RouteNames.home);
            case 1: context.goNamed(RouteNames.activities);
            case 2: context.goNamed(RouteNames.projects);
            case 3: context.goNamed(RouteNames.profile);
          }
        },
      ),
    );
  }

  Widget _buildContent({
    required HomeData? data,
    required AppUser? user,
    required bool isTablet,
    required bool isLoading,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return RefreshIndicator(
      color: AppColors.red,
      onRefresh: () => ref.read(homeProvider.notifier).refresh(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: user != null
                ? WelcomeBanner(
                    user: user,
                    onProfileTap: () => context.goNamed(RouteNames.profile),
                    onNotificationTap: () {},
                  )
                : const SizedBox(height: 70),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: NewsPinnedCarousel(
                news: isLoading ? null : data?.pinnedNews,
                // FIX: navigate to news detail instead of no-op
                onNewsTap: (news) => context.goNamed(
                  RouteNames.newsDetail,
                  pathParameters: {'id': news.id.toString()},
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: isTablet
                ? _buildTabletLayout(data, isLoading, context, ref)
                : _buildMobileLayout(data, isLoading, context, ref),
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

  Widget _buildMobileLayout(HomeData? data, bool isLoading, BuildContext context, WidgetRef ref) {
    // FIX: use ?. instead of ! to prevent null-check crash
    final regActivities = isLoading ? null
        : data?.nextThreeRegistrations.map((r) => r.activity).toList();

    return Column(children: [
      UpcomingActivitiesSection(
        title: 'Mes activités à venir',
        activities: regActivities,
        emptyTitle: 'Aucune activité à venir',
        emptySubtitle: 'Parcourez le catalogue et inscrivez-vous !',
        emptyActionLabel: 'Voir les activités',
        onEmptyAction: () => context.goNamed(RouteNames.activities),
        onSeeAll:      () => context.goNamed(RouteNames.activities),
        onActivityTap: (a) => _openActivity(context, a),
      ),
      MyProjectsSection(
        projects:    isLoading ? null : data?.myProjects,
        onSeeAll:    () => context.goNamed(RouteNames.projects),
        onProjectTap: (p) => _openProject(context, p),
      ),
      UpcomingActivitiesSection(
        title: 'Activités proposées par l\'ASBL',
        activities: isLoading ? null : data?.asblActivities,
        emptyTitle: 'Aucune activité planifiée',
        emptySubtitle: 'Revenez bientôt.',
        onSeeAll:      () => context.goNamed(RouteNames.activities),
        onActivityTap: (a) => _openActivity(context, a),
      ),
    ]);
  }

  Widget _buildTabletLayout(HomeData? data, bool isLoading, BuildContext context, WidgetRef ref) {
    final regActivities = isLoading ? null
        : data?.nextThreeRegistrations.map((r) => r.activity).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(children: [
          UpcomingActivitiesSection(
            title: 'Mes activités à venir', activities: regActivities,
            emptyTitle: 'Aucune activité à venir', emptySubtitle: 'Parcourez le catalogue !',
            emptyActionLabel: 'Voir les activités',
            onEmptyAction: () => context.goNamed(RouteNames.activities),
            onSeeAll:      () => context.goNamed(RouteNames.activities),
            onActivityTap: (a) => _openActivity(context, a),
          ),
          MyProjectsSection(
            projects: isLoading ? null : data?.myProjects,
            onSeeAll: () => context.goNamed(RouteNames.projects),
            onProjectTap: (p) => _openProject(context, p),
          ),
        ])),
        const SizedBox(width: 12),
        Expanded(child: UpcomingActivitiesSection(
          title: 'Activités de l\'ASBL',
          activities: isLoading ? null : data?.asblActivities,
          emptyTitle: 'Aucune activité planifiée', emptySubtitle: 'Revenez bientôt.',
          onSeeAll:      () => context.goNamed(RouteNames.activities),
          onActivityTap: (a) => _openActivity(context, a),
        )),
      ]),
    );
  }

  void _openActivity(BuildContext context, Activity a) =>
      context.goNamed(RouteNames.activityDetail, pathParameters: {'id': a.id.toString()});

  void _openProject(BuildContext context, Project p) =>
      context.goNamed(RouteNames.projectDetail, pathParameters: {'id': p.id.toString()});
}
