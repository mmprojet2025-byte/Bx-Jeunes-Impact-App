import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

Future<String?> showAddMemberDialog(BuildContext context) => showDialog<String>(
      context: context,
      builder: (_) => const _AddMemberDialog(),
    );

class _AddMemberDialog extends StatefulWidget {
  const _AddMemberDialog();
  @override
  State<_AddMemberDialog> createState() => _State();
}

class _State extends State<_AddMemberDialog> {
  final _ctrl = TextEditingController();
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Ajouter un membre'),
        content: TextField(
          controller: _ctrl,
          decoration: const InputDecoration(
            hintText: 'Email ou nom du membre',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _ctrl.text.trim()),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: AppColors.white),
            child: const Text('Ajouter'),
          ),
        ],
      );
}