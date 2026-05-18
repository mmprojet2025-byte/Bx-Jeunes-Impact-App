import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import 'core/router/router_provider.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/auth_provider.dart';
 
class BxJeunesApp extends ConsumerWidget {
  const BxJeunesApp({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
 
    // Show splash while authProvider checks stored token on startup
    if (authState.isInitial || authState.isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const _SplashScreen(),
      );
    }
 
    // GoRouter requires MaterialApp.router — never MaterialApp.
    // navigatorKey, initialRoute and onGenerateRoute are NOT compatible
    // with MaterialApp.router; GoRouter handles all of that internally.
    return MaterialApp.router(
      title:                    'Bx-Jeunes Impact',
      debugShowCheckedModeBanner: false,
      theme:                    AppTheme.light,
      routerConfig:             ref.watch(routerProvider),
    );
  }
}
 
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();
 
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 72, height: 72,
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.people_outline,
              color: Colors.white, size: 36),
        ),
        const SizedBox(height: 24),
        const SizedBox(
          width: 28, height: 28,
          child: CircularProgressIndicator(
              color: AppColors.red, strokeWidth: 2.5),
        ),
      ]),
    ),
  );
}
