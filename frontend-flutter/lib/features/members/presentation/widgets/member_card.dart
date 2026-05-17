import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/role.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/widgets/badges/role_badge.dart';

class MemberCard extends StatelessWidget {
  final AppUser user;
  final VoidCallback? onTap;
  const MemberCard({required this.user, super.key, this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Row(children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withOpacity(0.12),
              child: Text(user.initials, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.fullName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              RoleBadge(role: user.primaryRole, compact: true),
            ])),
            const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
          ]),
        ),
      );
}