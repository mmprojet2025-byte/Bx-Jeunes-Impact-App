// Expose le GoRouter configuré comme provider Riverpod.
// Le router écoute l'état d'authentification via [authProvider]
// et déclenche automatiquement les redirections.
//
// Pattern :
//   GoRouter.refreshListenable → ChangeNotifier wrappant authProvider
//   redirect                   → logique de garde centralisée
 
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
 
import '../../shared/providers/auth_provider.dart';
import '../../shared/models/role.dart';
import 'app_router.dart';
import 'route_names.dart';
 
// ── Provider principal ────────────────────────────────────────
 
final routerProvider = Provider<GoRouter>((ref) {
  // Notifier qui "wake up" GoRouter à chaque changement d'auth
  final authNotifier = _AuthChangeNotifier(ref);
 
  final router = GoRouter(
    initialLocation: RoutePaths.root,
    debugLogDiagnostics: !const bool.fromEnvironment('dart.vm.product'),
    refreshListenable: authNotifier,
    redirect: (context, state) => _redirect(ref, state),
    errorBuilder: (context, state) => NotFoundScreen(error: state.error),
    routes: AppRouter.routes,
  );
 
  // Libère le notifier quand le provider est disposé
  ref.onDispose(authNotifier.dispose);
 
  return router;
});
 
// ── Logique de redirection centralisée ────────────────────────
 
String? _redirect(Ref ref, GoRouterState state) {
  final authState  = ref.read(authProvider);
  final isAuth     = authState.isAuthenticated;
  final isLoading  = authState.isLoading;
  final location   = state.matchedLocation;
 
  // Pendant le chargement initial, ne pas rediriger
  if (isLoading) return null;
 
  final isAuthRoute = _authRoutes.contains(location) ||
      _authRoutes.any(location.startsWith);
 
  // ── Racine → redirection selon état ──────────────────────
  if (location == RoutePaths.root) {
    return isAuth ? RoutePaths.home : RoutePaths.login;
  }
 
  // ── Utilisateur non authentifié sur route protégée ────────
  if (!isAuth && !isAuthRoute) {
    // Sauvegarde la destination pour rediriger après login
    final redirect = Uri.encodeComponent(location);
    return '${RoutePaths.login}?redirect=$redirect';
  }
 
  // ── Utilisateur authentifié sur route auth ────────────────
  if (isAuth && isAuthRoute) {
    return RoutePaths.home;
  }
 
  // Pas de redirection
  return null;
}
 
/// Routes accessibles sans authentification
const _authRoutes = {
  RoutePaths.login,
  RoutePaths.register,
  RoutePaths.forgotPassword,
};
 
// ── ChangeNotifier wrappant AuthState ─────────────────────────
//
// GoRouter.refreshListenable attend un Listenable.
// On wrap le StateNotifier Riverpod dans un ChangeNotifier léger.
 
class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Ref ref) {
    _subscription = ref.listen<AuthState>(
      authProvider,
      (_, __) => notifyListeners(),
    );
  }
 
  late final ProviderSubscription<AuthState> _subscription;
 
  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
 