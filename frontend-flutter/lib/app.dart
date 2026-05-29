import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/router_provider.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/auth_provider.dart';
import 'shared/providers/connectivity_provider.dart';

const _localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

const _supportedLocales = [
  Locale('fr', 'FR'),
  Locale('en', 'US'),
  Locale('nl', 'NL'),
];

class BxJeunesApp extends ConsumerWidget {
  const BxJeunesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.isInitial || authState.isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: _localizationsDelegates,
        supportedLocales: _supportedLocales,
        home: _SplashScreen(),
      );
    }

    return MaterialApp.router(
      title: 'Bx-Jeunes Impact',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: ref.watch(routerProvider),
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: _supportedLocales,
      builder: (context, child) => _OfflineBanner(child: child ?? const SizedBox.shrink()),
    );
  }
}

class _OfflineBanner extends ConsumerWidget {
  final Widget child;
  const _OfflineBanner({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isOnline ? 0 : 36,
          color: AppColors.warning,
          child: isOnline
              ? null
              : const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off, color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Hors connexion — certaines fonctions sont indisponibles',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
        ),
        Expanded(child: child),
      ],
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
          decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.people_outline, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 24),
        const SizedBox(
          width: 28, height: 28,
          child: CircularProgressIndicator(color: AppColors.red, strokeWidth: 2.5),
        ),
      ]),
    ),
  );
}