import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/role.dart';

Future<Role?> showChangeRoleDialog(BuildContext context, Role current) =>
    showDialog<Role>(context: context, builder: (_) => _Dialog(current: current));

class _Dialog extends StatefulWidget {
  final Role current;
  const _Dialog({required this.current});
  @override State<_Dialog> createState() => _State();
}
class _State extends State<_Dialog> {
  late Role _selected;
  @override void initState() { super.initState(); _selected = widget.current; }
  @override
  Widget build(BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Changer le rôle'),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: Role.values.map((r) => RadioListTile<Role>(
            value: r, groupValue: _selected,
            onChanged: (v) => setState(() => _selected = v!),
            title: Text(r.label),
            activeColor: AppColors.primary,
            dense: true,
          )).toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, _selected),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: AppColors.white),
            child: const Text('Confirmer'),
          ),
        ],
      );
}
