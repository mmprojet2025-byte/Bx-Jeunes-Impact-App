// Configuration centralisée de l'application.
// Les valeurs sensibles à l'environnement sont injectées au BUILD
// via --dart-define.
//
// ── Utilisation ──────────────────────────────────────────────
//
//   local  →  ./run-local.sh   (défaut, aucun --dart-define requis)
//   dev    →  ./run-dev.sh     (backend Render)
//   prod   →  ./run-prod.sh    (à venir)
//
// ── Dans le code ─────────────────────────────────────────────
//
//   AppConfig.apiBaseUrl      // ex: "https://bxji-back-dev.onrender.com"
//   AppConfig.isProduction    // true uniquement en prod
//   AppConfig.isDev           // true en dev distant
//   AppConfig.isLocal         // true en local
//   AppConfig.showDevBadge    // true si ENV != 'prod'
 
abstract class AppConfig {
  // ── Environnement injecté par --dart-define ───────────────
  //
  // Valeurs possibles pour ENV : 'local' | 'dev' | 'prod'
  // Valeur par défaut : 'local' → pointe vers localhost
 
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'local',
  );
 
  // ── URL de base de l'API ──────────────────────────────────
  //
  // Le /api final est ajouté ici une seule fois pour que
  // tous les endpoints relatifs (/auth/login, /activities…)
  // fonctionnent directement avec Dio baseUrl.
 
  static const String _rawBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8081',
);
  static String get baseUrl => const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://api.example.com',
      );
 
  /// URL complète avec suffixe /api
  /// Exemple : "https://bxji-back-dev.onrender.com/api"
  static const String apiBaseUrl = '$_rawBaseUrl/api';
 
  // ── Helpers booléens ──────────────────────────────────────
 
  static bool get isLocal      => environment == 'local';
  static bool get isDev        => environment == 'dev';
  static bool get isProduction => environment == 'prod';
 
  /// Affiche le badge d'environnement quand on n'est PAS en production.
  static bool get showDevBadge => !isProduction;
 
  /// Label affiché dans le badge (ex: "LOCAL" ou "DEV")
  static String get envLabel => environment.toUpperCase();
 
  // ── Endpoints Auth ────────────────────────────────────────
 
  static const String loginEndpoint          = '/auth/login';
  static const String registerEndpoint       = '/auth/register';
  static const String refreshEndpoint        = '/auth/refresh';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String meEndpoint = '/auth/me';
 
  // ── Endpoints Features ────────────────────────────────────
 
  static const String activitiesEndpoint  = '/activities';
  static const String projectsEndpoint    = '/projects';
  static const String groupsEndpoint      = '/groups';
  static const String usersEndpoint       = '/users';
  static const String newsEndpoint        = '/news';
  static const String statsEndpoint       = '/stats';
  static const String partnersEndpoint    = '/partners';
 
  // ── Clés SecureStorage ────────────────────────────────────
 
  static const String accessTokenKey  = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey         = 'current_user';
 
  // ── Pagination ────────────────────────────────────────────
 
  static const int defaultPageSize = 20;
 
  // ── App info ──────────────────────────────────────────────
 
  static const String appName    = 'Bx-Jeunes Impact';
  static const String appVersion = '1.0.0';
}
 