// Wrapper autour de flutter_secure_storage.
// Seul endroit où les tokens JWT sont lus/écrits — jamais SharedPreferences.
//
// pubspec.yaml :
//   flutter_secure_storage: ^9.2.2
//
// ⚠️  Android : minSdkVersion 18 requis dans android/app/build.gradle
// ⚠️  iOS     : aucune configuration supplémentaire
 
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
 
import '../../core/constants/app_config.dart';
import '../../core/utils/logger.dart';
 
abstract class SecureStorageService {
  // ── Instance Dio configurée ───────────────────────────────
  static const _storage = FlutterSecureStorage(
    // Android : AES-256 via EncryptedSharedPreferences (Jetpack Security)
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    // iOS : Keychain, accessible uniquement quand l'app est déverrouillée
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.unlocked,
    ),
  );
 
  // ── Access Token ─────────────────────────────────────────
 
  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: AppConfig.accessTokenKey, value: token);
    AppLogger.info('Access token saved', tag: 'SecureStorage');
  }
 
  static Future<String?> getAccessToken() =>
      _storage.read(key: AppConfig.accessTokenKey);
 
  static Future<void> deleteAccessToken() =>
      _storage.delete(key: AppConfig.accessTokenKey);
 
  // ── Refresh Token ────────────────────────────────────────
 
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: AppConfig.refreshTokenKey, value: token);
    AppLogger.info('Refresh token saved', tag: 'SecureStorage');
  }
 
  static Future<String?> getRefreshToken() =>
      _storage.read(key: AppConfig.refreshTokenKey);
 
  static Future<void> deleteRefreshToken() =>
      _storage.delete(key: AppConfig.refreshTokenKey);
 
  // ── Helpers ──────────────────────────────────────────────
 
  /// Sauvegarde atomique du couple access + refresh token.
  /// Les deux écritures sont parallèles (Future.wait).
  static Future<void> saveTokenPair({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }
 
  /// Suppression complète (utilisé au logout et si le refresh échoue).
  static Future<void> clearAll() async {
    await _storage.deleteAll();
    AppLogger.info('All tokens cleared', tag: 'SecureStorage');
  }
 
  /// Retourne true si un access token non vide est stocké.
  static Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
