// Noms de routes GO_ROUTER — utilisés pour la navigation typée.
//
// Usage :
//   // Navigation simple
//   context.goNamed(RouteNames.home);
//
//   // Navigation avec paramètre
//   context.goNamed(RouteNames.activityDetail, pathParameters: {'id': '42'});
//
//   // Navigation avec query params
//   context.goNamed(RouteNames.activities, queryParameters: {'category': 'SPORT'});
 
abstract class RouteNames {
  // ── Root ─────────────────────────────────────────────────
  static const root = 'root';                        // /  → redirige selon auth
 
  // ── Auth (publiques) ──────────────────────────────────────
  static const login          = 'login';             // /login
  static const register       = 'register';          // /register
  static const forgotPassword = 'forgot-password';   // /forgot-password
 
  // ── Main (auth requis) ────────────────────────────────────
  static const home  = 'home';                       // /home
  static const stats = 'stats';                      // /stats
 
  // ── Activities ────────────────────────────────────────────
  static const activities         = 'activities';         // /activities
  static const activityDetail     = 'activity-detail';    // /activities/:id
  static const activityNew        = 'activity-new';       // /activities/new
  static const activityEdit       = 'activity-edit';      // /activities/:id/edit
  static const activityAttendance = 'activity-attendance';// /activities/:id/attendance
 
  // ── Projects ──────────────────────────────────────────────
  static const projects        = 'projects';         // /projects
  static const projectDetail   = 'project-detail';   // /projects/:id
  static const projectNew      = 'project-new';      // /projects/new
  static const projectEdit     = 'project-edit';     // /projects/:id/edit
  static const projectMembers  = 'project-members';  // /projects/:id/members
 
  // ── Groups ────────────────────────────────────────────────
  static const groups       = 'groups';              // /groups
  static const groupDetail  = 'group-detail';        // /groups/:id
  static const groupNew     = 'group-new';           // /groups/new
  static const groupMembers = 'group-members';       // /groups/:id/members
 
  // ── Members ───────────────────────────────────────────────
  static const memberList   = 'members';             // /members
  static const memberDetail = 'member-detail';       // /members/:id
 
  // ── Profile ───────────────────────────────────────────────
  static const profile        = 'profile';           // /profile
  static const editProfile    = 'edit-profile';      // /profile/edit
  static const settings       = 'settings';          // /settings
  static const changePassword = 'change-password';   // /profile/change-password
  static const privacyPolicy  = 'privacy-policy';    // /profile/privacy
  static const termsOfService = 'terms-of-service';  // /profile/terms
 
  // ── Admin ─────────────────────────────────────────────────
  static const partnerList     = 'partner-list';     // /admin/partners
  static const partnerNew      = 'partner-new';      // /admin/partners/new
  static const partnerEdit     = 'partner-edit';     // /admin/partners/:id/edit
  static const notifications   = 'notifications';    // /admin/notifications
 
  // ── Erreurs ───────────────────────────────────────────────
  static const forbidden   = 'forbidden';            // /forbidden   (403)
  static const notFound    = 'not-found';            // /not-found   (404)
}
 
// ── Chemins complets (pour les liens profonds / tests) ────────
abstract class RoutePaths {
  static const root              = '/';
  static const login             = '/login';
  static const register          = '/register';
  static const forgotPassword    = '/forgot-password';
  static const home              = '/home';
  static const stats             = '/stats';
  static const activities        = '/activities';
  static const activityNew       = '/activities/new';
  static String activityDetail(String id)      => '/activities/$id';
  static String activityEdit(String id)        => '/activities/$id/edit';
  static String activityAttendance(String id)  => '/activities/$id/attendance';
  static const projects          = '/projects';
  static const projectNew        = '/projects/new';
  static String projectDetail(String id)   => '/projects/$id';
  static String projectEdit(String id)     => '/projects/$id/edit';
  static String projectMembers(String id)  => '/projects/$id/members';
  static const groups            = '/groups';
  static const groupNew          = '/groups/new';
  static String groupDetail(String id)   => '/groups/$id';
  static String groupMembers(String id)  => '/groups/$id/members';
  static const memberList        = '/members';
  static String memberDetail(String id)  => '/members/$id';
  static const profile           = '/profile';
  static const editProfile       = '/profile/edit';
  static const settings          = '/settings';
  static const partnerList       = '/admin/partners';
  static const partnerNew        = '/admin/partners/new';
  static const notifications     = '/admin/notifications';
  static const forbidden         = '/forbidden';
}
