import 'dart:convert';
 
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../../core/constants/app_config.dart';
import '../../core/utils/logger.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/secure_storage_service.dart';
import 'api_service_provider.dart';
 
// ═══════════════════════════════════════════════════════════════
//  AuthStatus
// ═══════════════════════════════════════════════════════════════
 
enum AuthStatus { initial, loading, authenticated, unauthenticated }
 
// ═══════════════════════════════════════════════════════════════
//  AuthState
// ═══════════════════════════════════════════════════════════════
 
class AuthState {
  final AuthStatus status;
  final AppUser?   user;
  final String?    error;
 
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
  });
 
  // ── Computed shortcuts ────────────────────────────────────
 
  bool get isAuthenticated   => status == AuthStatus.authenticated;
  bool get isLoading         => status == AuthStatus.loading;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get isInitial         => status == AuthStatus.initial;
 
  // ── Factories sémantiques ─────────────────────────────────
 
  const AuthState.initial()
      : status = AuthStatus.initial,
        user   = null,
        error  = null;
 
  const AuthState.loading()
      : status = AuthStatus.loading,
        user   = null,
        error  = null;
 
  AuthState.authenticated(AppUser u)
      : status = AuthStatus.authenticated,
        user   = u,
        error  = null;
 
  AuthState.unauthenticated({String? error})
      : status = AuthStatus.unauthenticated,
        user   = null,
        error  = error;
 
  AuthState copyWith({
    AuthStatus? status, AppUser? user,
    String? error, bool clearError = false,
  }) => AuthState(
    status: status ?? this.status,
    user:   user   ?? this.user,
    error:  clearError ? null : error ?? this.error,
  );
 
  @override
  String toString() =>
      'AuthState(status: $status, user: ${user?.email}, error: $error)';
}
 
// ═══════════════════════════════════════════════════════════════
//  AuthNotifier
// ═══════════════════════════════════════════════════════════════
 
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _api;
 
  AuthNotifier(this._api) : super(const AuthState.initial()) {
    // Vérifie automatiquement le token au démarrage de l'app
    _autoInit();
  }
 
  // ── Démarrage : vérification du token stocké ──────────────
 
  Future<void> _autoInit() async {
    state = const AuthState.loading();
    AppLogger.info('autoInit: checking stored tokens…', tag: 'AuthProvider');
 
    try {
      final accessToken = await SecureStorageService.getAccessToken();
 
      if (accessToken == null || accessToken.isEmpty) {
        AppLogger.info('autoInit: no token found → unauthenticated', tag: 'AuthProvider');
        state = const AuthState.unauthenticated();
        return;
      }
 
      // ── Décoder le JWT localement (sans appel réseau) ─────
      final payload = _decodeJwtPayload(accessToken);
      final exp     = payload?['exp'] as int?;
      final now     = DateTime.now().millisecondsSinceEpoch ~/ 1000;
 
      // Marge de 30 secondes pour éviter les races conditions réseau
      final isExpired = exp != null && exp < now + 30;
 
      if (!isExpired) {
        // Token encore valide → récupérer le profil
        AppLogger.info('autoInit: token valid, fetching /me…', tag: 'AuthProvider');
        final user = await _fetchMe();
        if (user != null) {
          state = AuthState.authenticated(user);
          AppLogger.info('autoInit: authenticated as ${user.email}', tag: 'AuthProvider');
          return;
        }
        // /me a retourné une erreur → tenter refresh
      } else {
        AppLogger.info('autoInit: token expired → attempting refresh…', tag: 'AuthProvider');
      }
 
      // ── Tenter le refresh ─────────────────────────────────
      final refreshed = await _attemptRefresh();
      if (refreshed) {
        final user = await _fetchMe();
        if (user != null) {
          state = AuthState.authenticated(user);
          AppLogger.info('autoInit: refreshed & authenticated as ${user.email}', tag: 'AuthProvider');
          return;
        }
      }
 
      // Tout a échoué → déconnecter
      await SecureStorageService.clearAll();
      state = const AuthState.unauthenticated();
      AppLogger.info('autoInit: refresh failed → unauthenticated', tag: 'AuthProvider');
 
    } catch (e, st) {
      AppLogger.error('autoInit error', error: e, stackTrace: st, tag: 'AuthProvider');
      state = const AuthState.unauthenticated();
    }
  }
 
  // ── Login (appelé par LoginNotifier après succès API) ─────
 
  void setUser(AppUser user) {
    state = AuthState.authenticated(user);
    AppLogger.info('setUser: ${user.email}', tag: 'AuthProvider');
  }
 
  // ── Logout ────────────────────────────────────────────────
  //
  // 1. Appel backend best-effort (révoque le refresh token)
  // 2. Suppression locale des tokens
  // 3. State → unauthenticated
 
  Future<void> logout() async {
    AppLogger.info('logout initiated', tag: 'AuthProvider');
 
    // 1. Notifier le backend (best-effort — pas bloquant)
    try {
      final refreshToken = await SecureStorageService.getRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await _api.post<void>(
          '${AppConfig.loginEndpoint.replaceAll('/login', '/logout')}',
          body: {'refreshToken': refreshToken},
        );
        AppLogger.info('logout: backend notified', tag: 'AuthProvider');
      }
    } catch (e) {
      // Erreur réseau acceptable — on déconnecte quand même localement
      AppLogger.warning(
        'logout: backend call failed (offline?) — clearing locally anyway',
        tag: 'AuthProvider',
      );
    }
 
    // 2. Supprimer les tokens du storage
    await SecureStorageService.clearAll();
 
    // 3. Mettre à jour le state
    state = const AuthState.unauthenticated();
    AppLogger.info('logout: done', tag: 'AuthProvider');
  }
 
  // ── Refresh manuel (exposé pour usage externe si besoin) ──
 
  Future<bool> refreshToken() => _attemptRefresh();
 
  // ── Helpers privés ────────────────────────────────────────
 
  /// Récupère le profil utilisateur depuis GET /api/users/me.
  /// Retourne null en cas d'erreur (401, réseau, etc.)
  Future<AppUser?> _fetchMe() async {
    try {
      return await _api.get<AppUser>(
        '${AppConfig.usersEndpoint}/me',
        fromJson: (json) => AppUser.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      AppLogger.warning('_fetchMe failed: $e', tag: 'AuthProvider');
      return null;
    }
  }
 
  /// Tente de rafraîchir les tokens via POST /api/auth/refresh.
  /// Retourne true si succès, false sinon.
  Future<bool> _attemptRefresh() async {
    final refreshToken = await SecureStorageService.getRefreshToken();
 
    if (refreshToken == null || refreshToken.isEmpty) {
      AppLogger.warning('_attemptRefresh: no refresh token', tag: 'AuthProvider');
      return false;
    }
 
    try {
      // Appel direct sans passer par l'ApiService pour éviter
      // une boucle avec le RefreshInterceptor
      final response = await _api.post<Map<String, dynamic>>(
        AppConfig.refreshEndpoint,
        body: {'refreshToken': refreshToken},
        fromJson: (j) => j as Map<String, dynamic>,
      );
 
      final newAccess  = response['accessToken']  as String?;
      final newRefresh = response['refreshToken'] as String?;
 
      if (newAccess == null || newAccess.isEmpty) {
        AppLogger.error('_attemptRefresh: missing accessToken in response', tag: 'AuthProvider');
        return false;
      }
 
      await SecureStorageService.saveTokenPair(
        accessToken:  newAccess,
        refreshToken: newRefresh ?? refreshToken,
      );
 
      AppLogger.info('_attemptRefresh: tokens refreshed', tag: 'AuthProvider');
      return true;
 
    } catch (e) {
      AppLogger.error('_attemptRefresh failed: $e', tag: 'AuthProvider');
      await SecureStorageService.clearAll();
      return false;
    }
  }
 
  /// Décode la partie payload d'un JWT sans vérifier la signature.
  /// Utilisé UNIQUEMENT pour lire l'expiration localement.
  ///
  /// ⚠️  Ne jamais se fier à ces données pour des décisions de sécurité —
  ///     la vérification de signature se fait côté backend.
  Map<String, dynamic>? _decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
 
      // Le payload JWT est encodé en Base64URL (sans padding)
      final normalized = base64Url.normalize(parts[1]);
      final decoded    = utf8.decode(base64Url.decode(normalized));
      return json.decode(decoded) as Map<String, dynamic>;
    } catch (e) {
      AppLogger.warning('_decodeJwtPayload failed: $e', tag: 'AuthProvider');
      return null;
    }
  }
}
 
// ═══════════════════════════════════════════════════════════════
//  Providers
// ═══════════════════════════════════════════════════════════════
 
/// Provider principal — observable depuis tous les widgets.
///
/// Usage :
///   // Observer l'état auth
///   final authState = ref.watch(authProvider);
///   if (authState.isAuthenticated) { ... }
///
///   // Accéder à l'utilisateur connecté
///   final user = ref.watch(authProvider).user;
///
///   // Se déconnecter
///   await ref.read(authProvider.notifier).logout();
final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) =>
        AuthNotifier(ref.read(apiServiceProvider)));
 
/// Provider dérivé — utilisateur courant (null si non connecté).
/// Évite de rebuilder les widgets qui n'ont besoin que de l'user.
///
/// Usage : final user = ref.watch(currentUserProvider);
final currentUserProvider = Provider<AppUser?>((ref) =>
    ref.watch(authProvider).user);
 
/// Provider dérivé — true si connecté.
/// Usage : final isAuth = ref.watch(isAuthenticatedProvider);
final isAuthenticatedProvider = Provider<bool>((ref) =>
    ref.watch(authProvider).isAuthenticated);
    