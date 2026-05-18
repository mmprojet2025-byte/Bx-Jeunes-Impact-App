import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/app_bar/custom_app_bar.dart';
 
class TermsOfServicesScreen extends StatelessWidget {
  const TermsOfServicesScreen({super.key});
 
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: CustomAppBar(title: "Conditions d'utilisation"),
    body: const Center(
      child: Text('À implémenter',
          style: TextStyle(color: AppColors.textSecondary)),
    ),
  );
}
