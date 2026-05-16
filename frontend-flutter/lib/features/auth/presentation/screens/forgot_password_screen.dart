import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/forms/custom_text_field.dart';
import '../../application/forgot_password_provider.dart';
 
// ─────────────────────────────────────────────────────────────
//  Screen
// ─────────────────────────────────────────────────────────────
 
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});
 
  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}
 
class _ForgotPasswordScreenState
    extends ConsumerState<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
 
  // Animation d'entrée
  late final AnimationController _ac = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 500))..forward();
  late final Animation<double> _fade =
      CurvedAnimation(parent: _ac, curve: Curves.easeOut);
 
  bool get _canSubmit => _emailCtrl.text.trim().isNotEmpty;
 
  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() => setState(() {}));
  }
 
  @override
  void dispose() {
    _ac.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }
 
  Future<void> _send() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await ref.read(forgotPasswordProvider.notifier)
        .sendResetLink(_emailCtrl.text);
  }
 
  void _backToLogin() {
    // Réinitialise l'état du provider avant de quitter
    ref.read(forgotPasswordProvider.notifier).reset();
    Navigator.pushReplacementNamed(context, RouteNames.login);
  }
 
  void _resendLink() {
    ref.read(forgotPasswordProvider.notifier).reset();
    // Reset le champ email avec la même valeur pour réessayer
    final email = ref.read(forgotPasswordProvider).submittedEmail ?? '';
    _emailCtrl.text = email;
    _ac
      ..reset()
      ..forward();
  }
 
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordProvider);
 
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: state.sent
              ? null // Pas de retour arrière depuis la confirmation
              : IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      size: 18, color: AppColors.textPrimary),
                  onPressed: _backToLogin,
                ),
        ),
        body: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: state.sent
                ? _ConfirmationView(
                    email:       state.submittedEmail ?? '',
                    onBackLogin: _backToLogin,
                    onResend:    _resendLink,
                  )
                : _EmailFormView(
                    formKey:     _formKey,
                    emailCtrl:   _emailCtrl,
                    canSubmit:   _canSubmit,
                    isLoading:   state.isLoading,
                    error:       state.error,
                    onSend:      _send,
                    onBackLogin: _backToLogin,
                    onClearError: () =>
                        ref.read(forgotPasswordProvider.notifier).clearError(),
                  ),
          ),
        ),
      ),
    );
  }
}
 
// ─────────────────────────────────────────────────────────────
//  Étape 1 — Formulaire email
// ─────────────────────────────────────────────────────────────
 
class _EmailFormView extends StatelessWidget {
  final GlobalKey<FormState>      formKey;
  final TextEditingController     emailCtrl;
  final bool                      canSubmit;
  final bool                      isLoading;
  final String?                   error;
  final VoidCallback              onSend;
  final VoidCallback              onBackLogin;
  final VoidCallback              onClearError;
 
  const _EmailFormView({
    required this.formKey,   required this.emailCtrl,
    required this.canSubmit, required this.isLoading,
    required this.error,     required this.onSend,
    required this.onBackLogin, required this.onClearError,
  });
 
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Form(
        key:              formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          const SizedBox(height: 24),
 
          // ── Illustration ────────────────────────────────
          Container(
            width: 88, height: 88,
            decoration: BoxDecoration(
              color:  AppColors.red.withOpacity(.08),
              shape:  BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_reset_rounded,
              size:  44,
              color: AppColors.red,
            ),
          ),
          const SizedBox(height: 28),
 
          // ── Titre ───────────────────────────────────────
          const Text(
            'Mot de passe oublié ?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:   24,
              fontWeight: FontWeight.bold,
              color:      AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Entrez votre adresse email. Si un compte existe, '
            'vous recevrez un lien pour créer un nouveau mot de passe.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color:    AppColors.textSecondary,
              height:   1.5,
            ),
          ),
          const SizedBox(height: 32),
 
          // ── Champ email ─────────────────────────────────
          CustomTextField(
            controller:      emailCtrl,
            label:           'Email',
            hint:            'exemple@email.com',
            prefixIcon:      Icons.email_outlined,
            keyboardType:    TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: onSend,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Email requis';
              if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim()))
                return 'Format d\'email invalide';
              return null;
            },
          ),
 
          // ── Erreur réseau ────────────────────────────────
          if (error != null) ...[
            const SizedBox(height: 14),
            _ErrorBanner(message: error!, onClose: onClearError),
          ],
          const SizedBox(height: 28),
 
          // ── Bouton principal ─────────────────────────────
          PrimaryButton(
            label:   'Envoyer le lien de réinitialisation',
            loading: isLoading,
            onTap:   canSubmit && !isLoading ? onSend : null,
          ),
          const SizedBox(height: 18),
 
          // ── Lien retour connexion ────────────────────────
          GestureDetector(
            onTap: onBackLogin,
            child: const Text(
              'Retour à la connexion',
              style: TextStyle(
                color:      AppColors.red,
                fontSize:   14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 48),
        ]),
      ),
    );
  }
}
 
// ─────────────────────────────────────────────────────────────
//  Étape 2 — Confirmation (message neutre)
// ─────────────────────────────────────────────────────────────
//
// ⚠️  Sécurité — formulation neutre
// Le message ne confirme PAS que l'email existe dans la base.
// "Si cet email est associé à un compte…" évite l'énumération
// des adresses email (OWASP A01:2021).
 
class _ConfirmationView extends StatelessWidget {
  final String       email;
  final VoidCallback onBackLogin;
  final VoidCallback onResend;
 
  const _ConfirmationView({
    required this.email,
    required this.onBackLogin,
    required this.onResend,
  });
 
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(children: [
        const SizedBox(height: 40),
 
        // ── Icône succès ────────────────────────────────
        Container(
          width: 96, height: 96,
          decoration: BoxDecoration(
            color:  AppColors.enCours.withOpacity(.1),
            shape:  BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size:  48,
            color: AppColors.enCours,
          ),
        ),
        const SizedBox(height: 32),
 
        // ── Titre ───────────────────────────────────────
        const Text(
          'Vérifiez vos emails',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize:   24,
            fontWeight: FontWeight.bold,
            color:      AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 14),
 
        // ── Message neutre ───────────────────────────────
        // ⚠️  Ne pas modifier cette formulation —
        // elle est intentionnellement vague pour la sécurité.
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              color:    AppColors.textSecondary,
              height:   1.6,
            ),
            children: [
              const TextSpan(
                text: 'Si cette adresse est associée à un compte '
                      'Bx-Jeunes Impact, vous recevrez un lien '
                      'de réinitialisation à\n',
              ),
              TextSpan(
                text:  email,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color:      AppColors.textPrimary,
                ),
              ),
              const TextSpan(
                text: '\n\nLe lien est valable '
                      '\u00bf1 heure\u00bf.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Correction : remplacer les guillemets bizarres par du texte simple
        Text(
          'Le lien est valable 1 heure.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color:    AppColors.textSecondary,
            height:   1.5,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Pensez à vérifier vos spams si vous ne le trouvez pas.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color:    AppColors.textHint,
          ),
        ),
        const SizedBox(height: 40),
 
        // ── Info page web ────────────────────────────────
        Container(
          padding:    const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color:        AppColors.inputBg,
            borderRadius: BorderRadius.circular(12),
            border:       Border.all(color: AppColors.border),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline,
                  size: 18, color: AppColors.textSecondary),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'En cliquant sur le lien, une page web s\'ouvrira '
                  'pour vous permettre de créer votre nouveau mot de passe.',
                  style: TextStyle(
                    fontSize: 13,
                    color:    AppColors.textSecondary,
                    height:   1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
 
        // ── Bouton retour connexion ──────────────────────
        PrimaryButton(
          label:   'Retour à la connexion',
          loading: false,
          onTap:   onBackLogin,
        ),
        const SizedBox(height: 16),
 
        // ── Renvoyer ─────────────────────────────────────
        GestureDetector(
          onTap: onResend,
          child: const Text(
            'Renvoyer un lien',
            style: TextStyle(
              color:      AppColors.red,
              fontSize:   14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 48),
      ],),
    );
  }
}
 
// ── Bannière erreur ───────────────────────────────────────────
 
class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onClose;
  const _ErrorBanner({required this.message, required this.onClose});
 
  @override
  Widget build(BuildContext context) => Container(
    width:   double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color:        AppColors.refuse.withOpacity(.08),
      borderRadius: BorderRadius.circular(10),
      border:       Border.all(color: AppColors.refuse.withOpacity(.3)),
    ),
    child: Row(children: [
      const Icon(Icons.wifi_off_rounded, color: AppColors.refuse, size: 18),
      const SizedBox(width: 8),
      Expanded(
        child: Text(message,
            style: const TextStyle(fontSize: 13, color: AppColors.refuse))),
      GestureDetector(onTap: onClose,
          child: const Icon(Icons.close, color: AppColors.refuse, size: 16)),
    ],),
  );
}
