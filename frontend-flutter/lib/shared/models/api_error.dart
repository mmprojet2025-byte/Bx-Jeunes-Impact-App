import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'api_error.freezed.dart';
part 'api_error.g.dart';
 
// ── FieldError (inner record du backend) ─────────────────────
 
@freezed
class FieldError with _$FieldError {
  const factory FieldError({
    required String field,
    required String message,
  }) = _FieldError;
 
  factory FieldError.fromJson(Map<String, dynamic> json) =>
      _$FieldErrorFromJson(json);
}
 
// ── ApiError ──────────────────────────────────────────────────
 
@freezed
class ApiError with _$ApiError implements Exception {
  const ApiError._();
 
  const factory ApiError({
    /// Code HTTP (400, 401, 403, 404, 409, 422, 500…)
    required int status, /// Timestamp ISO-8601 de l'erreur
    DateTime? timestamp,
 
    /// Libellé HTTP ("Not Found", "Unauthorized"…)
    String? error,
 
    /// Code métier applicatif ("RESOURCE_NOT_FOUND", "VALIDATION_ERROR"…)
    String? code,
 
    /// Message lisible par l'utilisateur
    @Default('Une erreur est survenue') String message,
 
    /// Path de la requête ayant échoué
    String? path,
 
    /// Erreurs de validation par champ (présentes uniquement sur 400/422)
    @Default(<FieldError>[]) List<FieldError> fieldErrors,
  }) = _ApiError;
 
  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
 
  // ── Helpers ───────────────────────────────────────────────
 
  bool get isUnauthorized   => status == 401;
  bool get isForbidden      => status == 403;
  bool get isNotFound       => status == 404;
  bool get isConflict       => status == 409;
  bool get isValidationError => status == 400 || status == 422;
  bool get isServerError    => status >= 500;
  bool get isNetworkError   => status == 0;
 
  bool get hasFieldErrors => fieldErrors.isNotEmpty;
 
  /// Retourne le message d'erreur du premier champ donné (utile pour les formulaires)
  String? fieldMessage(String field) =>
      fieldErrors.where((e) => e.field == field).firstOrNull?.message;
 
  /// Construit une ApiError minimale depuis un code HTTP sans body parsé
  factory ApiError.fromStatusCode(int statusCode, {String? path}) {
    final message = switch (statusCode) {
      400 => 'Requête invalide.',
      401 => 'Session expirée. Reconnectez-vous.',
      403 => 'Accès refusé.',
      404 => 'Ressource introuvable.',
      409 => 'Conflit — la ressource existe déjà.',
      422 => 'Données invalides.',
      500 => 'Erreur serveur. Réessayez plus tard.',
      _   => 'Erreur inattendue ($statusCode).',
    };
    return ApiError(status: statusCode, message: message, path: path);
  }
 
  factory ApiError.network() => const ApiError(
        status: 0,
        message: 'Impossible de joindre le serveur. Vérifiez votre connexion.',
      );
 
  @override
  String toString() => 'ApiError($status): $message';
}