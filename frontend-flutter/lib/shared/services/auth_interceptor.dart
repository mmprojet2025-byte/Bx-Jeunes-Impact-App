// Intercepteur Dio n°1 — Injection automatique du JWT.
//
// Rôle :
//   Pour chaque requête SORTANTE, lit l'access token dans
//   flutter_secure_storage et ajoute le header :
//     Authorization: Bearer <token>
//
// Routes exclues (pas de token injecté) :
//   POST /api/auth/login
//   POST /api/auth/register
//   POST /api/auth/refresh
//   POST /api/auth/forgot-password
//
//   Ces routes sont publiques. Les inclure créerait une boucle
//   infinie avec RefreshInterceptor si elles retournaient un 401.
 
import 'package:dio/dio.dart';
 
import '../../core/constants/app_config.dart';
import '../../core/utils/logger.dart';
import 'secure_storage_service.dart';
 
class AuthInterceptor extends Interceptor {
  /// Paths publics qui ne reçoivent jamais le header Authorization.
  /// Utilise endsWith() pour être robuste aux URLs absolues ou relatives.
  static const _publicPaths = {
    AppConfig.loginEndpoint,           // /auth/login
    AppConfig.registerEndpoint,        // /auth/register
    AppConfig.refreshEndpoint,         // /auth/refresh
    AppConfig.forgotPasswordEndpoint,  // /auth/forgot-password
  };
 
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isPublic = _publicPaths.any((p) => options.path.endsWith(p));
 
    if (isPublic) {
      AppLogger.info(
        'Public route — no auth header: ${options.path}',
        tag: 'AuthInterceptor',
      );
      return handler.next(options);
    }
 
    final token = await SecureStorageService.getAccessToken();
 
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      AppLogger.info(
        'JWT injected → ${options.method} ${options.path}',
        tag: 'AuthInterceptor',
      );
    } else {
      // Aucun token disponible : la requête part quand même.
      // Si le serveur répond 401, RefreshInterceptor prend le relais.
      AppLogger.warning(
        'No access token — request sent unauthenticated: ${options.path}',
        tag: 'AuthInterceptor',
      );
    }
 
    handler.next(options);
  }
 
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) =>
      handler.next(response);
 
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) =>
      // Les 401 sont traités par RefreshInterceptor (intercepteur suivant).
      handler.next(err);
}
 