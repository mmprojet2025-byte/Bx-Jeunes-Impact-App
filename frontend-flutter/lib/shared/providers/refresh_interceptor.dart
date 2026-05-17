import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_config.dart';
import '../services/secure_storage_service.dart';

/// Intercepte les 401 et tente un refresh automatique du token.
/// Si le refresh échoue, redirige vers la page de login.
class RefreshInterceptor extends Interceptor {
  final Dio _dio;
  final GlobalKey<NavigatorState> navigatorKey;
  bool _isRefreshing = false;

  RefreshInterceptor({required Dio dio, required this.navigatorKey}) : _dio = dio;

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 || _isRefreshing) {
      return handler.next(err);
    }

    _isRefreshing = true;
    try {
      final refreshToken = await SecureStorageService.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        _logout();
        return handler.next(err);
      }

      final response = await _dio.post<Map<String, dynamic>>(
        AppConfig.refreshEndpoint,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Authorization': ''}),
      );

      final newAccess = response.data?['accessToken'] as String?;
      final newRefresh = response.data?['refreshToken'] as String?;

      if (newAccess == null) { _logout(); return handler.next(err); }

      await SecureStorageService.saveTokenPair(
        accessToken: newAccess,
        refreshToken: newRefresh ?? refreshToken,
      );

      // Rejoue la requête originale avec le nouveau token
      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $newAccess';
      final retried = await _dio.fetch(opts);
      return handler.resolve(retried);
    } catch (_) {
      _logout();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  void _logout() {
    SecureStorageService.clearAll();
    navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (_) => false);
  }
}
