// AppBar partagée pour toutes les screens de l'app.
// Intègre automatiquement le badge d'environnement (EnvBadge)
// à droite du titre quand ENV != 'prod'.
 
import 'package:flutter/material.dart';
 
import '../../../core/theme/app_colors.dart';
import 'env_badge.dart';
import 'package:go_router/go_router.dart';
 
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;
 
  /// Si true, affiche le badge d'environnement [LOCAL] / [DEV]
  /// à côté du titre. Activé par défaut.
  final bool showEnvBadge;
 
  const CustomAppBar({
    required this.title, super.key,
    this.showBack = true,
    this.actions,
    this.showEnvBadge = true,
  });
 
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
 
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      leading: showBack
          ? GestureDetector(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed('home');
                }
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.textPrimary,
                  size: 16,
                ),
              ),
            )
          : null,
      // Titre avec badge d'environnement inline
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          if (showEnvBadge) const EnvBadge(),
        ],
      ),
      actions: actions,
    );
  }
}