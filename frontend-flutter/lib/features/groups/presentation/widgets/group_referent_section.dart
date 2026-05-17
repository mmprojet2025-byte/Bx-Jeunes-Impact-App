import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class GroupReferentSection extends StatelessWidget {
  final String? referentName;
  const GroupReferentSection({super.key, this.referentName});

  @override
  Widget build(BuildContext context) {
    if (referentName == null) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(children: [
        const Icon(Icons.manage_accounts_outlined, color: AppColors.primary, size: 22),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Référent', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          Text(referentName!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ]),
      ]),
    );
  }
}