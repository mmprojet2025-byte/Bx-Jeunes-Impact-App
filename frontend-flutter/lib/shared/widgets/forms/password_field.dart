import 'package:flutter/material.dart';
 
import '../../../core/theme/app_colors.dart';
 
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
 
  /// Label affiché au-dessus du champ
  final String label;
 
  /// Placeholder dans le champ
  final String hint;
 
  /// Affiche l'indicateur de force (barres colorées) sous le champ
  final bool showStrength;
 
  /// Validation custom — si null, utilise la validation par défaut
  /// (min 8 chars, 1 majuscule, 1 chiffre)
  final String? Function(String?)? validator;
 
  final TextInputAction textInputAction;
 
  /// Appelé quand l'utilisateur appuie sur "Done" / "Next" sur le clavier
  final VoidCallback? onFieldSubmitted;
 
  const PasswordField({
    super.key,
    required this.controller,
    this.label           = 'Mot de passe',
    this.hint            = '••••••••',
    this.showStrength    = false,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
  });
 
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}
 
class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;
 
  void _toggle() => setState(() => _obscure = !_obscure);
 
  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) return 'Mot de passe requis';
    if (value.length < 8) return 'Au moins 8 caractères';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Au moins 1 majuscule';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Au moins 1 chiffre';
    return null;
  }
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label ────────────────────────────────────────────
        Text(widget.label,
          style: const TextStyle(
            fontSize:   14,
            fontWeight: FontWeight.w500,
            color:      AppColors.textPrimary,
          )),
        const SizedBox(height: 8),
 
        // ── Input ─────────────────────────────────────────────
        TextFormField(
          controller:      widget.controller,
          obscureText:     _obscure,
          validator:       widget.validator ?? _defaultValidator,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: (_) => widget.onFieldSubmitted?.call(),
          style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText:  widget.hint,
            hintStyle: const TextStyle(
                color: AppColors.textHint, fontSize: 14),
            prefixIcon: const Icon(Icons.lock_outline,
                color: AppColors.textSecondary, size: 20),
            suffixIcon: GestureDetector(
              onTap: _toggle,
              child: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            filled:      true,
            fillColor:   AppColors.inputBg,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.red, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.refuse)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.refuse, width: 1.5)),
            errorStyle: const TextStyle(
                fontSize: 11.5, color: AppColors.refuse),
          ),
        ),
 
        // ── Indicateur de force (optionnel) ───────────────────
        if (widget.showStrength)
          _PasswordStrengthBar(controller: widget.controller),
      ],
    );
  }
}
 
// ── Indicateur de force ───────────────────────────────────────
 
class _PasswordStrengthBar extends StatefulWidget {
  final TextEditingController controller;
  const _PasswordStrengthBar({required this.controller});
 
  @override
  State<_PasswordStrengthBar> createState() => _PasswordStrengthBarState();
}
 
class _PasswordStrengthBarState extends State<_PasswordStrengthBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }
 
  void _rebuild() => setState(() {});
 
  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }
 
  int get _score {
    final v = widget.controller.text;
    if (v.isEmpty) return 0;
    int s = 0;
    if (v.length >= 8)                      s++;
    if (v.length >= 12)                     s++;
    if (RegExp(r'[A-Z]').hasMatch(v))       s++;
    if (RegExp(r'[0-9]').hasMatch(v))       s++;
    if (RegExp(r'[!@#\$%^&*]').hasMatch(v)) s++;
    return s;
  }
 
  String get _label => switch (_score) {
    0     => '',
    1     => 'Très faible',
    2     => 'Faible',
    3     => 'Moyen',
    4     => 'Fort',
    _     => 'Très fort',
  };
 
  Color get _color => switch (_score) {
    0 || 1 => AppColors.refuse,
    2      => AppColors.enAttente,
    3      => Colors.amber,
    _      => AppColors.enCours,
  };
 
  @override
  Widget build(BuildContext context) {
    if (widget.controller.text.isEmpty) return const SizedBox(height: 6);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: List.generate(5, (i) => Expanded(
            child: Container(
              height: 3,
              margin: const EdgeInsets.only(right: 3),
              decoration: BoxDecoration(
                color: i < _score ? _color : AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          )),
        ),
        if (_label.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(_label,
            style: TextStyle(
              fontSize:   11,
              color:      _color,
              fontWeight: FontWeight.w500,
            )),
        ],
      ]),
    );
  }
}
