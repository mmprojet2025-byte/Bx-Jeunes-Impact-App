import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../models/role.dart';

/// Badge coloré affichant le rôle d'un utilisateur.
class RoleBadge extends StatelessWidget {
  final Role role;
  final bool compact;

  const RoleBadge({required this.role, super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final color = role.color;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: compact ? 7 : 10, vertical: compact ? 3 : 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        role.label,
        style: TextStyle(
          fontSize: compact ? 10 : 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

/// Ligne de plusieurs badges de rôle.
class RoleBadgeList extends StatelessWidget {
  final Set<Role> roles;
  const RoleBadgeList({required this.roles, super.key});

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 6,
    runSpacing: 4,
    children: roles.map((r) => RoleBadge(role: r, compact: true)).toList(),
  );
}
