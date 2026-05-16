// Définition complète de toutes les routes GoRouter.
//
// Architecture :
//   - Routes publiques      → pas de garde
//   - Routes auth requises  → [_authGuard] vérifie isAuthenticated
//   - Routes avec rôle      → [_roleGuard] vérifie le rôle, affiche ForbiddenScreen sinon
//
// Navigation typée :
//   context.goNamed(RouteNames.activityDetail, pathParameters: {'id': '42'});
//   context.pushNamed(RouteNames.projectNew);
//
// Récupération des params dans un écran :
//   final id = int.parse(GoRouterState.of(context).pathParameters['id']!);
 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
 
import '../../shared/models/role.dart';
import '../../shared/providers/auth_provider.dart';
 
// ── Imports des screens ───────────────────────────────────────
// Auth
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
// Dashboard
import '../../features/dashboard/presentation/screens/home_screen.dart';
import '../../features/dashboard/presentation/screens/stats_screen.dart';
// Activities
import '../../features/activities/presentation/screens/activity_list_screen.dart';
import '../../features/activities/presentation/screens/activity_detail_screen.dart';
import '../../features/activities/presentation/screens/activity_form_screen.dart';
import '../../features/activities/presentation/screens/attendance_screen.dart';
// Projects
import '../../features/projects/presentation/screens/project_list_screen.dart';
import '../../features/projects/presentation/screens/project_detail_screen.dart';
import '../../features/projects/presentation/screens/project_form_screen.dart';
import '../../features/projects/presentation/screens/project_members_screen.dart';
// Groups
import '../../features/groups/presentation/screens/group_list_screen.dart';
import '../../features/groups/presentation/screens/group_detail_screen.dart';
import '../../features/groups/presentation/screens/group_form_screen.dart';
import '../../features/groups/presentation/screens/group_members_screen.dart';
// Members
import '../../features/members/presentation/screens/member_list_screen.dart';
import '../../features/members/presentation/screens/member_detail_screen.dart';
// Profile
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../../features/profile/presentation/screens/terms_of_services_screen.dart';
// Admin
import '../../features/admin/presentation/screens/partner_list_screen.dart';
import '../../features/admin/presentation/screens/partner_form_screen.dart';
import '../../features/admin/presentation/screens/notifications_screen.dart';
// Error screens
import 'screens/forbidden_screen.dart';
import 'screens/not_found_screen.dart';
 
import 'route_names.dart';
 
abstract class AppRouter {
  static List<RouteBase> get routes => [
 
    // ── Root ──────────────────────────────────────────────
    // La redirection réelle est gérée dans router_provider.dart
    GoRoute(
      path: RoutePaths.root,
      name: RouteNames.root,
      builder: (_, __) => const SizedBox.shrink(),
    ),
 
    // ═══════════════════════════════════════════════════════
    //  AUTH — routes publiques
    // ═══════════════════════════════════════════════════════
 
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      pageBuilder: (context, state) => _fadePage(
        state: state,
        child: LoginScreen(
          redirectTo: state.uri.queryParameters['redirect'],
        ),
      ),
    ),
 
    GoRoute(
      path: RoutePaths.register,
      name: RouteNames.register,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: const RegisterScreen(),
      ),
    ),
 
    GoRoute(
      path: RoutePaths.forgotPassword,
      name: RouteNames.forgotPassword,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: const ForgotPasswordScreen(),
      ),
    ),
 
    // ═══════════════════════════════════════════════════════
    //  MAIN — auth requises
    // ═══════════════════════════════════════════════════════
 
    GoRoute(
      path: RoutePaths.home,
      name: RouteNames.home,
      pageBuilder: (context, state) => _fadePage(
        state: state,
        child: const HomeScreen(),
      ),
    ),
 
    GoRoute(
      path: RoutePaths.stats,
      name: RouteNames.stats,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: const StatsScreen(),
      ),
    ),
 
    // ═══════════════════════════════════════════════════════
    //  ACTIVITIES
    // ═══════════════════════════════════════════════════════
 
    GoRoute(
      path: RoutePaths.activities,
      name: RouteNames.activities,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: const ActivityListScreen(),
      ),
    ),
 
    // /activities/new — AVANT /activities/:id pour éviter le conflit
    GoRoute(
      path: RoutePaths.activityNew,
      name: RouteNames.activityNew,
      pageBuilder: (context, state) => _slidePage(
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
      pageBuilder: (context, state) {
        final id = _parseId(state, 'id');
        return _slidePage(
          state: state,
          child: ActivityDetailScreen(activityId: id),
        );
      },
      routes: [
        GoRoute(
          path: 'edit',
          name: RouteNames.activityEdit,
          pageBuilder: (context, state) {
            final id = _parseId(state, 'id');
            return _slidePage(
              state: state,
              child: _RoleGuard(
                requiredRoles: const {Role.admin, Role.groupReferent},
                child: ActivityFormScreen(activityId: id),
              ),
            );
          },
        ),
        GoRoute(
          path: 'attendance',
          name: RouteNames.activityAttendance,
          pageBuilder: (context, state) {
            final id = _parseId(state, 'id');
            return _slidePage(
              state: state,
              child: _RoleGuard(
                requiredRoles: const {Role.admin, Role.groupReferent},
                child: AttendanceScreen(activityId: id),
              ),
            );
          },
        ),
      ],
    ),
 
    // ═══════════════════════════════════════════════════════
    //  PROJECTS
    // ═══════════════════════════════════════════════════════
 
    GoRoute(
      path: RoutePaths.projects,
      name: RouteNames.projects,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: const ProjectListScreen(),
      ),
    ),
 
    // /projects/new — AVANT /projects/:id
    GoRoute(
      path: RoutePaths.projectNew,
      name: RouteNames.projectNew,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: _RoleGuard(
          requiredRoles: const {Role.youth},
          child: const ProjectFormScreen(),
        ),
      ),
    ),
 
    GoRoute(
      path: '/projects/:id',
      name: RouteNames.projectDetail,
      pageBuilder: (context, state) {
        final id = _parseId(state, 'id');
        return _slidePage(
          state: state,
          child: ProjectDetailScreen(projectId: id),
        );
      },
      routes: [
        GoRoute(
          path: 'edit',
          name: RouteNames.projectEdit,
          pageBuilder: (context, state) {
            final id = _parseId(state, 'id');
            return _slidePage(
              state: state,
              child: ProjectFormScreen(projectId: id),
            );
          },
        ),
        GoRoute(
          path: 'members',
          name: RouteNames.projectMembers,
          pageBuilder: (context, state) {
            final id = _parseId(state, 'id');
            return _slidePage(
              state: state,
              child: ProjectMembersScreen(projectId: id),
            );
          },
        ),
      ],
    ),
 
    // ═══════════════════════════════════════════════════════
    //  GROUPS
    // ═══════════════════════════════════════════════════════
 
    GoRoute(
      path: RoutePaths.groups,
      name: RouteNames.groups,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: const GroupListScreen(),
      ),
    ),
 
    // /groups/new — AVANT /groups/:id
    GoRoute(
      path: RoutePaths.groupNew,
      name: RouteNames.groupNew,
      pageBuilder: (context, state) => _slidePage(
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
      pageBuilder: (context, state) {
        final id = _parseId(state, 'id');
        return _slidePage(
          state: state,
          child: GroupDetailScreen(groupId: id),
        );
      },
      routes: [
        GoRoute(
          path: 'members',
          name: RouteNames.groupMembers,
          pageBuilder: (context, state) {
            final id = _parseId(state, 'id');
            return _slidePage(
              state: state,
              child: GroupMembersScreen(groupId: id),
            );
          },
        ),
      ],
    ),
 
    // ═══════════════════════════════════════════════════════
    //  MEMBERS
    // ═══════════════════════════════════════════════════════
 
    GoRoute(
      path: RoutePaths.memberList,
      name: RouteNames.memberList,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: const MemberListScreen(),
      ),
    ),
 
    GoRoute(
      path: '/members/:id',
      name: RouteNames.memberDetail,
      pageBuilder: (context, state) {
        final id = _parseId(state, 'id');
        return _slidePage(
          state: state,
          child: MemberDetailScreen(memberId: id),
        );
      },
    ),
 
    // ═══════════════════════════════════════════════════════
    //  PROFILE
    // ═══════════════════════════════════════════════════════
 
    GoRoute(
      path: RoutePaths.profile,
      name: RouteNames.profile,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: const ProfileScreen(),
      ),
      routes: [
        GoRoute(
          path: 'edit',
          name: RouteNames.editProfile,
          pageBuilder: (context, state) => _slidePage(
            state: state,
            child: const EditProfileScreen(),
          ),
        ),
        GoRoute(
          path: 'change-password',
          name: RouteNames.changePassword,
          pageBuilder: (context, state) => _slidePage(
            state: state,
            child: const ChangePasswordScreen(),
          ),
        ),
        GoRoute(
          path: 'privacy',
          name: RouteNames.privacyPolicy,
          pageBuilder: (context, state) => _slidePage(
            state: state,
            child: const PrivacyPolicyScreen(),
          ),
        ),
        GoRoute(
          path: 'terms',
          name: RouteNames.termsOfService,
          pageBuilder: (context, state) => _slidePage(
            state: state,
            child: const TermsOfServicesScreen(),
          ),
        ),
      ],
    ),
 
    GoRoute(
      path: RoutePaths.settings,
      name: RouteNames.settings,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: const SettingsScreen(),
      ),
    ),
 
    // ═══════════════════════════════════════════════════════
    //  ADMIN
    // ═══════════════════════════════════════════════════════
 
    GoRoute(
      path: RoutePaths.partnerList,
      name: RouteNames.partnerList,
      pageBuilder: (context, state) => _slidePage(
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
          pageBuilder: (context, state) => _slidePage(
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
          pageBuilder: (context, state) {
            final id = _parseId(state, 'id');
            return _slidePage(
              state: state,
              child: _RoleGuard(
                requiredRoles: const {Role.admin, Role.superAdmin},
                child: PartnerFormScreen(partnerId: id),
              ),
            );
          },
        ),
      ],
    ),
 
    GoRoute(
      path: RoutePaths.notifications,
      name: RouteNames.notifications,
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: _RoleGuard(
          requiredRoles: const {Role.admin, Role.superAdmin},
          child: const NotificationsScreen(),
        ),
      ),
    ),
 
    // ═══════════════════════════════════════════════════════
    //  ERREURS
    // ═══════════════════════════════════════════════════════
 
    GoRoute(
      path: RoutePaths.forbidden,
      name: RouteNames.forbidden,
      pageBuilder: (context, state) => _fadePage(
        state: state,
        child: const ForbiddenScreen(),
      ),
    ),
  ];
 
  // ── Transitions de page ───────────────────────────────────
 
  static CustomTransitionPage<void> _fadePage({
    required GoRouterState state,
    required Widget child,
  }) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      );
 
  static CustomTransitionPage<void> _slidePage({
    required GoRouterState state,
    required Widget child,
  }) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      );
 
  // ── Parsing typé des paramètres ───────────────────────────
 
  /// Extrait et parse un paramètre de chemin en int.
  /// Lance une [FormatException] si absent ou non parsable.
  static int _parseId(GoRouterState state, String param) {
    final raw = state.pathParameters[param];
    if (raw == null) {
      throw FormatException('Missing path parameter: $param');
    }
    return int.parse(raw);
  }
}
 
// ── Garde de rôle (widget) ────────────────────────────────────
//
// Affiche [ForbiddenScreen] si l'utilisateur courant n'a pas
// l'un des rôles requis. La vérification se fait côté widget
// (après auth) pour afficher un message explicite — pas une
// redirection silencieuse.
 
class _RoleGuard extends ConsumerWidget {
  final Set<Role> requiredRoles;
  final Widget child;
 
  const _RoleGuard({
    required this.requiredRoles,
    required this.child,
  });
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
 
    if (user == null) return const SizedBox.shrink(); // géré par la garde auth
 
    final hasAccess = requiredRoles.any(user.roles.contains);
    if (!hasAccess) {
      return ForbiddenScreen(
        requiredRoles: requiredRoles,
        userRoles: user.roles,
      );
    }
 
    return child;
  }
}
