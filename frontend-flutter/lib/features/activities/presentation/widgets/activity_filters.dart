import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/activity.dart';
import 'category_chip.dart';

class ActivityFilters extends StatelessWidget {
  final ActivityCategory? selected;
  final void Function(ActivityCategory?) onChanged;

  const ActivityFilters(
      {required this.onChanged, super.key, this.selected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterChip(
            label: 'Tous',
            selected: selected == null,
            onTap: () => onChanged(null),
          ),
          ...ActivityCategory.values.map((c) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: () => onChanged(selected == c ? null : c),
                  child: CategoryChip(
                      category: c,
                      compact: selected != c),
                ),
              )),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.inputBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? AppColors.white
                      : AppColors.textSecondary)),
        ),
      );
}