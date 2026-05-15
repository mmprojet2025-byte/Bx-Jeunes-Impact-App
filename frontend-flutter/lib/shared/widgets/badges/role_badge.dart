import 'package:flutter/material.dart';
import '../../models/role.dart';
 
class RoleBadge extends StatelessWidget {
  final AppRole role;
  final bool small;
 
  const RoleBadge({super.key, required this.role, this.small = false});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: small ? 6 : 10, vertical: small ? 3 : 4),
      decoration: BoxDecoration(
        color: role.color.withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(role.label,
          style: TextStyle(
              fontSize: small ? 10 : 11,
              fontWeight: FontWeight.w600,
              color: role.color)),
    );
  }
}
