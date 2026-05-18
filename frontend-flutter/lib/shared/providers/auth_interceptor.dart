import 'package:dio/dio.dart';
import '../services/secure_storage_service.dart';

/// Injecte automatiquement le Bearer token dans chaque requête.
class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) =>
      handler.next(response);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) =>
      handler.next(err);