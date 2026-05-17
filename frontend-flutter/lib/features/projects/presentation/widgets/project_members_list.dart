import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/widgets/badges/role_badge.dart';

class ProjectMembersList extends StatelessWidget {
  final List<AppUser> members;
  final bool canRemove;
  final void Function(AppUser)? onRemove;

  const ProjectMembersList({
    required this.members,
    super.key,
    this.canRemove = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Aucun membre pour l\'instant',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: members.length,
      separatorBuilder: (_, __) =>
          const Divider(color: AppColors.border, height: 1),
      itemBuilder: (_, i) => _MemberRow(
        user: members[i],
        canRemove: canRemove,
        onRemove: onRemove != null ? () => onRemove!(members[i]) : null,
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  final AppUser user;
  final bool canRemove;
  final VoidCallback? onRemove;

  const _MemberRow({
    required this.user,
    required this.canRemove,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primary.withOpacity(0.12),
          child: Text(
            user.initials,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              fontSize: 13,
            ),
          ),
        ),
        title: Text(
          user.fullName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: RoleBadge(role: user.primaryRole, compact: true),
        ),
        trailing: canRemove && onRemove != null
            ? IconButton(
                icon: const Icon(Icons.remove_circle_outline,
                    color: AppColors.refuse, size: 20),
                onPressed: onRemove,
              )
            : null,
      );
}