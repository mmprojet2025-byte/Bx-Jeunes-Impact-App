import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/role.dart';

class MemberFilters extends StatelessWidget {
  final Role? selected;
  final void Function(Role?) onChanged;
  const MemberFilters({required this.onChanged, super.key, this.selected});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 38,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _Chip(label: 'Tous', selected: selected == null, onTap: () => onChanged(null)),
            ...Role.values.map((r) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _Chip(
                    label: r.label,
                    selected: selected == r,
                    color: r.color,
                    onTap: () => onChanged(selected == r ? null : r),
                  ),
                )),
          ],
        ),
      );
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.selected, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? c.withOpacity(0.15) : AppColors.inputBg,
          borderRadius: BorderRadius.circular(20),
          border: selected ? Border.all(color: c.withOpacity(0.4)) : null,
        ),
        child: Text(label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                color: selected ? c : AppColors.textSecondary)),
      ),
    );
  }
}