import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
 
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
 
  const SectionHeader({
    super.key,
    required this.title,
    required this.onSeeAll,
  });
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text('Voir tout',
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.red,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}