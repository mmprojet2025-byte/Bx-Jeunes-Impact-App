abstract class Validators {
  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email requis';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim()))
      return 'Format d\'email invalide';
    return null;
  }
 
  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Mot de passe requis';
    if (v.length < 8) return 'Au moins 8 caractères';
    return null;
  }
 
  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return 'Confirmation requise';
    if (v != original) return 'Les mots de passe ne correspondent pas';
    return null;
  }
 
  static String? required(String? v, {String label = 'Ce champ'}) {
    if (v == null || v.trim().isEmpty) return '$label est requis';
    return null;
  }
 
  static String? minLength(String? v, int min, {String label = 'Ce champ'}) {
    if (v == null || v.trim().length < min)
      return '$label doit contenir au moins $min caractères';
    return null;
  }
 
  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return null; // optional
    if (!RegExp(r'^\+?[0-9\s\-]{7,15}$').hasMatch(v.trim()))
      return 'Numéro de téléphone invalide';
    return null;
  }
}
