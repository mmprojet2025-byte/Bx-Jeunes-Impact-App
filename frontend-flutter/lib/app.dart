import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import 'core/router/app_router.dart';
import 'core/router/route_names.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/api_service_provider.dart';
import 'shared/providers/auth_provider.dart';
 
class BxJeunesApp extends ConsumerWidget {
  const BxJeunesApp({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
 
    return MaterialApp(
      title:                    'Bx-Jeunes Impact',
      debugShowCheckedModeBanner: false,
      theme:                    AppTheme.light,
 
      // Même clé que celle injectée dans RefreshInterceptor
      navigatorKey: ref.read(navigatorKeyProvider),
 
      // Route initiale selon l'état auth :
      //   initial / loading      → splash (écran blanc avec spinner)
      //   authenticated          → /home
      //   unauthenticated        → /login
      initialRoute: switch (authState.status) {
        AuthStatus.authenticated   => RouteNames.home,
        AuthStatus.unauthenticated => RouteNames.login,
        _                          => RouteNames.login, // splash géré ci-dessous
      },
 
      onGenerateRoute: AppRouter.generateRoute,
 
      // Builder global — affiche un splash overlay pendant le chargement initial
      builder: (context, child) {
        if (authState.isInitial || authState.isLoading) {
          return const _SplashScreen();
        }
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
 
// ── Splash screen ─────────────────────────────────────────────
//
// Affiché le temps que authProvider vérifie le token au démarrage.
// En V2 : remplacer par un écran avec le logo animé.
 
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo simplifié — remplacer par BxLogo avec animation en V2
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                color:  AppColors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.people_outline,
                  color: Colors.white, size: 36),
            ),
            const SizedBox(height: 24),
            const SizedBox(
              width:  28,
              height: 28,
              child:  CircularProgressIndicator(
                color:       AppColors.red,
                strokeWidth: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
