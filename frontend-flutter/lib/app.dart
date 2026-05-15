// Widget racine de l'application.
// Configure :
//   - La localisation FR / NL / EN avec flutter_localizations
//   - Le navigatorKey pour RefreshInterceptor
//   - Le router AppRouter avec onGenerateRoute

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/router/route_names.dart';
import 'core/theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';
import 'shared/providers/api_service_provider.dart';

// ── Provider de locale (permet de changer la langue depuis SettingsScreen) ──

/// Locale courante de l'application.
/// Valeur par défaut : français (langue officielle ASBL).
/// Peut être changée depuis SettingsScreen via ref.read(localeProvider.notifier).state = Locale('nl').
final localeProvider = StateProvider<Locale>((ref) => const Locale('fr'));

// ── Widget racine ─────────────────────────────────────────────

class BxJeunesApp extends ConsumerWidget {
  const BxJeunesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale     = ref.watch(localeProvider);
    final navKey     = ref.read(navigatorKeyProvider);

    return MaterialApp(
      title: 'Bx-Jeunes Impact',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,

      // ── NavigatorKey partagé avec RefreshInterceptor ──────
      navigatorKey: navKey,

      // ── Localisation ──────────────────────────────────────
      // Langue courante (changeable depuis les paramètres)
      locale: locale,

      // Langues supportées
      supportedLocales: AppLocalizations.supportedLocales,

      // Délégués de localisation :
      //   AppLocalizations.delegate  → traductions de l'app (app_*.arb)
      //   GlobalMaterialLocalizations → composants Material (DatePicker, etc.)
      //   GlobalCupertinoLocalizations → composants Cupertino (iOS)
      //   GlobalWidgetsLocalizations  → direction du texte (RTL/LTR)
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      // Résolution de la locale : préférence utilisateur > langue système > français
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (final supported in supportedLocales) {
          if (deviceLocale?.languageCode == supported.languageCode) {
            return supported;
          }
        }
        return const Locale('fr'); // fallback
      },

      // ── Routing ───────────────────────────────────────────
      initialRoute:    RouteNames.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
