import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MemberSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const MemberSearchBar({required this.controller, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          decoration: const InputDecoration(
            hintText: 'Rechercher un membre…',
            hintStyle: TextStyle(color: AppColors.textHint, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      );
}
