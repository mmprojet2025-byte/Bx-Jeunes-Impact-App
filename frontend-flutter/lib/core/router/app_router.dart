import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/activities/presentation/screens/activity_details_screen.dart';
import '../../features/activities/presentation/screens/activity_form_screen.dart';
import '../../features/activities/presentation/screens/activity_list_screen.dart';
import '../../features/activities/presentation/screens/attendance_screen.dart';
import '../../features/admin/presentation/screens/notifications_screen.dart';
import '../../features/admin/presentation/screens/partner_form_screen.dart';
// Admin
import '../../features/admin/presentation/screens/partner_list_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
// Auth
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
// Dashboard
import '../../features/dashboard/presentation/screens/home_screen.dart';
import '../../features/dashboard/presentation/screens/stats_screen.dart';
import '../../features/groups/presentation/screens/group_detail_screen.dart';
import '../../features/groups/presentation/screens/group_form_screen.dart';
// Groups
import '../../features/groups/presentation/screens/group_list_screen.dart';
import '../../features/groups/presentation/screens/group_members_screen.dart';
import '../../features/members/presentation/screens/member_detail_screen.dart';
// Members
import '../../features/members/presentation/screens/member_list_screen.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/privacy_policy_screen.dart';
// Profile
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/profile/presentation/screens/terms_of_services_screen.dart';
import '../../features/projects/presentation/screens/project_detail_screen.dart';
import '../../features/projects/presentation/screens/project_form_screen.dart';
// Projects
import '../../features/projects/presentation/screens/project_list_screen.dart';
import '../../features/projects/presentation/screens/project_members_screen.dart';
import '../../shared/models/role.dart';
import '../../shared/providers/auth_provider.dart';
import 'route_names.dart';
// Error screens
import 'screens/forbidden_screen.dart';
import 'screens/not_found_screen.dart';
 
abstract class AppRouter {
  static List<RouteBase> get routes => [
 
    // ── Root ──────────────────────────────────────────────
    GoRoute(
      path: RoutePaths.root,
      name: RouteNames.root,
      builder: (_, __) => const SizedBox.shrink(),
    ),
 
    // ── Auth — routes publiques ───────────────────────────
 
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      pageBuilder: (_, state) => _fadePage(
        state: state,
        child: const LoginScreen(),
      ),
    ),
 
    GoRoute(
      path: RoutePaths.register,
      name: RouteNames.register,
      pageBuilder: (_, state) => _slidePage(
        state: state, child: const RegisterScreen()),
    ),
 
    GoRoute(
      path: RoutePaths.forgotPassword,
      name: RouteNames.forgotPassword,
      pageBuilder: (_, state) => _slidePage(
        state: state, child: const ForgotPasswordScreen()),
    ),
 
    // ── Main — auth requises ──────────────────────────────
 
    GoRoute(
      path: RoutePaths.home,
      name: RouteNames.home,
      pageBuilder: (_, state) => _fadePage(
        state: state, child: const HomeScreen()),
    ),
 
    GoRoute(
      path: RoutePaths.stats,
      name: RouteNames.stats,
      pageBuilder: (_, state) => _slidePage(
        state: state, child: const StatsScreen()),
    ),
 
    // ── Activities ────────────────────────────────────────
 
    GoRoute(
      path: RoutePaths.activities,
      name: RouteNames.activities,
      pageBuilder: (_, state) => _slidePage(
        state: state, child: const ActivityListScreen()),
    ),
 
    // /activities/new AVANT /activities/:id pour éviter le conflit
    GoRoute(
      path: RoutePaths.activityNew,
      name: RouteNames.activityNew,
      pageBuilder: (_, state) => _slidePage(
        state: state,
        child: _RoleGuard(
          requiredRoles: const {Role.admin, Role.groupReferent},
          child: const ActivityFormScreen(),
        ),
      ),
    ),
 
    GoRoute(
      path: '/activities/:id',
      name: RouteNames.activityDetail,
      pageBuilder: (_, state) => _slidePage(
        state: state,
        // FIX: ActivityDetailScreen (from activity_details_screen.dart)
        child: ActivityDetailScreen(activityId: _parseId(state, 'id')),
      ),
      routes: [
        GoRoute(
          path: 'edit',
          name: RouteNames.activityEdit,
          pageBuilder: (_, state) => _slidePage(
            state: state,
            child: _RoleGuard(
              requiredRoles: const {Role.admin, Role.groupReferent},
              child: ActivityFormScreen(activityId: _parseId(state, 'id')),
            ),
          ),
        ),
        GoRoute(
          path: 'attendance',
          name: RouteNames.activityAttendance,
          pageBuilder: (_, state) => _slidePage(
            state: state,
            child: _RoleGuard(
              requiredRoles: const {Role.admin, Role.groupReferent},
              child: AttendanceScreen(activityId: _parseId(state, 'id')),
            ),
          ),
        ),
      ],
    ),
 
    // ── Projects ──────────────────────────────────────────
 
    GoRoute(
      path: RoutePaths.projects,
      name: RouteNames.projects,
      pageBuilder: (_, state) => _slidePage(
        state: state, child: const ProjectListScreen()),
    ),
 
    GoRoute(
      path: RoutePaths.projectNew,
      name: RouteNames.projectNew,
      pageBuilder: (_, state) => _slidePage(
        state: state,
        child: _RoleGuard(
          requiredRoles: const {Role.youth, Role.groupReferent, Role.projectManager},
          child: const ProjectFormScreen(),
        ),
      ),
    ),
 
    GoRoute(
      path: '/projects/:id',
      name: RouteNames.projectDetail,
      pageBuilder: (_, state) => _slidePage(
        state: state,
        child: ProjectDetailScreen(projectId: _parseId(state, 'id')),
      ),
      routes: [
        GoRoute(
          path: 'edit',
          name: RouteNames.projectEdit,
          pageBuilder: (_, state) => _slidePage(
            state: state,
            child: ProjectFormScreen(projectId: _parseId(state, 'id')),
          ),
        ),
        GoRoute(
          path: 'members',
          name: RouteNames.projectMembers,
          pageBuilder: (_, state) => _slidePage(
            state: state,
            child: ProjectMembersScreen(projectId: _parseId(state, 'id')),
          ),
        ),
      ],
    ),
 
    // ── Groups ────────────────────────────────────────────
 
    GoRoute(
      path: RoutePaths.groups,
      name: RouteNames.groups,
      pageBuilder: (_, state) => _slidePage(
        state: state, child: const GroupListScreen()),
    ),
 
    GoRoute(
      path: RoutePaths.groupNew,
      name: RouteNames.groupNew,
      pageBuilder: (_, state) => _slidePage(
        state: state,
        child: _RoleGuard(
          requiredRoles: const {Role.admin, Role.superAdmin},
          child: const GroupFormScreen(),
        ),
      ),
    ),
 
    GoRoute(
      path: '/groups/:id',
      name: RouteNames.groupDetail,
      pageBuilder: (_, state) => _slidePage(
        state: state,
        child: GroupDetailScreen(groupId: _parseId(state, 'id')),
      ),
      routes: [
        GoRoute(
          path: 'members',
          name: RouteNames.groupMembers,
          pageBuilder: (_, state) => _slidePage(
            state: state,
            child: GroupMembersScreen(groupId: _parseId(state, 'id')),
          ),
        ),
      ],
    ),
 
    // ── Members ───────────────────────────────────────────
 
    GoRoute(
      path: RoutePaths.memberList,
      name: RouteNames.memberList,
      pageBuilder: (_, state) => _slidePage(
        state: state, child: const MemberListScreen()),
    ),
 
    GoRoute(
      path: '/members/:id',
      name: RouteNames.memberDetail,
      pageBuilder: (_, state) => _slidePage(
        state: state,
        child: MemberDetailScreen(memberId: _parseId(state, 'id')),
      ),
    ),
 
    // ── Profile ───────────────────────────────────────────
 
    GoRoute(
      path: RoutePaths.profile,
      name: RouteNames.profile,
      pageBuilder: (_, state) => _slidePage(
        state: state, child: const ProfileScreen()),
      routes: [
        GoRoute(
          path: 'edit',
          name: RouteNames.editProfile,
          pageBuilder: (_, state) => _slidePage(
            state: state, child: const EditProfileScreen()),
        ),
        GoRoute(
          path: 'change-password',
          name: RouteNames.changePassword,
          pageBuilder: (_, state) => _slidePage(
            state: state, child: const ChangePasswordScreen()),
        ),
        GoRoute(
          path: 'privacy',
          name: RouteNames.privacyPolicy,
          pageBuilder: (_, state) => _slidePage(
            state: state, child: const PrivacyPolicyScreen()),
        ),
        GoRoute(
          path: 'terms',
          name: RouteNames.termsOfService,
          pageBuilder: (_, state) => _slidePage(
            state: state, child: const TermsOfServicesScreen()),
        ),
      ],
    ),
 
    GoRoute(
      path: RoutePaths.settings,
      name: RouteNames.settings,
      pageBuilder: (_, state) => _slidePage(
        state: state, child: const SettingsScreen()),
    ),
 
    // ── Admin ─────────────────────────────────────────────
 
    GoRoute(
      path: RoutePaths.partnerList,
      name: RouteNames.partnerList,
      pageBuilder: (_, state) => _slidePage(
        state: state,
        child: _RoleGuard(
          requiredRoles: const {Role.admin, Role.superAdmin},
          child: const PartnerListScreen(),
        ),
      ),
      routes: [
        GoRoute(
          path: 'new',
          name: RouteNames.partnerNew,
          pageBuilder: (_, state) => _slidePage(
            state: state,
            child: _RoleGuard(
              requiredRoles: const {Role.admin, Role.superAdmin},
              child: const PartnerFormScreen(),
            ),
          ),
        ),
        GoRoute(
          path: ':id/edit',
          name: RouteNames.partnerEdit,
          pageBuilder: (_, state) => _slidePage(
            state: state,
            child: _RoleGuard(
              requiredRoles: const {Role.admin, Role.superAdmin},
              child: PartnerFormScreen(partnerId: _parseId(state, 'id')),
            ),
          ),
        ),
      ],
    ),
 
    GoRoute(
      path: RoutePaths.notifications,
      name: RouteNames.notifications,
      pageBuilder: (_, state) => _slidePage(
        state: state,
        child: _RoleGuard(
          requiredRoles: const {Role.admin, Role.superAdmin},
          child: const NotificationsScreen(),
        ),
      ),
    ),
 
    // ── Erreurs ───────────────────────────────────────────
 
    GoRoute(
      path: RoutePaths.forbidden,
      name: RouteNames.forbidden,
      pageBuilder: (_, state) => _fadePage(
        state: state, child: const ForbiddenScreen()),
    ),
  ];
 
  // ── Transitions ───────────────────────────────────────────
 
  static CustomTransitionPage<void> _fadePage({
    required GoRouterState state, required Widget child}) =>
      CustomTransitionPage<void>(
        key: state.pageKey, child: child,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, anim, __, c) =>
            FadeTransition(opacity: anim, child: c));
 
  static CustomTransitionPage<void> _slidePage({
    required GoRouterState state, required Widget child}) =>
      CustomTransitionPage<void>(
        key: state.pageKey, child: child,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, anim, __, c) => SlideTransition(
          position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
              .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: c));
 
  // ── Parsing typé des paramètres de chemin ─────────────────
 
  static int _parseId(GoRouterState state, String param) {
    final raw = state.pathParameters[param];
    if (raw == null) throw FormatException('Missing path parameter: $param');
    return int.parse(raw);
  }
}


class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: const Center(child: Text('Stats content here')),
    );
  }
}
 
// ── Garde de rôle ─────────────────────────────────────────────
//
// Affiche ForbiddenScreen si l'utilisateur n'a pas le rôle requis.
// Approche widget (pas redirection silencieuse) pour UX explicite.
 
class _RoleGuard extends ConsumerWidget {
  final Set<Role> requiredRoles;
  final Widget child;
  const _RoleGuard({required this.requiredRoles, required this.child});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    if (user == null) return const SizedBox.shrink();
    if (!requiredRoles.any(user.roles.contains)) {
      return ForbiddenScreen(
        requiredRoles: requiredRoles,
        userRoles: user.roles,
      );
    }
    return child;
  }
}
