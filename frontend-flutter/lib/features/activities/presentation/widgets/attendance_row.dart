import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/registration.dart';

class AttendanceRow extends StatelessWidget {
  final Registration registration;
  final void Function(RegistrationStatus) onStatusChanged;

  const AttendanceRow(
      {required this.registration,
      required this.onStatusChanged,
      super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: AppColors.border, width: 0.5),),
      ),
      child: Row(children: [
        // ── Avatar initiales ─────────────────────────────
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.primary.withOpacity(0.12),
          child: Text(
            'U${registration.userId}',
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text('Utilisateur #${registration.userId}',
              style: const TextStyle(
                  fontSize: 14, color: AppColors.textPrimary,),),
        ),
        // ── Boutons présence ──────────────────────────────
        _StatusButton(
          icon: Icons.check_circle_outline,
          color: AppColors.enCours,
          selected: registration.status == RegistrationStatus.attended,
          onTap: () => onStatusChanged(RegistrationStatus.attended),
        ),
        const SizedBox(width: 8),
        _StatusButton(
          icon: Icons.cancel_outlined,
          color: AppColors.refuse,
          selected: registration.status == RegistrationStatus.noShow,
          onTap: () => onStatusChanged(RegistrationStatus.noShow),
        ),
      ],),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;
  const _StatusButton(
      {required this.icon,
      required this.color,
      required this.selected,
      required this.onTap,});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.15) : AppColors.inputBg,
            borderRadius: BorderRadius.circular(10),
            border: selected ? Border.all(color: color, width: 1.5) : null,
          ),
          child: Icon(icon,
              size: 20, color: selected ? color : AppColors.textSecondary,),
        ),
      );
}