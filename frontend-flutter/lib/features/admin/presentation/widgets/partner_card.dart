import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../data/partner_repository.dart';
import 'partner_level_badge.dart';

class PartnerCard extends StatelessWidget {
  final Partner partner;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PartnerCard(
      {required this.partner, super.key, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Row(children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.business_outlined,
              color: AppColors.textSecondary, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(partner.name,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            PartnerLevelBadge(level: partner.level),
          ]),
        ),
        if (onEdit != null)
          IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined,
                  size: 18, color: AppColors.textSecondary)),
        if (onDelete != null)
          IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline,
                  size: 18, color: AppColors.refuse)),
      ]),
    );
  }
}