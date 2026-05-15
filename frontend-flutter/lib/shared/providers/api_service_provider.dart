import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../services/api_service.dart';
 
/// GlobalKey partagé entre MaterialApp et RefreshInterceptor.
/// keepAlive implicite via Provider (jamais disposé).
final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (_) => GlobalKey<NavigatorState>(),
);
 
/// Instance Dio configurée — singleton pour toute la session.
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(navigatorKey: ref.read(navigatorKeyProvider));
});
