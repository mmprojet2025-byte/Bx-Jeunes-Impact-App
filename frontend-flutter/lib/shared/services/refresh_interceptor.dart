import 'dart:async';
 
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
 
import '../../core/constants/app_config.dart';
import '../../core/router/route_names.dart';
import '../../core/utils/logger.dart';
import 'secure_storage_service.dart';
 
class RefreshInterceptor extends Interceptor {
  final Dio _dio;
  final GlobalKey<NavigatorState> navigatorKey;
 
  bool _isRefreshing = false;
  final List<_PendingRequest> _pendingQueue = [];
 
  RefreshInterceptor({
    required Dio dio,
    required this.navigatorKey,
  }) : _dio = dio;
 
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final options = err.requestOptions;
 
    if (statusCode != 401) return handler.next(err);
 
    if (options.extra['_isRetry'] == true) {
      AppLogger.error(
        'Retry returned 401 — forcing logout',
        tag: 'RefreshInterceptor',
      );
      await _forceLogout();
      return handler.next(err);
    }
 
    if (options.path.endsWith(AppConfig.refreshEndpoint)) {
      AppLogger.error(
        'Refresh endpoint returned 401 — token revoked, forcing logout',
        tag: 'RefreshInterceptor',
      );
      await _forceLogout();
      return handler.next(err);
    }
 
    AppLogger.warning(
      '401 on ${options.method} ${options.path}',
      tag: 'RefreshInterceptor',
    );
 
    if (_isRefreshing) {
      AppLogger.info('Refresh in progress, queuing: ${options.path}', tag: 'RefreshInterceptor');
      final completer = Completer<Response<dynamic>>();
      _pendingQueue.add(_PendingRequest(options: options, completer: completer));
      try {
        return handler.resolve(await completer.future);
      } catch (_) {
        return handler.next(err);
      }
    }
 
    _isRefreshing = true;
    try {
      final success = await _attemptRefresh();
      if (success) {
        final retried = await _retryRequest(options);
        _resolveQueue();
        return handler.resolve(retried);
      } else {
        _rejectQueue();
        await _forceLogout();
        return handler.next(err);
      }
    } catch (e, st) {
      AppLogger.error('Unexpected error during refresh', error: e, stackTrace: st, tag: 'RefreshInterceptor');
      _rejectQueue();
      await _forceLogout();
      return handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }
 
  Future<bool> _attemptRefresh() async {
    final refreshToken = await SecureStorageService.getRefreshToken();
 
    if (refreshToken == null || refreshToken.isEmpty) {
      AppLogger.warning('No refresh token in storage', tag: 'RefreshInterceptor');
      return false;
    }
 
    AppLogger.info('Calling POST /auth/refresh…', tag: 'RefreshInterceptor');
 
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '${AppConfig.apiBaseUrl}${AppConfig.refreshEndpoint}',
        data: {'refreshToken': refreshToken},
        options: Options(
          extra: {'_isRetry': true},
          headers: {'Content-Type': 'application/json'},
          validateStatus: (s) => s != null && s < 500,
        ),
      );
 
      if (res.statusCode != 200 || res.data == null) {
        AppLogger.error('Refresh failed — status ${res.statusCode}', tag: 'RefreshInterceptor');
        return false;
      }
 
      final data       = res.data!;
      final newAccess  = data['accessToken']  as String?;
      final newRefresh = data['refreshToken'] as String?;
 
      if (newAccess == null || newAccess.isEmpty) {
        AppLogger.error('Missing accessToken in refresh response', tag: 'RefreshInterceptor');
        return false;
      }
 
      await SecureStorageService.saveTokenPair(
        accessToken:  newAccess,
        refreshToken: newRefresh ?? refreshToken,
      );
 
      AppLogger.info('Tokens refreshed and saved', tag: 'RefreshInterceptor');
      return true;
    } on DioException catch (e) {
      AppLogger.error(
        'Refresh request DioException: ${e.response?.statusCode} ${e.message}',
        tag: 'RefreshInterceptor',
      );
      return false;
    }
  }
 
  Future<Response<dynamic>> _retryRequest(RequestOptions original) async {
    final newToken = await SecureStorageService.getAccessToken();
    final retryOptions = original.copyWith(
      headers: {...original.headers, 'Authorization': 'Bearer $newToken'},
      extra:   {...original.extra,   '_isRetry': true},
    );
    AppLogger.info('Retrying ${original.method} ${original.path}', tag: 'RefreshInterceptor');
    return _dio.fetch(retryOptions);
  }
 
  void _resolveQueue() {
    for (final req in _pendingQueue) {
      _retryRequest(req.options).then(
        req.completer.complete,
        onError: req.completer.completeError,
      );
    }
    _pendingQueue.clear();
  }
 
  void _rejectQueue() {
    for (final req in _pendingQueue) {
      req.completer.completeError(
        DioException(
          requestOptions: req.options,
          message: 'Token refresh failed',
        ),
      );
    }
    _pendingQueue.clear();
  }
 
  // FIX : utilise GoRouter.of(context).goNamed() via le navigatorKey
  // au lieu de pushNamedAndRemoveUntil qui utilise le vieux système de routes
  Future<void> _forceLogout() async {
    await SecureStorageService.clearAll();
    AppLogger.info('Forced logout — navigating to /login', tag: 'RefreshInterceptor');
 
    final context = navigatorKey.currentContext;
    if (context != null && context.mounted) {
      GoRouter.of(context).goNamed(RouteNames.login);
    }
  }
}
 
class _PendingRequest {
  final RequestOptions options;
  final Completer<Response<dynamic>> completer;
  const _PendingRequest({required this.options, required this.completer});
}
