import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class Group {
  final int id;
  final String name;
  final String? description;
  final String? referentName;
  final int memberCount;
  const Group({required this.id, required this.name, this.description,
      this.referentName, this.memberCount = 0});
  factory Group.fromJson(Map<String, dynamic> j) => Group(
        id: j['id'] as int,
        name: j['name'] as String,
        description: j['description'] as String?,
        referentName: j['referentName'] as String?,
        memberCount: j['memberCount'] as int? ?? 0,
      );
}

class GroupCard extends StatelessWidget {
  final Group group;
  final VoidCallback? onTap;
  const GroupCard({required this.group, super.key, this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Row(children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: AppColors.culture.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.groups_outlined, color: AppColors.culture, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(group.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              Text('${group.memberCount} membres', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
            const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
          ]),
        ),
      );
}