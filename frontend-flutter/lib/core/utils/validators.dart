abstract class Validators {
  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email requis';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim())) return 'Format invalide';
    return null;
  }
  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Mot de passe requis';
    if (v.length < 8)           return 'Au moins 8 caractères';
    if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Au moins 1 majuscule';
    if (!RegExp(r'[0-9]').hasMatch(v)) return 'Au moins 1 chiffre';
    return null;
  }
  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return 'Confirmation requise';
    if (v != original)          return 'Les mots de passe ne correspondent pas';
    return null;
  }
  static String? required(String? v, {String label = 'Ce champ'}) {
    if (v == null || v.trim().isEmpty) return '$label est requis';
    return null;
  }
}
