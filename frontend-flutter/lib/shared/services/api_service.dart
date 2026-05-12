import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
 
import '../../core/constants/app_config.dart';
import '../../core/utils/logger.dart';
import '../models/api_error.dart';
import 'auth_interceptor.dart';
import 'refresh_interceptor.dart';
 
class ApiService {
  late final Dio _dio;
 
  /// [navigatorKey] est le GlobalKey partagé avec MaterialApp.
  /// Il est injecté par [apiServiceProvider] via Riverpod.
  ApiService({required GlobalKey<NavigatorState> navigatorKey}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        // Seuls les 2xx sont des succès.
        // Les 4xx/5xx passent dans onError des intercepteurs.
        validateStatus: (status) => status != null && status < 300,
      ),
    );
 
    // ── Ordre d'ajout des intercepteurs ───────────────────────
    //
    // onRequest (FIFO) : AuthInterceptor → RefreshInterceptor → Log
    // onError   (LIFO) : Log → RefreshInterceptor → AuthInterceptor
    //
    // RefreshInterceptor doit être APRÈS AuthInterceptor dans la liste
    // pour être appelé EN PREMIER sur onError (ordre LIFO).
    _dio.interceptors.addAll([
      AuthInterceptor(),
      RefreshInterceptor(dio: _dio, navigatorKey: navigatorKey),
      if (!const bool.fromEnvironment('dart.vm.product'))
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          logPrint: (o) => AppLogger.info(o.toString(), tag: 'HTTP'),
        ),
    ]);
  }
 
  // ── Méthodes HTTP typées ──────────────────────────────────
 
  /// GET — désérialise via [fromJson] si fourni, sinon cast brut.
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
    Options? options,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        path,
        queryParameters: queryParams,
        options: options,
      );
      return _decode(res.data, fromJson);
    } on DioException catch (e) {
      throw _toApiError(e);
    }
  }
 
  /// POST — corps [body] sérialisé en JSON.
  Future<T> post<T>(
    String path, {
    dynamic body,
    T Function(dynamic)? fromJson,
    Options? options,
  }) async {
    try {
      final res = await _dio.post<dynamic>(path, data: body, options: options);
      return _decode(res.data, fromJson);
    } on DioException catch (e) {
      throw _toApiError(e);
    }
  }
 
  /// PUT — remplacement complet de la ressource.
  Future<T> put<T>(
    String path, {
    dynamic body,
    T Function(dynamic)? fromJson,
    Options? options,
  }) async {
    try {
      final res = await _dio.put<dynamic>(path, data: body, options: options);
      return _decode(res.data, fromJson);
    } on DioException catch (e) {
      throw _toApiError(e);
    }
  }
 
  /// PATCH — mise à jour partielle.
  Future<T> patch<T>(
    String path, {
    dynamic body,
    T Function(dynamic)? fromJson,
    Options? options,
  }) async {
    try {
      final res = await _dio.patch<dynamic>(path, data: body, options: options);
      return _decode(res.data, fromJson);
    } on DioException catch (e) {
      throw _toApiError(e);
    }
  }
 
  /// DELETE — ne retourne rien (void).
  Future<void> delete(String path, {dynamic body, Options? options}) async {
    try {
      await _dio.delete<dynamic>(path, data: body, options: options);
    } on DioException catch (e) {
      throw _toApiError(e);
    }
  }
 
  /// Upload multipart (photo de profil, image projet…).
  Future<T> upload<T>(
    String path, {
    required FormData formData,
    T Function(dynamic)? fromJson,
    void Function(int sent, int total)? onProgress,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        path,
        data: formData,
        onSendProgress: onProgress,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      return _decode(res.data, fromJson);
    } on DioException catch (e) {
      throw _toApiError(e);
    }
  }
 
  // ── Helpers privés ────────────────────────────────────────
 
  T _decode<T>(dynamic data, T Function(dynamic)? fromJson) {
    if (fromJson != null) return fromJson(data);
    return data as T;
  }
 
  /// Transforme une DioException en ApiError lisible par les repositories.
  ApiError _toApiError(DioException e) {
    AppLogger.error(
      'HTTP ${e.response?.statusCode ?? "no-response"}: ${e.message}',
      error: e,
      tag: 'ApiService',
    );
 
    final response = e.response;
    if (response != null) {
      final code = response.statusCode ?? 500;
      final body = response.data;
 
      if (body is Map<String, dynamic>) {
        return ApiError.fromJson({
          'status': code,
          'message': body['message'] ?? body['error'] ?? _labelFromCode(code),
          'details': body,
        });
      }
      return ApiError(statusCode: code, message: _labelFromCode(code));
    }
 
    // Erreur réseau (pas de réponse serveur)
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const ApiError(
        statusCode: 0,
        message: 'La connexion a expiré. Vérifiez votre réseau.',
      );
    }
 
    return const ApiError(
      statusCode: 0,
      message: 'Serveur inaccessible. Vérifiez votre connexion.',
    );
  }
 
  String _labelFromCode(int code) => switch (code) {
    400 => 'Requête invalide.',
    401 => 'Session expirée. Veuillez vous reconnecter.',
    403 => 'Accès refusé.',
    404 => 'Ressource introuvable.',
    409 => 'Conflit — la ressource existe déjà.',
    422 => 'Données invalides.',
    500 => 'Erreur serveur. Réessayez plus tard.',
    _   => 'Erreur inattendue ($code).',
  };
}