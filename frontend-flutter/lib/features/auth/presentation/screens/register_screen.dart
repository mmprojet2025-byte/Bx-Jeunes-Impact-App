import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/bx_logo.dart';
import '../../../../shared/widgets/forms/custom_text_field.dart';
import '../../application/register_provider.dart';

// ── Constantes ────────────────────────────────────────────────

/// Âge minimum pour inscription sans consentement parental
const int _minAgeWithoutConsent = 16;

/// Âge maximum autorisé
const int _maxAge = 100;

// ─────────────────────────────────────────────────────────────
//  Screen
// ─────────────────────────────────────────────────────────────

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  // ── Form & Controllers ────────────────────────────────────
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl   = TextEditingController();
  final _lastNameCtrl    = TextEditingController();
  final _emailCtrl       = TextEditingController();
  final _passwordCtrl    = TextEditingController();
  final _confirmCtrl     = TextEditingController();
  final _parentEmailCtrl = TextEditingController();

  // ── State ─────────────────────────────────────────────────
  DateTime? _dateOfBirth;
  bool      _obscurePass     = true;
  bool      _obscureConfirm  = true;
  bool      _acceptedTerms   = false;
  bool      _acceptedPrivacy = false;
  bool      _parentalConsent = false;

  // ── Computed ──────────────────────────────────────────────

  /// Vrai si l'utilisateur a moins de [_minAgeWithoutConsent] ans
  bool get _isMinor {
    if (_dateOfBirth == null) return false;
    final today = DateTime.now();
    final age   = today.year - _dateOfBirth!.year;
    final hadBirthday = today.month > _dateOfBirth!.month ||
        (today.month == _dateOfBirth!.month &&
         today.day   >= _dateOfBirth!.day);
    return (hadBirthday ? age : age - 1) < _minAgeWithoutConsent;
  }

  /// Label de la date de naissance formatée
  String get _dobLabel {
    if (_dateOfBirth == null) return 'Sélectionner une date';
    final d = _dateOfBirth!;
    return '${d.day.toString().padLeft(2, '0')}/'
           '${d.month.toString().padLeft(2, '0')}/'
           '${d.year}';
  }

  /// Bouton actif seulement si les champs clés sont remplis
  bool get _canSubmit {
    if (_firstNameCtrl.text.trim().isEmpty) return false;
    if (_lastNameCtrl.text.trim().isEmpty)  return false;
    if (_emailCtrl.text.trim().isEmpty)     return false;
    if (_passwordCtrl.text.isEmpty)         return false;
    if (_confirmCtrl.text.isEmpty)          return false;
    if (_dateOfBirth == null)               return false;
    if (!_acceptedTerms || !_acceptedPrivacy) return false;
    if (_isMinor && (!_parentalConsent || _parentEmailCtrl.text.trim().isEmpty)) return false;
    return true;
  }

  @override
  void initState() {
    super.initState();
    for (final c in [_firstNameCtrl, _lastNameCtrl, _emailCtrl,
                     _passwordCtrl, _confirmCtrl, _parentEmailCtrl]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in [_firstNameCtrl, _lastNameCtrl, _emailCtrl,
                     _passwordCtrl, _confirmCtrl, _parentEmailCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  // ── Actions ───────────────────────────────────────────────

  Future<void> _pickDate() async {
    final now  = DateTime.now();
    final init = _dateOfBirth ?? DateTime(now.year - 18, now.month, now.day);

    final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: AppColors.red,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) setState(() => _dateOfBirth = picked);
  }

  Future<void> _register() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (!_canSubmit) return;

    final success = await ref.read(registerProvider.notifier).register(
      firstName:       _firstNameCtrl.text.trim(),
      lastName:        _lastNameCtrl.text.trim(),
      email:           _emailCtrl.text.trim(),
      password:        _passwordCtrl.text,
      dateOfBirth:     _dateOfBirth!,
      parentalConsent: _isMinor ? _parentalConsent : false,
      parentEmail:     _isMinor ? _parentEmailCtrl.text.trim() : null,
    );

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, RouteNames.home);
    }
  }

  void _goLogin()     => Navigator.pushReplacementNamed(context, RouteNames.login);
  void _openTerms()   => Navigator.pushNamed(context, RouteNames.termsOfService);
  void _openPrivacy() => Navigator.pushNamed(context, RouteNames.privacyPolicy);

  // ── Build ─────────────────────────────────────────────────

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
            icon: const Icon(Icons.arrow_back_ios_new,
                size: 18, color: AppColors.textPrimary),
            onPressed: _goLogin,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── En-tête ──────────────────────────────
                  const Center(child: BxLogo()),
                  const SizedBox(height: 24),
                  const Text(
                    'Créer mon compte',
                    style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Rejoins la communauté Bx-Jeunes Impact',
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),

                  // ── Prénom + Nom ──────────────────────────
                  _SectionLabel('Informations personnelles'),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                      child: CustomTextField(
                        controller:      _firstNameCtrl,
                        label:           'Prénom',
                        hint:            'Jean',
                        prefixIcon:      Icons.person_outline,
                        textInputAction: TextInputAction.next,
                        validator:       _validateName('Prénom'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        controller:      _lastNameCtrl,
                        label:           'Nom',
                        hint:            'Dupont',
                        prefixIcon:      Icons.person_outline,
                        textInputAction: TextInputAction.next,
                        validator:       _validateName('Nom'),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 14),

                  // ── Email ─────────────────────────────────
                  CustomTextField(
                    controller:      _emailCtrl,
                    label:           'Email',
                    hint:            'exemple@email.com',
                    prefixIcon:      Icons.email_outlined,
                    keyboardType:    TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Email requis';
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim()))
                        return 'Format d\'email invalide';
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  // ── Date de naissance ─────────────────────
                  _DatePickerField(
                    label:    'Date de naissance',
                    value:    _dobLabel,
                    hasError: _dateOfBirth == null && _formKey.currentState != null,
                    onTap:    _pickDate,
                  ),
                  if (_dateOfBirth == null)
                    const Padding(
                      padding: EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        'Date de naissance requise',
                        style: TextStyle(fontSize: 11.5, color: AppColors.refuse),
                      ),
                    ),
                  const SizedBox(height: 24),

                  // ── Mot de passe ──────────────────────────
                  _SectionLabel('Sécurité'),
                  const SizedBox(height: 12),
                  _PasswordInput(
                    controller:      _passwordCtrl,
                    label:           'Mot de passe',
                    obscure:         _obscurePass,
                    onToggle:        () => setState(() => _obscurePass = !_obscurePass),
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Mot de passe requis';
                      if (v.length < 8)           return 'Au moins 8 caractères';
                      if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Au moins 1 majuscule';
                      if (!RegExp(r'[0-9]').hasMatch(v)) return 'Au moins 1 chiffre';
                      return null;
                    },
                  ),
                  _PasswordStrengthBar(password: _passwordCtrl.text),
                  const SizedBox(height: 14),
                  _PasswordInput(
                    controller:       _confirmCtrl,
                    label:            'Confirmer le mot de passe',
                    obscure:          _obscureConfirm,
                    onToggle:         () => setState(() => _obscureConfirm = !_obscureConfirm),
                    textInputAction:  TextInputAction.done,
                    onFieldSubmitted: _register,
                    validator: (v) {
                      if (v == null || v.isEmpty)   return 'Confirmation requise';
                      if (v != _passwordCtrl.text)  return 'Les mots de passe ne correspondent pas';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // ── Consentement parental (si mineur) ─────
                  if (_isMinor) ...[
                    _ParentalConsentSection(
                      parentEmailCtrl:  _parentEmailCtrl,
                      consentChecked:   _parentalConsent,
                      onConsentChanged: (v) => setState(() => _parentalConsent = v),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // ── Checkboxes légales ────────────────────
                  _SectionLabel('Conditions légales'),
                  const SizedBox(height: 12),
                  _LegalCheckbox(
                    value:     _acceptedTerms,
                    onChanged: (v) => setState(() => _acceptedTerms = v),
                    text:      'J\'ai lu et j\'accepte les ',
                    linkText:  'Conditions d\'utilisation',
                    onLinkTap: _openTerms,
                    validator: () => _acceptedTerms
                        ? null
                        : 'Vous devez accepter les conditions d\'utilisation',
                  ),
                  const SizedBox(height: 10),
                  _LegalCheckbox(
                    value:     _acceptedPrivacy,
                    onChanged: (v) => setState(() => _acceptedPrivacy = v),
                    text:      'J\'ai lu la ',
                    linkText:  'Politique de confidentialité',
                    onLinkTap: _openPrivacy,
                    validator: () => _acceptedPrivacy
                        ? null
                        : 'Vous devez accepter la politique de confidentialité',
                  ),
                  const SizedBox(height: 28),

                  // ── Erreur globale ────────────────────────
                  if (state.error != null) ...[
                    _ErrorBanner(
                      message: state.error!,
                      onClose: () => ref.read(registerProvider.notifier).clearError(),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // ── Bouton ────────────────────────────────
                  PrimaryButton(
                    label:   'Créer mon compte',
                    loading: state.isLoading,
                    onTap:   _canSubmit && !state.isLoading ? _register : null,
                  ),
                  const SizedBox(height: 20),

                  // ── Lien connexion ────────────────────────
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'Déjà un compte ? ',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: _goLogin,
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                          color:      AppColors.red,
                          fontSize:   14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Validators ────────────────────────────────────────────

  String? Function(String?) _validateName(String fieldName) => (v) {
    if (v == null || v.trim().isEmpty) return '$fieldName requis';
    if (v.trim().length < 2)           return 'Min 2 caractères';
    if (v.trim().length > 50)          return 'Max 50 caractères';
    return null;
  };
}

// ─────────────────────────────────────────────────────────────
//  Widgets internes
// ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Row(children: [
    Text(text,
      style: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w600,
        color: AppColors.textSecondary, letterSpacing: .3,
      )),
    const SizedBox(width: 10),
    Expanded(child: Container(height: .5, color: AppColors.border)),
  ]);
}

// ── Champ mot de passe ────────────────────────────────────────

class _PasswordInput extends StatelessWidget {
  final TextEditingController      controller;
  final String                     label;
  final bool                       obscure;
  final VoidCallback               onToggle;
  final TextInputAction            textInputAction;
  final VoidCallback?              onFieldSubmitted;
  final String? Function(String?)? validator;

  const _PasswordInput({
    required this.controller,
    required this.label,
    required this.obscure,
    required this.onToggle,
    required this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary,
      )),
      const SizedBox(height: 8),
      TextFormField(
        controller:       controller,
        obscureText:      obscure,
        validator:        validator,
        textInputAction:  textInputAction,
        onFieldSubmitted: (_) => onFieldSubmitted?.call(),
        style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText:  '••••••••',
          hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
          prefixIcon: const Icon(Icons.lock_outline,
              color: AppColors.textSecondary, size: 20),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: AppColors.textSecondary, size: 20,
            ),
          ),
          filled:         true,
          fillColor:      AppColors.inputBg,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.refuse)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.refuse, width: 1.5)),
          errorStyle: const TextStyle(fontSize: 11.5, color: AppColors.refuse),
        ),
      ),
    ],
  );
}

// ── Indicateur de force du mot de passe ───────────────────────

class _PasswordStrengthBar extends StatelessWidget {
  final String password;
  const _PasswordStrengthBar({required this.password});

  int get _score {
    if (password.isEmpty) return 0;
    int s = 0;
    if (password.length >= 8)                       s++;
    if (password.length >= 12)                      s++;
    if (RegExp(r'[A-Z]').hasMatch(password))        s++;
    if (RegExp(r'[0-9]').hasMatch(password))        s++;
    if (RegExp(r'[!@#\$%^&*]').hasMatch(password))  s++;
    return s;
  }

  String get _label => switch (_score) {
    0 => '',
    1 => 'Très faible',
    2 => 'Faible',
    3 => 'Moyen',
    4 => 'Fort',
    _ => 'Très fort',
  };

  Color get _color => switch (_score) {
    0 || 1 => AppColors.refuse,
    2      => AppColors.enAttente,
    3      => Colors.amber,
    _      => AppColors.enCours,
  };

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox(height: 6);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: List.generate(5, (i) => Expanded(
          child: Container(
            height: 3,
            margin: const EdgeInsets.only(right: 3),
            decoration: BoxDecoration(
              color: i < _score ? _color : AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ))),
        const SizedBox(height: 4),
        if (_label.isNotEmpty)
          Text(_label,
            style: TextStyle(fontSize: 11, color: _color, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}

// ── Sélecteur de date ─────────────────────────────────────────

class _DatePickerField extends StatelessWidget {
  final String       label;
  final String       value;
  final bool         hasError;
  final VoidCallback onTap;

  const _DatePickerField({
    required this.label,
    required this.value,
    required this.hasError,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary,
      )),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: onTap,
        child: Container(
          width:   double.infinity,
          height:  54,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color:        AppColors.inputBg,
            borderRadius: BorderRadius.circular(12),
            border: hasError
                ? Border.all(color: AppColors.refuse)
                : Border.all(color: Colors.transparent),
          ),
          child: Row(children: [
            const Icon(Icons.calendar_today_outlined,
                color: AppColors.textSecondary, size: 18),
            const SizedBox(width: 12),
            Text(value,
              style: TextStyle(
                fontSize: 15,
                color: value == 'Sélectionner une date'
                    ? AppColors.textHint
                    : AppColors.textPrimary,
              )),
          ]),
        ),
      ),
    ],
  );
}

// ── Section consentement parental ─────────────────────────────

class _ParentalConsentSection extends StatelessWidget {
  final TextEditingController  parentEmailCtrl;
  final bool                   consentChecked;
  final ValueChanged<bool>     onConsentChanged;

  const _ParentalConsentSection({
    required this.parentEmailCtrl,
    required this.consentChecked,
    required this.onConsentChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding:    const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color:        AppColors.enAttente.withOpacity(.06),
      borderRadius: BorderRadius.circular(12),
      border:       Border.all(color: AppColors.enAttente.withOpacity(.3)),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        Icon(Icons.family_restroom_outlined, color: AppColors.enAttente, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text('Consentement parental requis',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                color: AppColors.enAttente)),
        ),
      ]),
      const SizedBox(height: 8),
      const Text(
        'Vous avez moins de 16 ans. Le consentement '
        'de votre parent ou tuteur légal est requis pour vous inscrire.',
        style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
      ),
      const SizedBox(height: 14),
      const Text('Email du parent / tuteur légal',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
            color: AppColors.textPrimary)),
      const SizedBox(height: 8),
      TextFormField(
        controller:   parentEmailCtrl,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
        validator: (v) {
          if (v == null || v.trim().isEmpty) return 'Email parent requis';
          if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim()))
            return 'Format d\'email invalide';
          return null;
        },
        decoration: InputDecoration(
          hintText:  'parent@exemple.com',
          hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
          prefixIcon: const Icon(Icons.email_outlined,
              color: AppColors.textSecondary, size: 20),
          filled:         true,
          fillColor:      AppColors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.red, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.refuse)),
          errorStyle: const TextStyle(fontSize: 11.5, color: AppColors.refuse),
        ),
      ),
      const SizedBox(height: 12),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 24, height: 24,
          child: Checkbox(
            value:       consentChecked,
            onChanged:   (v) => onConsentChanged(v ?? false),
            activeColor: AppColors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: const BorderSide(color: AppColors.border, width: 1.5),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Mes parents ou tuteur légal ont autorisé mon inscription sur Bx-Jeunes Impact.',
            style: TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4),
          ),
        ),
      ]),
    ]),
  );
}

// ── Checkbox légale avec lien ─────────────────────────────────

class _LegalCheckbox extends StatelessWidget {
  final bool               value;
  final ValueChanged<bool> onChanged;
  final String             text;
  final String             linkText;
  final VoidCallback       onLinkTap;
  final String? Function() validator;

  const _LegalCheckbox({
    required this.value,
    required this.onChanged,
    required this.text,
    required this.linkText,
    required this.onLinkTap,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final error = validator();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 24, height: 24,
          child: Checkbox(
            value:       value,
            onChanged:   (v) => onChanged(v ?? false),
            activeColor: AppColors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: BorderSide(
              color: error != null ? AppColors.refuse : AppColors.border,
              width: 1.5,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textPrimary, height: 1.4),
                children: [
                  TextSpan(text: text),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: onLinkTap,
                      child: Text(linkText,
                        style: const TextStyle(
                          fontSize:        13,
                          color:           AppColors.red,
                          fontWeight:      FontWeight.w600,
                          decoration:      TextDecoration.underline,
                          decorationColor: AppColors.red,
                        )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      if (!value && error != null)
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 34),
          child: Text(error,
            style: const TextStyle(fontSize: 11.5, color: AppColors.refuse)),
        ),
    ]);
  }
}

// ── Bannière d'erreur ─────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  final String       message;
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
      const Icon(Icons.error_outline, color: AppColors.refuse, size: 18),
      const SizedBox(width: 8),
      Expanded(
        child: Text(message,
            style: const TextStyle(fontSize: 13, color: AppColors.refuse)),
      ),
      GestureDetector(
        onTap: onClose,
        child: const Icon(Icons.close, color: AppColors.refuse, size: 16),
      ),
    ]),
  );
}
