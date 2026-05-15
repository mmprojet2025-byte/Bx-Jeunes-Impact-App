import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;
  final VoidCallback onConfirm;
 
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel  = 'Confirmer',
    this.cancelLabel   = 'Annuler',
    this.destructive   = false,
    required this.onConfirm,
  });
 
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirmer',
    bool destructive = false,
    required VoidCallback onConfirm,
  }) =>
      showDialog<bool>(
        context: context,
        builder: (_) => ConfirmationDialog(
          title: title, message: message,
          confirmLabel: confirmLabel, destructive: destructive,
          onConfirm: onConfirm,
        ),
      );
 
  @override
  Widget build(BuildContext context) {
    final confirmColor = destructive ? AppColors.refuse : AppColors.red;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      content: Text(message,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.4)),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelLabel,
                style: const TextStyle(color: AppColors.textSecondary))),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
