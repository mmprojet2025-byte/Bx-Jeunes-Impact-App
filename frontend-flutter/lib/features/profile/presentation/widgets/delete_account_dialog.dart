// todo
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) async {
  final result = await showDialog<bool>(context: context,
      builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('Supprimer mon compte'),
            content: const Text(
                'Cette action est irréversible. Toutes vos données seront supprimées définitivement.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.error, foregroundColor: AppColors.white),
                child: const Text('Supprimer définitivement'),
              ),
            ],
          ));
  return result ?? false;
}
