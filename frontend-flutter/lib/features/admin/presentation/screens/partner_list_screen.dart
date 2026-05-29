import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/app_bar/custom_app_bar.dart';
 
class PartnerListScreen extends StatelessWidget {
  const PartnerListScreen({super.key});
 
  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: AppColors.background,
    appBar: CustomAppBar(title: 'Partenaires'),
    body: Center(
      child: Text('À implémenter',
          style: TextStyle(color: AppColors.textSecondary),),
    ),
  );
}
