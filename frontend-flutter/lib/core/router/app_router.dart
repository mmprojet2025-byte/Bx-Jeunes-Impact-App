import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/activities/presentation/screens/activity_details_screen.dart';
import '../../features/activities/presentation/screens/activity_form_screen.dart';
import '../../features/activities/presentation/screens/activity_list_screen.dart';
import '../../features/activities/presentation/screens/attendance_screen.dart';
import '../../features/admin/presentation/screens/notifications_screen.dart';
import '../../features/admin/presentation/screens/partner_form_screen.dart';
import '../../features/admin/presentation/screens/partner_list_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/dashboard/presentation/screens/admin_dashboard_screen.dart';
import '../../features/dashboard/presentation/screens/home_screen.dart';
import '../../features/dashboard/presentation/screens/news_details_screen.dart';
import '../../features/dashboard/presentation/screens/news_list_screen.dart';
import '../../features/dashboard/presentation/screens/stats_screen.dart';
import '../../features/groups/presentation/screens/group_detail_screen.dart';
import '../../features/groups/presentation/screens/group_form_screen.dart';
import '../../features/groups/presentation/screens/group_list_screen.dart';
import '../../features/groups/presentation/screens/group_members_screen.dart';
import '../../features/members/presentation/screens/member_detail_screen.dart';
import '../../features/members/presentation/screens/member_list_screen.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/profile/presentation/screens/terms_of_services_screen.dart';
import '../../features/projects/presentation/screens/project_detail_screen.dart';
import '../../features/projects/presentation/screens/project_form_screen.dart';
import '../../features/projects/presentation/screens/project_list_screen.dart';
import '../../features/projects/presentation/screens/project_members_screen.dart';
import '../../shared/models/role.dart';
import '../../shared/providers/auth_provider.dart';
import 'route_names.dart';
import 'screens/forbidden_screen.dart';
import 'screens/not_found_screen.dart';

abstract class AppRouter {
  static List<RouteBase> get routes => [

    GoRoute(path: RoutePaths.root, name: RouteNames.root, builder: (_, __) => const SizedBox.shrink()),

    // ── Auth ──────────────────────────────────────────────
    GoRoute(path: RoutePaths.login, name: RouteNames.login,
        pageBuilder: (_, s) => _fadePage(state: s, child: const LoginScreen()),),
    GoRoute(path: RoutePaths.register, name: RouteNames.register,
        pageBuilder: (_, s) => _slidePage(state: s, child: const RegisterScreen()),),
    GoRoute(path: RoutePaths.forgotPassword, name: RouteNames.forgotPassword,
        pageBuilder: (_, s) => _slidePage(state: s, child: const ForgotPasswordScreen()),),

    // ── Main ──────────────────────────────────────────────
    GoRoute(path: RoutePaths.home, name: RouteNames.home,
        pageBuilder: (_, s) => _fadePage(state: s, child: const HomeScreen()),),
    GoRoute(path: RoutePaths.stats, name: RouteNames.stats,
        pageBuilder: (_, s) => _slidePage(state: s, child: const StatsScreen()),),
    GoRoute(
      path: RoutePaths.adminDashboard, name: RouteNames.adminDashboard,
      pageBuilder: (_, s) => _slidePage(state: s, child: const _RoleGuard(
        requiredRoles: {Role.admin, Role.superAdmin}, child: AdminDashboardScreen(),),),
    ),

    // ── News ──────────────────────────────────────────────
    GoRoute(
      path: RoutePaths.newsList, name: RouteNames.newsList,
      pageBuilder: (_, s) => _slidePage(state: s, child: const NewsListScreen()),
      routes: [
        GoRoute(path: ':id', name: RouteNames.newsDetail,
            pageBuilder: (_, s) => _slidePage(state: s,
                child: NewsDetailsScreen(newsId: _parseId(s, 'id')),),),
      ],
    ),

    // ── Activities ────────────────────────────────────────
    GoRoute(path: RoutePaths.activities, name: RouteNames.activities,
        pageBuilder: (_, s) => _slidePage(state: s, child: const ActivityListScreen()),),
    GoRoute(path: RoutePaths.activityNew, name: RouteNames.activityNew,
        pageBuilder: (_, s) => _slidePage(state: s, child: const _RoleGuard(
            requiredRoles: {Role.admin, Role.groupReferent}, child: ActivityFormScreen(),),),),
    GoRoute(
      path: '/activities/:id', name: RouteNames.activityDetail,
      pageBuilder: (_, s) => _slidePage(state: s,
          child: ActivityDetailScreen(activityId: _parseId(s, 'id')),),
      routes: [
        GoRoute(path: 'edit', name: RouteNames.activityEdit,
            pageBuilder: (_, s) => _slidePage(state: s, child: _RoleGuard(
                requiredRoles: const {Role.admin, Role.groupReferent},
                child: ActivityFormScreen(activityId: _parseId(s, 'id')),),),),
        GoRoute(path: 'attendance', name: RouteNames.activityAttendance,
            pageBuilder: (_, s) => _slidePage(state: s, child: _RoleGuard(
                requiredRoles: const {Role.admin, Role.groupReferent},
                child: AttendanceScreen(activityId: _parseId(s, 'id')),),),),
      ],
    ),

    // ── Projects ──────────────────────────────────────────
    GoRoute(path: RoutePaths.projects, name: RouteNames.projects,
        pageBuilder: (_, s) => _slidePage(state: s, child: const ProjectListScreen()),),
    GoRoute(path: RoutePaths.projectNew, name: RouteNames.projectNew,
        pageBuilder: (_, s) => _slidePage(state: s, child: const _RoleGuard(
            requiredRoles: {Role.youth, Role.groupReferent, Role.projectManager},
            child: ProjectFormScreen(),),),),
    GoRoute(
      path: '/projects/:id', name: RouteNames.projectDetail,
      pageBuilder: (_, s) => _slidePage(state: s,
          child: ProjectDetailScreen(projectId: _parseId(s, 'id')),),
      routes: [
        GoRoute(path: 'edit', name: RouteNames.projectEdit,
            pageBuilder: (_, s) => _slidePage(state: s,
                child: ProjectFormScreen(projectId: _parseId(s, 'id')),),),
        GoRoute(path: 'members', name: RouteNames.projectMembers,
            pageBuilder: (_, s) => _slidePage(state: s,
                child: ProjectMembersScreen(projectId: _parseId(s, 'id')),),),
      ],
    ),

    // ── Groups ────────────────────────────────────────────
    GoRoute(path: RoutePaths.groups, name: RouteNames.groups,
        pageBuilder: (_, s) => _slidePage(state: s, child: const GroupListScreen()),),
    GoRoute(path: RoutePaths.groupNew, name: RouteNames.groupNew,
        pageBuilder: (_, s) => _slidePage(state: s, child: const _RoleGuard(
            requiredRoles: {Role.admin, Role.superAdmin}, child: GroupFormScreen(),),),),
    GoRoute(
      path: '/groups/:id', name: RouteNames.groupDetail,
      pageBuilder: (_, s) => _slidePage(state: s,
          child: GroupDetailScreen(groupId: _parseId(s, 'id')),),
      routes: [
        GoRoute(path: 'edit', name: RouteNames.groupEdit,
            pageBuilder: (_, s) => _slidePage(state: s, child: _RoleGuard(
                requiredRoles: const {Role.admin, Role.superAdmin, Role.groupReferent},
                child: GroupFormScreen(groupId: _parseId(s, 'id')),),),),
        GoRoute(path: 'members', name: RouteNames.groupMembers,
            pageBuilder: (_, s) => _slidePage(state: s,
                child: GroupMembersScreen(groupId: _parseId(s, 'id')),),),
      ],
    ),

    // ── Members ───────────────────────────────────────────
    GoRoute(path: RoutePaths.memberList, name: RouteNames.memberList,
        pageBuilder: (_, s) => _slidePage(state: s, child: const MemberListScreen()),),
    GoRoute(path: '/members/:id', name: RouteNames.memberDetail,
        pageBuilder: (_, s) => _slidePage(state: s,
            child: MemberDetailScreen(memberId: _parseId(s, 'id')),),),

    // ── Profile ───────────────────────────────────────────
    GoRoute(
      path: RoutePaths.profile, name: RouteNames.profile,
      pageBuilder: (_, s) => _slidePage(state: s, child: const ProfileScreen()),
      routes: [
        GoRoute(path: 'edit', name: RouteNames.editProfile,
            pageBuilder: (_, s) => _slidePage(state: s, child: const EditProfileScreen()),),
        GoRoute(path: 'change-password', name: RouteNames.changePassword,
            pageBuilder: (_, s) => _slidePage(state: s, child: const ChangePasswordScreen()),),
        GoRoute(path: 'privacy', name: RouteNames.privacyPolicy,
            pageBuilder: (_, s) => _slidePage(state: s, child: const PrivacyPolicyScreen()),),
        GoRoute(path: 'terms', name: RouteNames.termsOfService,
            pageBuilder: (_, s) => _slidePage(state: s, child: const TermsOfServicesScreen()),),
      ],
    ),
    GoRoute(path: RoutePaths.settings, name: RouteNames.settings,
        pageBuilder: (_, s) => _slidePage(state: s, child: const SettingsScreen()),),

    // ── Admin ─────────────────────────────────────────────
    GoRoute(
      path: RoutePaths.partnerList, name: RouteNames.partnerList,
      pageBuilder: (_, s) => _slidePage(state: s, child: const _RoleGuard(
          requiredRoles: {Role.admin, Role.superAdmin}, child: PartnerListScreen(),),),
      routes: [
        GoRoute(path: 'new', name: RouteNames.partnerNew,
            pageBuilder: (_, s) => _slidePage(state: s, child: const _RoleGuard(
                requiredRoles: {Role.admin, Role.superAdmin}, child: PartnerFormScreen(),),),),
        GoRoute(path: ':id/edit', name: RouteNames.partnerEdit,
            pageBuilder: (_, s) => _slidePage(state: s, child: _RoleGuard(
                requiredRoles: const {Role.admin, Role.superAdmin},
                child: PartnerFormScreen(partnerId: _parseId(s, 'id')),),),),
      ],
    ),
    GoRoute(path: RoutePaths.notifications, name: RouteNames.notifications,
        pageBuilder: (_, s) => _slidePage(state: s, child: const _RoleGuard(
            requiredRoles: {Role.admin, Role.superAdmin}, child: NotificationsScreen(),),),),

    // ── Errors ────────────────────────────────────────────
    GoRoute(path: RoutePaths.forbidden, name: RouteNames.forbidden,
        pageBuilder: (_, s) => _fadePage(state: s, child: const ForbiddenScreen()),),
  ];

  static CustomTransitionPage<void> _fadePage({required GoRouterState state, required Widget child}) =>
      CustomTransitionPage<void>(
        key: state.pageKey, child: child,
        transitionsBuilder: (_, anim, __, c) => FadeTransition(opacity: anim, child: c),);

  static CustomTransitionPage<void> _slidePage({required GoRouterState state, required Widget child}) =>
      CustomTransitionPage<void>(
        key: state.pageKey, child: child,
        transitionsBuilder: (_, anim, __, c) => SlideTransition(
          position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
              .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: c,),);

  static int _parseId(GoRouterState state, String param) {
    final raw = state.pathParameters[param];
    if (raw == null) throw FormatException('Missing path parameter: $param');
    return int.parse(raw);
  }
}

class _RoleGuard extends ConsumerWidget {
  final Set<Role> requiredRoles;
  final Widget child;
  const _RoleGuard({required this.requiredRoles, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    if (user == null) return const SizedBox.shrink();
    if (!requiredRoles.any(user.roles.contains)) {
      return ForbiddenScreen(requiredRoles: requiredRoles, userRoles: user.roles);
    }
    return child;
  }
}
