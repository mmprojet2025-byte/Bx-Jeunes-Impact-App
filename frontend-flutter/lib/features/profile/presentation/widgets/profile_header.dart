import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/widgets/badges/role_badge.dart';

class ProfileHeader extends StatelessWidget {
  final AppUser user;
  final VoidCallback? onEditPhoto;
  const ProfileHeader({required this.user, super.key, this.onEditPhoto});

  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Stack(children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary.withOpacity(0.12),
              child: Text(user.initials,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ),
            if (onEditPhoto != null)
              Positioned(bottom: 0, right: 0,
                child: GestureDetector(onTap: onEditPhoto,
                  child: Container(
                    width: 28, height: 28,
                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt_outlined, size: 14, color: Colors.white),
                  )),
              ),
          ]),
          const SizedBox(height: 12),
          Text(user.fullName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(user.email, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          RoleBadge(role: user.primaryRole),
        ]),
      );
}
