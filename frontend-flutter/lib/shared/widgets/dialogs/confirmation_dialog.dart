import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Dialogue de confirmation générique.
/// Retourne true si confirmé, false si annulé.
///
/// Usage :
///   final confirmed = await showConfirmationDialog(
///     context: context,
///     title: 'Supprimer ?',
///     message: 'Cette action est irréversible.',
///     confirmLabel: 'Supprimer',
///     isDestructive: true,
///   );
Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmLabel  = 'Confirmer',
  String cancelLabel   = 'Annuler',
  bool   isDestructive = false,
  IconData? icon,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => ConfirmationDialog(
      title:        title,
      message:      message,
      confirmLabel: confirmLabel,
      cancelLabel:  cancelLabel,
      isDestructive: isDestructive,
      icon: icon,
    ),
  );
  return result ?? false;
}

class ConfirmationDialog extends StatelessWidget {
  final String    title;
  final String    message;
  final String    confirmLabel;
  final String    cancelLabel;
  final bool      isDestructive;
  final IconData? icon;

  const ConfirmationDialog({
    required this.title,
    required this.message,
    super.key,
    this.confirmLabel  = 'Confirmer',
    this.cancelLabel   = 'Annuler',
    this.isDestructive = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final actionColor = isDestructive ? AppColors.error : AppColors.primary;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.white,
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      title: Column(
        children: [
          if (icon != null) ...[
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: actionColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: actionColor, size: 28),
            ),
            const SizedBox(height: 16),
          ],
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
        ],
      ),
      content: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5)),
      actions: [
        Row(children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context, false),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(cancelLabel),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: actionColor,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(confirmLabel,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ],
    );
  }
}
