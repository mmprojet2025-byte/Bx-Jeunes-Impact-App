import 'package:flutter/material.dart';
 
import '../../../core/constants/app_config.dart';
import '../../../core/theme/app_colors.dart';
 
class EnvBadge extends StatelessWidget {
  const EnvBadge({super.key});
 
  @override
  Widget build(BuildContext context) {
    if (!AppConfig.showDevBadge) return const SizedBox.shrink();
 
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: _badgeColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        AppConfig.envLabel,
        style: AppColors.envBadgeTextStyle.copyWith(
          color: AppColors.textOnPrimary,
        ),
      ),
    );
  }
 
  Color get _badgeColor {
    if (AppConfig.isLocal) return AppColors.envLocal;
    if (AppConfig.isDev)   return AppColors.envDev;
    return AppColors.envOther;
  }
}
