import 'package:flutter/foundation.dart';
 
abstract class AppLogger {
  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      debugPrint('[INFO]${tag != null ? ' [$tag]' : ''} $message');
    }
  }
 
  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      debugPrint('[WARN]${tag != null ? ' [$tag]' : ''} $message');
    }
  }
 
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    if (kDebugMode) {
      debugPrint('[ERROR]${tag != null ? ' [$tag]' : ''} $message');
      if (error != null) debugPrint('  cause: $error');
      if (stackTrace != null) debugPrint('  stack: $stackTrace');
    }
  }
}
 