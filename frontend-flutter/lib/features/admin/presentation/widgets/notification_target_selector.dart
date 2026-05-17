import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../data/notification_models.dart';

class NotificationTargetSelector extends StatelessWidget {
  final NotificationTarget selected;
  final void Function(NotificationTarget) onChanged;

  const NotificationTargetSelector(
      {required this.selected, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: NotificationTarget.values
          .map((t) => RadioListTile<NotificationTarget>(
                value: t,
                groupValue: selected,
                onChanged: (v) => v != null ? onChanged(v) : null,
                title: Text(_label(t),
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.textPrimary)),
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ))
          .toList(),
    );
  }

  String _label(NotificationTarget t) => switch (t) {
        NotificationTarget.all => 'Tous les utilisateurs',
        NotificationTarget.youth => 'Jeunes uniquement',
        NotificationTarget.referents => 'Référents uniquement',
        NotificationTarget.admins => 'Admins uniquement',
        NotificationTarget.group => 'Un groupe spécifique',
      };
}
