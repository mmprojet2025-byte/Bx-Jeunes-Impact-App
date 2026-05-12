// Widget racine de l'application.
// Câble le navigatorKey Riverpod dans MaterialApp pour que
// RefreshInterceptor puisse naviguer vers /login sans BuildContext.
 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import 'core/router/app_router.dart';
import 'core/router/route_names.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/api_service_provider.dart';
 
class BxJeunesApp extends ConsumerWidget {
  const BxJeunesApp({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Bx-Jeunes Impact',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // ↓ Même clé que celle injectée dans RefreshInterceptor
      navigatorKey: ref.read(navigatorKeyProvider),
      initialRoute: RouteNames.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
 