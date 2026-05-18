import 'package:flutter/material.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bar/custom_app_bar.dart';
 
class MemberListScreen extends StatelessWidget {
  const MemberListScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Membres', showBack: false),
      body: Center(
        child: Text('Liste des membres — à implémenter',
            style: TextStyle(color: AppColors.textSecondary),),
      ),
    );
  }
}
