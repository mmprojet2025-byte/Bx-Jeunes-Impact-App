import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final VoidCallback? onFieldSubmitted;
 
  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Mot de passe',
    this.hint = '••••••••',
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
  });
 
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}
 
class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;
 
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
              color: AppColors.textPrimary)),
      const SizedBox(height: 8),
      TextFormField(
        controller: widget.controller,
        obscureText: _obscure,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: (_) => widget.onFieldSubmitted?.call(),
        style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
          prefixIcon: const Icon(Icons.lock_outline,
              color: AppColors.textSecondary, size: 20),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _obscure = !_obscure),
            child: Icon(
              _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: AppColors.textSecondary, size: 20,
            ),
          ),
        ),
      ),
    ]);
  }
}