import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
 
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  const PasswordStrengthIndicator({super.key, required this.password});
  int get _score {
    if (password.isEmpty) return 0;
    int s = 0;
    if (password.length >= 8) s++;
    if (password.length >= 12) s++;
    if (RegExp(r'[A-Z]').hasMatch(password)) s++;
    if (RegExp(r'[0-9]').hasMatch(password)) s++;
    if (RegExp(r'[!@#$%^&*]').hasMatch(password)) s++;
    return s;
  }
  String get _label => switch (_score) { 0 => '', 1 => 'Très faible', 2 => 'Faible', 3 => 'Moyen', 4 => 'Fort', _ => 'Très fort' };
  Color  get _color => switch (_score) { 0 || 1 => AppColors.refuse, 2 => AppColors.enAttente, 3 => Colors.amber, _ => AppColors.enCours };
  @override Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox(height: 6);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 8),
      Row(children: List.generate(5, (i) => Expanded(child: Container(
        height: 3, margin: const EdgeInsets.only(right: 3),
        decoration: BoxDecoration(color: i < _score ? _color : AppColors.border, borderRadius: BorderRadius.circular(2)))))),
      if (_label.isNotEmpty) ...[const SizedBox(height: 4), Text(_label, style: TextStyle(fontSize: 11, color: _color, fontWeight: FontWeight.w500))],
    ]);
  }
}
