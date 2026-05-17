import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
 
class ParentalConsentSection extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const ParentalConsentSection({super.key, required this.value, required this.onChanged});
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.enAttente.withOpacity(.06),
      borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.enAttente.withOpacity(.3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [Icon(Icons.family_restroom_outlined, color: AppColors.enAttente, size: 20), SizedBox(width: 8),
        Expanded(child: Text('Consentement parental requis', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.enAttente)))]),
      const SizedBox(height: 8),
      const Text('Vous avez moins de 16 ans. Le consentement de votre parent ou tuteur légal est requis.',
        style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
      const SizedBox(height: 12),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Checkbox(value: value, onChanged: (v) => onChanged(v ?? false), activeColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        const Expanded(child: Text("Mes parents ont autorisé mon inscription sur Bx-Jeunes Impact.",
          style: TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4))),
      ]),
    ]));
}
