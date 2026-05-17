import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
 
class AuthFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscure;
  final VoidCallback? onToggleObscure;
  final String? Function(String?)? validator;
  final VoidCallback? onFieldSubmitted;
  const AuthFormField({super.key, required this.controller, required this.label,
    required this.hint, required this.prefixIcon, this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next, this.obscure = false,
    this.onToggleObscure, this.validator, this.onFieldSubmitted});
  @override Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
      const SizedBox(height: 8),
      TextFormField(controller: controller, keyboardType: keyboardType, obscureText: obscure,
        textInputAction: textInputAction, validator: validator,
        onFieldSubmitted: (_) => onFieldSubmitted?.call(),
        style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
        decoration: InputDecoration(hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
          prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary, size: 20),
          suffixIcon: onToggleObscure != null ? GestureDetector(onTap: onToggleObscure,
            child: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: AppColors.textSecondary, size: 20)) : null,
          filled: true, fillColor: AppColors.inputBg,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.refuse)),
          errorStyle: const TextStyle(fontSize: 11.5, color: AppColors.refuse))),
    ]);
}
