import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bar/custom_app_bar.dart';
import '../../../../shared/widgets/loaders/loading_indicator.dart';
 
class MemberDetailScreen extends StatelessWidget {
  final int memberId;
 
  const MemberDetailScreen({super.key, required this.memberId});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Profil du membre'),
      body: Center(
        child: Text(
          'Membre #$memberId',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
