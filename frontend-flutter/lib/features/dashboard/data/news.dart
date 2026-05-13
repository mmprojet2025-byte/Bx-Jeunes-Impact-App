// Miroir de News.java.
// Les news sont créées par les admins/référents et affichées sur l'accueil.
// Les news avec pinned=true apparaissent dans le carousel épinglé.
//
// Note : le champ `pinned` n'existe pas encore dans News.java —
// il est anticipé ici pour GET /api/news?pinned=true (UML révisé).
 
import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'news.freezed.dart';
part 'news.g.dart';
 
@freezed
class News with _$News {
  const News._();
 
  const factory News({
    required int id,
 
    /// Titre (max 200 chars côté backend)
    required String title,
 
    /// Contenu complet de la news (TEXT côté backend)
    required String content,
 
    /// Auteur (null si supprimé)
    int? authorId,
    String? authorName,
 
    /// URL image optionnelle (anticipation V2)
    String? imageUrl,
 
    /// News épinglée sur l'écran d'accueil (max 2 simultanément)
    @Default(false) bool pinned,
 
    DateTime? createdAt,
 
    @Default(true) bool active,
  }) = _News;
 
  factory News.fromJson(Map<String, dynamic> json) =>
      _$NewsFromJson(json);
 
  // ── Computed ─────────────────────────────────────────────
 
  /// Extrait un court résumé (≤ 120 chars) pour le carousel
  String get excerpt {
    if (content.length <= 120) return content;
    // Coupe au dernier espace avant 120 pour ne pas couper un mot
    final truncated = content.substring(0, 120);
    final lastSpace = truncated.lastIndexOf(' ');
    return '${truncated.substring(0, lastSpace > 0 ? lastSpace : 120)}…';
  }
 
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;
}
 
// ── NewsCreateRequest ─────────────────────────────────────────
 
@freezed
class NewsCreateRequest with _$NewsCreateRequest {
  const factory NewsCreateRequest({
    required String title,
    required String content,
    String? imageUrl,
    @Default(false) bool pinned,
  }) = _NewsCreateRequest;
 
  factory NewsCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$NewsCreateRequestFromJson(json);
}
 