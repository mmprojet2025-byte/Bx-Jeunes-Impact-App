import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
 
import '../../shared/models/role.dart';
import '../../shared/providers/auth_provider.dart';
import 'route_names.dart';
 
// ─────────────────────────────────────────────────────────────
//  1. AuthGuardWidget
// ─────────────────────────────────────────────────────────────
//
// Redirige vers /login si l'utilisateur n'est pas authentifié.
// À utiliser comme wrapper de sécurité supplémentaire.
//
// Note : GoRouter.redirect dans router_provider.dart devrait
// déjà gérer ce cas — ce widget est une sécurité en profondeur.
 
class AuthGuardWidget extends ConsumerWidget {
  final Widget child;
 
  /// Widget affiché pendant la vérification du token (isLoading)
  final Widget? loadingWidget;
 
  const AuthGuardWidget({
    super.key,
    required this.child,
    this.loadingWidget,
  });
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
 
    // Pendant le chargement initial du token
    if (authState.isLoading || authState.isInitial) {
      return loadingWidget ??
          const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
    }
 
    // Non authentifié → redirection GoRouter
    if (!authState.isAuthenticated) {
      // Utilise addPostFrameCallback pour éviter de naviguer
      // pendant un build (Flutter interdit les navigations synchrones)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.goNamed(RouteNames.login);
        }
      });
      return const SizedBox.shrink();
    }
 
    return child;
  }
}
 
// ─────────────────────────────────────────────────────────────
//  2. RoleGuardWidget
// ─────────────────────────────────────────────────────────────
//
// Affiche [child] si l'utilisateur a l'un des rôles requis.
// Affiche [fallback] sinon (SizedBox.shrink() par défaut).
//
// Différence avec _RoleGuard dans app_router.dart :
//   - _RoleGuard : utilisé au niveau des routes → affiche ForbiddenScreen
//   - RoleGuardWidget : utilisé dans les widgets → masque/affiche un élément
 
class RoleGuardWidget extends ConsumerWidget {
  final Set<Role> requiredRoles;
  final Widget    child;
 
  /// Widget affiché si le rôle est insuffisant. Par défaut : SizedBox.shrink()
  final Widget?   fallback;
 
  const RoleGuardWidget({
    super.key,
    required this.requiredRoles,
    required this.child,
    this.fallback,
  });
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
 
    if (user == null) return fallback ?? const SizedBox.shrink();
 
    final hasAccess = requiredRoles.any(user.roles.contains);
    return hasAccess ? child : (fallback ?? const SizedBox.shrink());
  }
}
 
// ─────────────────────────────────────────────────────────────
//  3. requireAuth()
// ─────────────────────────────────────────────────────────────
//
// Utilitaire pour les callbacks : vérifie l'auth avant d'exécuter
// une action. Si non authentifié, redirige vers /login.
//
// Usage :
//   ElevatedButton(
//     onPressed: () => requireAuth(context, ref, action: _submitForm),
//     child: const Text('Soumettre'),
//   )
 
void requireAuth(
  BuildContext context,
  WidgetRef ref, {
  required VoidCallback action,
}) {
  final isAuth = ref.read(isAuthenticatedProvider);
  if (isAuth) {
    action();
  } else {
    final location = GoRouterState.of(context).matchedLocation;
    context.go('${RoutePaths.login}?redirect=${Uri.encodeComponent(location)}');
  }
}
 
// ─────────────────────────────────────────────────────────────
//  4. canAccess()
// ─────────────────────────────────────────────────────────────
//
// Vérifie si l'utilisateur courant possède l'un des rôles requis.
// Retourne false si non authentifié.
//
// Usage :
//   if (canAccess(ref, roles: {Role.admin, Role.superAdmin})) {
//     showAdminMenu();
//   }
 
bool canAccess(WidgetRef ref, {required Set<Role> roles}) {
  final user = ref.read(currentUserProvider);
  if (user == null) return false;
  return roles.any(user.roles.contains);
}
