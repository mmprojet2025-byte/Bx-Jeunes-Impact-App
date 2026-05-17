import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/project.dart';

class ProjectFilters extends StatelessWidget {
  final ProjectStatus? selected;
  final void Function(ProjectStatus?) onChanged;

  const ProjectFilters({required this.onChanged, super.key, this.selected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterChip(
            label: 'Tous',
            selected: selected == null,
            color: AppColors.primary,
            onTap: () => onChanged(null),
          ),
          ...ProjectStatus.values.map((s) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _FilterChip(
                  label: s.label,
                  selected: selected == s,
                  color: s.color,
                  onTap: () => onChanged(selected == s ? null : s),
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
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.15) : AppColors.inputBg,
            borderRadius: BorderRadius.circular(20),
            border: selected ? Border.all(color: color.withOpacity(0.4)) : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? color : AppColors.textSecondary,
            ),
          ),
        ),
      );
}