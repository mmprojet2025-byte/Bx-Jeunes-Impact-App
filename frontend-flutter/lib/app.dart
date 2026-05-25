import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/router_provider.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/auth_provider.dart';


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
      title:                    'Bx-Jeunes Impact',
      debugShowCheckedModeBanner: false,
      theme:                    AppTheme.light,
      routerConfig:             ref.watch(routerProvider),
      localizationsDelegates:   _localizationsDelegates,
      supportedLocales:         _supportedLocales,
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
