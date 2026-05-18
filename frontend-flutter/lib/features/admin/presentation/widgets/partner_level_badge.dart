import 'package:flutter/material.dart';
import '../../../features/admin/data/partner_repository.dart';

class PartnerLevelBadge extends StatelessWidget {
  final PartnerLevel level;
  const PartnerLevelBadge({required this.level, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: level.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: level.color.withOpacity(0.4)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.star_rounded, size: 12, color: level.color),
        const SizedBox(width: 4),
        Text(level.label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: level.color)),
      ]),
    );
  }
}