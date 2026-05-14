// Widget racine de l'application.
//
// Changement par rapport à la version précédente :
//   - Utilise MaterialApp.router + GoRouter (via routerProvider)
//   - Plus besoin de navigatorKey ici (go_router gère sa propre clé)
//   - navigatorKey reste exposé via navigatorKeyProvider pour RefreshInterceptor
 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import 'core/router/router_provider.dart';
import 'core/theme/app_theme.dart';
 
class BxJeunesApp extends ConsumerWidget {
  const BxJeunesApp({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
 
    return MaterialApp.router(
      title: 'Bx-Jeunes Impact',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
      // Localisation
      supportedLocales: const [
        Locale('fr'),
        Locale('nl'),
        Locale('en'),
      ],
    );
  }
} 
