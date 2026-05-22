import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/bx_logo.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/forms/custom_text_field.dart';
import '../../application/login_provider.dart';
import 'package:go_router/go_router.dart';
 
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
 
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}
 
class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  // ── Controllers & Keys ────────────────────────────────────
  final _formKey    = GlobalKey<FormState>();
  final _emailCtrl  = TextEditingController();
  final _passCtrl   = TextEditingController();
  final _emailFocus = FocusNode();
  final _passFocus  = FocusNode();
 
  bool _obscure = true;
 
  // Bouton actif seulement si les deux champs sont non-vides
  // (double-sécurité avec la validation Form)
  bool get _canSubmit =>
      _emailCtrl.text.trim().isNotEmpty && _passCtrl.text.isNotEmpty;
 
  // ── Animations entry ──────────────────────────────────────
  late final AnimationController _ac = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 650))..forward();
 
  late final Animation<double> _fade =
      CurvedAnimation(parent: _ac, curve: Curves.easeOut);
 
  late final Animation<Offset> _slide =
      Tween(begin: const Offset(0, .06), end: Offset.zero).animate(
          CurvedAnimation(parent: _ac, curve: Curves.easeOut));
 
  @override
  void initState() {
    super.initState();
    // Rebuilds pour activer/désactiver le bouton en temps réel
    _emailCtrl.addListener(() => setState(() {}));
    _passCtrl.addListener(() => setState(() {}));
  }
 
  @override
  void dispose() {
    _ac.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }
 
  // ── Actions ───────────────────────────────────────────────
 
  Future<void> _login() async {
    // 1. Fermer le clavier
    FocusScope.of(context).unfocus();
 
    // 2. Valider le formulaire
    if (!_formKey.currentState!.validate()) return;
    if (!_canSubmit) return;
 
    // 3. Appel API via le provider
    final success = await ref.read(loginProvider.notifier).login(
      email:    _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );
 
    
  }
 
  void _goForgotPassword() => context.pushNamed(RouteNames.forgotPassword);

  void _goRegister() => context.pushNamed(RouteNames.register);
 
  // ── Build ─────────────────────────────────────────────────
 
  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
 
    // Efface l'erreur si l'utilisateur retape dans un champ
    ref.listen<LoginState>(loginProvider, (prev, next) {});
 
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // ── Blob décoratif ──────────────────────────────
            const Positioned(bottom: -10, left: -20, child: BlobDecoration()),
 
            // ── Contenu ─────────────────────────────────────
            SafeArea(
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Support paysage : ≥ 600px de large → centré dans 420px
                      final isLandscapeWide = constraints.maxWidth >= 500;
                      final content = _buildForm(loginState, isLandscapeWide);
 
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: isLandscapeWide
                              ? (constraints.maxWidth - 420) / 2
                              : 28,
                        ),
                        child: content,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildForm(LoginState state, bool isWide) {
    return Form(
      key: _formKey,
      // Valide en continu après la première soumission
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: isWide ? 32 : 52),
 
          // ── Logo ──────────────────────────────────────────
          const BxLogo(),
          SizedBox(height: isWide ? 28 : 44),
 
          // ── Champ Email ───────────────────────────────────
          CustomTextField(
            controller: _emailCtrl,
            label:       'Email',
            hint:        'exemple@email.com',
            prefixIcon:  Icons.email_outlined,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: () {
              // Focus passe au mot de passe
              FocusScope.of(context).requestFocus(_passFocus);
            },
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Email requis';
              if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim()))
                return 'Format d\'email invalide';
              return null;
            },
          ),
          const SizedBox(height: 16),
 
          // ── Champ Mot de passe ────────────────────────────
          CustomTextField(
            controller:      _passCtrl,
            label:           'Mot de passe',
            hint:            '••••••••',
            prefixIcon:      Icons.lock_outline,
            obscure:         _obscure,
            onToggleObscure: () => setState(() => _obscure = !_obscure),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: _login,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Mot de passe requis';
              return null;
            },
          ),
          const SizedBox(height: 10),
 
          // ── Mot de passe oublié ───────────────────────────
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: _goForgotPassword,
              child: const Text(
                'Mot de passe oublié ?',
                style: TextStyle(
                  color:      AppColors.red,
                  fontSize:   13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
 
          // ── Bannière d'erreur ─────────────────────────────
          if (state.error != null) ...[
            const SizedBox(height: 14),
            _ErrorBanner(
              message: state.error!,
              onClose: () => ref.read(loginProvider.notifier).clearError(),
            ),
          ],
          const SizedBox(height: 26),
 
          // ── Bouton connexion ──────────────────────────────
          // Désactivé si les champs sont vides ou si loading
          PrimaryButton(
            label:   'Se connecter',
            loading: state.isLoading,
            // onTap = null → bouton grisé quand invalide
            onTap:   _canSubmit && !state.isLoading ? _login : null,
          ),
          const SizedBox(height: 22),
 
          // ── Séparateur ────────────────────────────────────
          Row(children: [
            Expanded(child: Divider(color: AppColors.border)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text('ou',
                  style: TextStyle(
                    color:    AppColors.textSecondary,
                    fontSize: 13,
                  )),
            ),
            Expanded(child: Divider(color: AppColors.border)),
          ]),
          const SizedBox(height: 22),
 
          // ── Bouton Google ─────────────────────────────────
          _GoogleButton(onTap: () {
            // TODO : OAuth Google (V2)
          }),
          const SizedBox(height: 34),
 
          // ── Lien inscription ──────────────────────────────
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Pas encore de compte ? ',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            GestureDetector(
              onTap: _goRegister,
              child: const Text(
                'Créer un compte',
                style: TextStyle(
                  color:      AppColors.red,
                  fontSize:   14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
 
// ── Widgets locaux ────────────────────────────────────────────
 
/// Bandeau d'erreur rouge avec bouton fermeture.
/// Affiché sur 401 ("Identifiants invalides") et erreur réseau.
class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onClose;
 
  const _ErrorBanner({required this.message, required this.onClose});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color:        AppColors.refuse.withOpacity(.08),
        borderRadius: BorderRadius.circular(10),
        border:       Border.all(color: AppColors.refuse.withOpacity(.3)),
      ),
      child: Row(children: [
        const Icon(Icons.error_outline, color: AppColors.refuse, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(fontSize: 13, color: AppColors.refuse),
          ),
        ),
        GestureDetector(
          onTap: onClose,
          child: const Icon(Icons.close, color: AppColors.refuse, size: 16),
        ),
      ]),
    );
  }
}
 
/// Bouton "Continuer avec Google".
class _GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GoogleButton({required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color:        AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border:       Border.all(color: AppColors.border),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 22, height: 22,
            decoration: BoxDecoration(
              shape:  BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: const Center(
              child: Text('G',
                style: TextStyle(
                  fontSize:   13,
                  fontWeight: FontWeight.bold,
                  color:      Color(0xFF4285F4),
                )),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Continuer avec Google',
            style: TextStyle(
              fontSize:   15,
              fontWeight: FontWeight.w500,
              color:      AppColors.textPrimary,
            ),
          ),
        ]),
      ),
    );
  }
}
