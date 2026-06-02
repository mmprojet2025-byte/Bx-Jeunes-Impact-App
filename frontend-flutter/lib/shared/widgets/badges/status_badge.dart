import 'package:flutter/material.dart';
import 'package:bx_jeunes_impact/features/projects/data/project.dart';

class StatusBadge extends StatelessWidget {
  final ProjectStatus status;

  const StatusBadge({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: status.color,
        ),
      ),
    );
  }
}
