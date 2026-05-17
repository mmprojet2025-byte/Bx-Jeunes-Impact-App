import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ParticipationRequestCard extends StatelessWidget {
  final int userId;
  final String? message;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  const ParticipationRequestCard({required this.userId, super.key,
      this.message, this.onAccept, this.onReject});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.enAttente.withOpacity(0.3)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(radius: 18, backgroundColor: AppColors.primary.withOpacity(0.12),
                child: Text('U$userId', style: const TextStyle(fontSize: 10, color: AppColors.primary))),
            const SizedBox(width: 10),
            Text('Utilisateur #$userId', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          ]),
          if (message != null && message!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(message!, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
          ],
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: OutlinedButton(
              onPressed: onReject,
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.refuse, side: const BorderSide(color: AppColors.refuse)),
              child: const Text('Refuser'),
            )),
            const SizedBox(width: 10),
            Expanded(child: ElevatedButton(
              onPressed: onAccept,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.enCours, foregroundColor: AppColors.white, elevation: 0),
              child: const Text('Accepter'),
            )),
          ]),
        ]),
      );
}
