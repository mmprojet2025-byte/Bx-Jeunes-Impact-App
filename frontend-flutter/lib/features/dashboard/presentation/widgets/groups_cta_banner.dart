import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
 
class GroupsCtaBanner extends StatelessWidget {
  final VoidCallback? onTap;
 
  const GroupsCtaBanner({super.key, this.onTap});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: GestureDetector(
        onTap: onTap ?? () { /* TODO: navigate to groups */ },
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(children: [
            Container(
              width: 40, height: 40,
              margin: const EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),),
              child: const Icon(Icons.groups_rounded,
                  color: Colors.white, size: 24,),
            ),
            const Expanded(
              child: Text(
                'Rejoins des groupes\net collabore avec d\'autres jeunes !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.white, size: 16,),
          ],),
        ),
      ),
    );
  }
}