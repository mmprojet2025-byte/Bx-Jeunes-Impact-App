import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
 
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/bx_logo.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/forms/custom_text_field.dart';
import '../../../../shared/widgets/forms/password_field.dart';
import '../../application/register_provider.dart';
 
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
 
  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}
 
class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey      = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl  = TextEditingController();
  final _emailCtrl    = TextEditingController();
  final _passCtrl     = TextEditingController();
  final _confirmCtrl  = TextEditingController();
 
  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }
 
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
 
    final success = await ref.read(registerProvider.notifier).register(
      firstName: _firstNameCtrl.text.trim(),
      lastName:  _lastNameCtrl.text.trim(),
      email:     _emailCtrl.text.trim(),
      password:  _passCtrl.text,
    );
 
    if (success && mounted) {
      context.goNamed(RouteNames.home);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerProvider);
 
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 18),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const BxLogo(),
                  const SizedBox(height: 32),
 
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Créer un compte',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary)),
                  ),
                  const SizedBox(height: 4),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Rejoins la communauté Bx-Jeunes Impact',
                        style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  ),
                  const SizedBox(height: 24),
 
                  // Prénom
                  CustomTextField(
                    controller: _firstNameCtrl,
                    label: 'Prénom',
                    hint: 'Jean',
                    prefixIcon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Prénom requis' : null,
                  ),
                  const SizedBox(height: 14),
 
                  // Nom
                  CustomTextField(
                    controller: _lastNameCtrl,
                    label: 'Nom',
                    hint: 'Dupont',
                    prefixIcon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Nom requis' : null,
                  ),
                  const SizedBox(height: 14),
 
                  // Email
                  CustomTextField(
                    controller: _emailCtrl,
                    label: 'Email',
                    hint: 'exemple@email.com',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Email requis';
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim()))
                        return 'Format invalide';
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
 
                  // Mot de passe
                  PasswordField(
                    controller: _passCtrl,
                    label: 'Mot de passe',
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Mot de passe requis';
                      if (v.length < 8) return 'Au moins 8 caractères';
                      if (!RegExp(r'(?=.*[A-Z])').hasMatch(v)) return 'Au moins une majuscule';
                      if (!RegExp(r'(?=.*\d)').hasMatch(v)) return 'Au moins un chiffre';
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
 
                  // Confirmation mot de passe
                  PasswordField(
                    controller: _confirmCtrl,
                    label: 'Confirmer le mot de passe',
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: _register,
                    validator: (v) {
                      if (v != _passCtrl.text) return 'Les mots de passe ne correspondent pas';
                      return null;
                    },
                  ),
 
                  // Erreur
                  if (state.error != null) ...[
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.refuse.withOpacity(.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.refuse.withOpacity(.3)),
                      ),
                      child: Row(children: [
                        const Icon(Icons.error_outline, color: AppColors.refuse, size: 18),
                        const SizedBox(width: 8),
                        Expanded(child: Text(state.error!,
                            style: const TextStyle(fontSize: 13, color: AppColors.refuse))),
                      ]),
                    ),
                  ],
                  const SizedBox(height: 28),
 
                  PrimaryButton(
                    label: 'Créer mon compte',
                    loading: state.isLoading,
                    onTap: _register,
                  ),
                  const SizedBox(height: 24),
 
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Déjà un compte ? ',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                    GestureDetector(
                      onTap: () => context.goNamed(RouteNames.login),
                      child: const Text('Se connecter',
                          style: TextStyle(color: AppColors.red, fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ),
                  ]),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
