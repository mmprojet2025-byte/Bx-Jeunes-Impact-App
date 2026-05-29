import 'package:flutter/material.dart';
import '../../data/activity.dart';

class CategoryChip extends StatelessWidget {
  final ActivityCategory category;
  final bool compact;

  const CategoryChip(
      {required this.category, super.key, this.compact = false,});

  @override
  Widget build(BuildContext context) {
    final color = category.color;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 12, vertical: compact ? 3 : 5,),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(category.icon, size: compact ? 11 : 13, color: color),
        const SizedBox(width: 4),
        Text(category.label,
            style: TextStyle(
                fontSize: compact ? 10 : 11,
                fontWeight: FontWeight.w600,
                color: color,),),
      ],),
    );
  }
}