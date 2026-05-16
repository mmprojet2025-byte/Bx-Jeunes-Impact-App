// Section 1 — Bandeau de bienvenue.
// Affiche la photo de profil (avatar initiales si pas de photo),
// le prénom de l'utilisateur et une icône de notification.
 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/user.dart';
 
class WelcomeBanner extends ConsumerWidget {
  final AppUser user;
  final int notificationCount;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
 
  const WelcomeBanner({
    required this.user, super.key,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.onProfileTap,
  });
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      color: AppColors.white,
      child: Row(
        children: [
          // ── Avatar ──────────────────────────────────────
          GestureDetector(
            onTap: onProfileTap,
            child: _Avatar(user: user),
          ),
          const SizedBox(width: 14),
 
          // ── Texte bienvenue ──────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Bonjour ',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text('👋', style: TextStyle(fontSize: 18)),
                  ],
                ),
                Text(
                  user.firstName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Découvre, participe et fais la différence !',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
 
          // ── Cloche notification ──────────────────────────
          _NotificationBell(
            count: notificationCount,
            onTap: onNotificationTap ?? () {},
          ),
        ],
      ),
    );
  }
}
 
// ── Avatar widget ─────────────────────────────────────────────
 
class _Avatar extends StatelessWidget {
  final AppUser user;
 
  const _Avatar({required this.user});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.red.withOpacity(0.12),
        border: Border.all(color: AppColors.red.withOpacity(0.3), width: 2),
      ),
      child: Center(
        child: Text(
          user.initials,
          style: const TextStyle(
            color: AppColors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
 
// ── Notification bell ─────────────────────────────────────────
 
class _NotificationBell extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
 
  const _NotificationBell({required this.count, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.inputBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
          if (count > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: AppColors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    count > 9 ? '9+' : count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}