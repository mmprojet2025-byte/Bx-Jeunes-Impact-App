import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../admin/data/notification_models.dart';

class NotificationHistoryList extends StatelessWidget {
  final List<AppNotification> notifications;
  const NotificationHistoryList({required this.notifications, super.key});

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Center(
          child: Text('Aucune notification envoyée',
              style: TextStyle(color: AppColors.textSecondary),),);
    }
    return ListView.separated(
      itemCount: notifications.length,
      separatorBuilder: (_, __) =>
          const Divider(color: AppColors.border, height: 1),
      itemBuilder: (_, i) => _NotificationTile(n: notifications[i]),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification n;
  const _NotificationTile({required this.n});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: n.statusColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.notifications_outlined,
              color: n.statusColor, size: 20,),
        ),
        title: Text(n.title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,),),
        subtitle: Text('${n.targetLabel} • ${n.statusLabel}',
            style:
                const TextStyle(fontSize: 12, color: AppColors.textSecondary),),
        trailing: n.sentCount != null
            ? Text('${n.sentCount}',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary,),)
            : null,
      );
}