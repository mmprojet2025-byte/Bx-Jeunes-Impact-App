abstract class AppConfig {
  // Base URL — change to your actual API host
  static const String baseUrl = 'http://localhost:8080/api';
 
  // Auth endpoints
  static const String loginEndpoint          = '/auth/login';
  static const String registerEndpoint       = '/auth/register';
  static const String refreshEndpoint        = '/auth/refresh';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
 
  // Feature endpoints
  static const String activitiesEndpoint  = '/activities';
  static const String projectsEndpoint    = '/projects';
  static const String groupsEndpoint      = '/groups';
  static const String usersEndpoint       = '/users';
  static const String newsEndpoint        = '/news';
  static const String statsEndpoint       = '/stats';
  static const String partnersEndpoint    = '/partners';
 
  // Storage keys
  static const String accessTokenKey  = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey         = 'current_user';
 
  // Pagination
  static const int defaultPageSize = 20;
 
  // App info
  static const String appName    = 'Bx-Jeunes Impact';
  static const String appVersion = '1.0.0';
}
