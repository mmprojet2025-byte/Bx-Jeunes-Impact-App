abstract class RouteNames {
  static const root = 'root';

  static const login          = 'login';
  static const register       = 'register';
  static const forgotPassword = 'forgot-password';

  static const home           = 'home';
  static const stats          = 'stats';
  static const adminDashboard = 'admin-dashboard';
  static const newsList       = 'news-list';
  static const newsDetail     = 'news-detail';

  static const activities         = 'activities';
  static const activityDetail     = 'activity-detail';
  static const activityNew        = 'activity-new';
  static const activityEdit       = 'activity-edit';
  static const activityAttendance = 'activity-attendance';

  static const projects       = 'projects';
  static const projectDetail  = 'project-detail';
  static const projectNew     = 'project-new';
  static const projectEdit    = 'project-edit';
  static const projectMembers = 'project-members';

  static const groups       = 'groups';
  static const groupDetail  = 'group-detail';
  static const groupNew     = 'group-new';
  static const groupEdit    = 'group-edit';
  static const groupMembers = 'group-members';

  static const memberList   = 'members';
  static const memberDetail = 'member-detail';

  static const profile        = 'profile';
  static const editProfile    = 'edit-profile';
  static const settings       = 'settings';
  static const changePassword = 'change-password';
  static const privacyPolicy  = 'privacy-policy';
  static const termsOfService = 'terms-of-service';

  static const partnerList   = 'partner-list';
  static const partnerNew    = 'partner-new';
  static const partnerEdit   = 'partner-edit';
  static const notifications = 'notifications';

  static const forbidden = 'forbidden';
  static const notFound  = 'not-found';
}

abstract class RoutePaths {
  static const root           = '/';
  static const login          = '/login';
  static const register       = '/register';
  static const forgotPassword = '/forgot-password';
  static const home           = '/home';
  static const stats          = '/stats';
  static const adminDashboard = '/admin/dashboard';
  static const newsList       = '/news';

  static const activities  = '/activities';
  static const activityNew = '/activities/new';
  static String activityDetail(String id)     => '/activities/$id';
  static String activityEdit(String id)       => '/activities/$id/edit';
  static String activityAttendance(String id) => '/activities/$id/attendance';

  static const projects   = '/projects';
  static const projectNew = '/projects/new';
  static String projectDetail(String id)  => '/projects/$id';
  static String projectEdit(String id)    => '/projects/$id/edit';
  static String projectMembers(String id) => '/projects/$id/members';

  static const groups   = '/groups';
  static const groupNew = '/groups/new';
  static String groupDetail(String id)  => '/groups/$id';
  static String groupEdit(String id)    => '/groups/$id/edit';
  static String groupMembers(String id) => '/groups/$id/members';

  static const memberList = '/members';
  static String memberDetail(String id) => '/members/$id';

  static const profile        = '/profile';
  static const editProfile    = '/profile/edit';
  static const settings       = '/settings';
  static const partnerList    = '/admin/partners';
  static const partnerNew     = '/admin/partners/new';
  static const notifications  = '/admin/notifications';
  static const forbidden      = '/forbidden';
}
