import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
enum ProjectStatus { enCours, enAttente, refuse, valide, brouillon }
 
extension ProjectStatusExt on ProjectStatus {
  String get label {
    switch (this) {
      case ProjectStatus.enCours:   return 'En cours';
      case ProjectStatus.enAttente: return 'En attente';
      case ProjectStatus.refuse:    return 'Refusé';
      case ProjectStatus.valide:    return 'Validé';
      case ProjectStatus.brouillon: return 'Brouillon';
    }
  }
 
  Color get color {
    switch (this) {
      case ProjectStatus.enCours:   return AppColors.enCours;
      case ProjectStatus.enAttente: return AppColors.enAttente;
      case ProjectStatus.refuse:    return AppColors.refuse;
      case ProjectStatus.valide:    return AppColors.valide;
      case ProjectStatus.brouillon: return AppColors.brouillon;
    }
  }
}
 
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
 