import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/user_preferences.dart';

class NotificationSettingsSection extends StatelessWidget {
  final UserPreferences prefs;
  final void Function(UserPreferences) onChanged;
  const NotificationSettingsSection({required this.prefs, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        SwitchListTile(
          title: const Text('Notifications push', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
          value: prefs.notificationsEnabled,
          onChanged: (v) => onChanged(prefs.copyWith(notificationsEnabled: v)),
          activeColor: AppColors.primary,
        ),
        SwitchListTile(
          title: const Text('Notifications email', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
          value: prefs.emailNotifications,
          onChanged: (v) => onChanged(prefs.copyWith(emailNotifications: v)),
          activeColor: AppColors.primary,
        ),
      ]);
}
