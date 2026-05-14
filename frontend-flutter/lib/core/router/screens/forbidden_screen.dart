// Écran "Accès refusé" — affiché quand l'utilisateur n'a pas le rôle requis.
// N'est PAS une redirection silencieuse : l'utilisateur voit exactement
// pourquoi il n'a pas accès et ce qu'il doit avoir comme rôle.
 
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
 
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/role.dart';
import '../route_names.dart';
 
class ForbiddenScreen extends StatelessWidget {
  /// Rôles qui auraient permis l'accès (null si accès global refusé)
  final Set<Role>? requiredRoles;
 
  /// Rôles actuels de l'utilisateur (null si non connecté)
  final Set<Role>? userRoles;
 
  const ForbiddenScreen({
    super.key,
    this.requiredRoles,
    this.userRoles,
  });
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Icône ────────────────────────────────────
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.refuse.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_outline_rounded,
                  size: 40,
                  color: AppColors.refuse,
                ),
              ),
              const SizedBox(height: 24),
 
              // ── Titre ─────────────────────────────────────
              const Text(
                'Accès refusé',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
 
              // ── Message ───────────────────────────────────
              Text(
                'Vous n\'avez pas les permissions nécessaires pour accéder à cette page.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
 
              // ── Détail des rôles ──────────────────────────
              if (requiredRoles != null && requiredRoles!.isNotEmpty) ...[
                _RoleInfoCard(
                  label: 'Rôle(s) requis',
                  roles: requiredRoles!,
                  color: AppColors.enAttente,
                  icon: Icons.verified_user_outlined,
                ),
                const SizedBox(height: 12),
              ],
              if (userRoles != null && userRoles!.isNotEmpty) ...[
                _RoleInfoCard(
                  label: 'Votre rôle actuel',
                  roles: userRoles!,
                  color: AppColors.textSecondary,
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: 32),
              ],
 
              // ── Actions ───────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => context.goNamed(RouteNames.home),
                  icon: const Icon(Icons.home_outlined, size: 20),
                  label: const Text('Retour à l\'accueil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: const Text('Page précédente'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
class _RoleInfoCard extends StatelessWidget {
  final String label;
  final Set<Role> roles;
  final Color color;
  final IconData icon;
 
  const _RoleInfoCard({
    required this.label,
    required this.roles,
    required this.color,
    required this.icon,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                roles.map((r) => r.label).join(', '),
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

 