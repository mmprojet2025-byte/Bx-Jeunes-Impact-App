import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/app_bar/custom_app_bar.dart';
import '../../../../shared/widgets/badges/role_badge.dart';
import '../../../../shared/widgets/error_states/error_widget.dart';
import '../../../../shared/widgets/loaders/skeleton_loader.dart';
import '../../../projects/data/project.dart';
import '../../application/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final currentUser  = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Mon profil',
        showBack: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined,
                color: AppColors.textPrimary),
            onPressed: () => context.goNamed(RouteNames.settings),
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => _ProfileSkeleton(),
        error: (err, _) => AppErrorWidget(
          message: err.toString(),
          onRetry: () => ref.refresh(profileProvider),
        ),
        data: (user) => _ProfileBody(user: user),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// BODY PRINCIPAL
// ═══════════════════════════════════════════════════════════════════════════
class _ProfileBody extends ConsumerWidget {
  final AppUser user;
  const _ProfileBody({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      color: AppColors.red,
      onRefresh: () => ref.read(profileProvider.notifier).refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // ── Header avatar + nom ───────────────────────────────
            _ProfileHeader(user: user),

            const SizedBox(height: 20),

            // ── Stats rapides ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _StatsRow(user: user),
            ),

            const SizedBox(height: 20),

            // ── Mes projets ───────────────────────────────────────
            _SectionHeader(
              title: 'Mes projets',
              onSeeAll: () => context.goNamed(RouteNames.projects),
            ),
            _MyProjectsList(userId: user.id),

            const SizedBox(height: 8),

            // ── Séparateur ────────────────────────────────────────
            const Divider(
                height: 32, indent: 16, endIndent: 16, color: AppColors.divider),

            // ── Menu actions ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _MenuTile(
                    icon: Icons.edit_outlined,
                    label: 'Modifier le profil',
                    onTap: () => context.goNamed(RouteNames.editProfile),
                  ),
                  _MenuTile(
                    icon: Icons.lock_outline,
                    label: 'Changer le mot de passe',
                    onTap: () => context.goNamed(RouteNames.changePassword),
                  ),
                  _MenuTile(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () => context.goNamed(RouteNames.settings),
                  ),
                  _MenuTile(
                    icon: Icons.shield_outlined,
                    label: 'Politique de confidentialité',
                    onTap: () => context.goNamed(RouteNames.privacyPolicy),
                  ),
                  _MenuTile(
                    icon: Icons.description_outlined,
                    label: 'Conditions d\'utilisation',
                    onTap: () => context.goNamed(RouteNames.termsOfService),
                  ),
                  const SizedBox(height: 8),
                  _MenuTile(
                    icon: Icons.logout_outlined,
                    label: 'Se déconnecter',
                    color: AppColors.error,
                    onTap: () => _showLogoutDialog(context, ref),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Déconnexion',
            style: TextStyle(
                fontFamily: 'Inter', fontWeight: FontWeight.bold)),
        content: const Text('Es-tu sûr de vouloir te déconnecter ?',
            style: TextStyle(fontFamily: 'Inter')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler',
                style: TextStyle(
                    color: AppColors.textSecondary, fontFamily: 'Inter')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Déconnecter',
                style: TextStyle(fontFamily: 'Inter')),
          ),
        ],
      ),
    );
  }
}

// ── Header profil ────────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  final AppUser user;
  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Avatar avec bouton caméra
          Stack(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: Colors.white.withOpacity(0.25),
                child: Text(
                  user.initials,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt_outlined,
                      color: AppColors.primary, size: 14),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Nom
          Text(
            user.fullName,
            style: AppTypography.onDark(AppTypography.h3),
          ),

          const SizedBox(height: 4),

          // Email
          Text(
            user.email,
            style: AppTypography.onDark(AppTypography.bodySmall),
          ),

          const SizedBox(height: 10),

          // Rôle badge + groupe
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoleBadge(role: user.primaryRole),
              if (user.groupName != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.group_outlined,
                          color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        user.groupName!,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ── Stats row ────────────────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final AppUser user;
  const _StatsRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
            icon: Icons.folder_outlined,
            label: 'Projets',
            value: '—',
            color: AppColors.primary),
        const SizedBox(width: 10),
        _StatCard(
            icon: Icons.event_available_outlined,
            label: 'Activités',
            value: '—',
            color: AppColors.orange),
        const SizedBox(width: 10),
        _StatCard(
            icon: Icons.group_outlined,
            label: 'Groupe',
            value: user.groupName ?? '—',
            color: AppColors.tertiary,
            small: true),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool small;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 6,
                offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: small ? 13 : 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(label,
                style: AppTypography.caption, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

// ── Mes projets ──────────────────────────────────────────────────────────────
class _MyProjectsList extends ConsumerWidget {
  final int userId;
  const _MyProjectsList({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // On utilise le provider projets global filtré côté UI par creatorId
    final state = ref.watch(projectListProvider);
    final myProjects =
        state.items.where((p) => p.creatorId == userId).take(3).toList();

    if (state.isLoading && state.items.isEmpty) {
      return _sectionSkeleton();
    }

    if (myProjects.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: _EmptyProjectsBanner(),
      );
    }

    return Column(
      children: myProjects
          .map((p) => _ProjectRow(project: p))
          .toList(),
    );
  }

  Widget _sectionSkeleton() {
    return Column(
      children: List.generate(
        2,
        (_) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: SkeletonLoader(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyProjectsBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline,
              color: AppColors.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tu n\'as pas encore de projets. Lance-toi !',
              style: AppTypography.colored(
                  AppTypography.bodySmall, AppColors.primary),
            ),
          ),
          GestureDetector(
            onTap: () => context.goNamed(RouteNames.projectNew),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Proposer',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  final Project project;
  const _ProjectRow({required this.project});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(
        RouteNames.projectDetail,
        pathParameters: {'id': project.id.toString()},
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 36,
              decoration: BoxDecoration(
                color: project.status.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.title,
                      style: AppTypography.h5,
                      overflow: TextOverflow.ellipsis),
                  Text(project.status.label,
                      style: AppTypography.colored(
                          AppTypography.caption, project.status.color)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

// ── Section header ────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  const _SectionHeader({required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.h4),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text('Voir tout', style: AppTypography.link),
            ),
        ],
      ),
    );
  }
}

// ── Menu tile ────────────────────────────────────────────────────────────────
class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textPrimary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: c, size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: AppTypography.body.copyWith(color: c)),
            ),
            Icon(Icons.chevron_right,
                color: color != null
                    ? color!.withOpacity(0.4)
                    : AppColors.textSecondary,
                size: 18),
          ],
        ),
      ),
    );
  }
}

// ── Skeleton ──────────────────────────────────────────────────────────────────
class _ProfileSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SkeletonLoader(
          child: Container(
            height: 220,
            color: AppColors.shimmerBase,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(
              3,
              (_) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SkeletonLoader(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.shimmerBase,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
