import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LanguageSelector extends StatelessWidget {
  final String selected;
  final void Function(String) onChanged;
  const LanguageSelector({required this.selected, required this.onChanged, super.key});

  static const _langs = [('fr', '🇫🇷 Français'), ('nl', '🇧🇪 Nederlands'), ('en', '🇬🇧 English')];

  @override
  Widget build(BuildContext context) => Column(
        children: _langs.map((l) => RadioListTile<String>(
              value: l.$1, groupValue: selected,
              onChanged: (v) => v != null ? onChanged(v) : null,
              title: Text(l.$2, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
              activeColor: AppColors.primary, dense: true,
            )).toList(),
      );
}
