// Modèle Dart aligné sur l'entité News.java.
//
// Représente une actualité affichée dans le carousel de la page d'accueil du dashboard.
// Utilisé par GET /api/news pour récupérer les actualités à afficher.

class News {
  final int id;
  final String title;
  final String content;
  final String? imageUrl;
  final bool pinned;
  final int? authorId;
  final String? authorName;
  final DateTime createdAt;
 
  const News({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.pinned = false,
    this.authorId,
    this.authorName,
    required this.createdAt,
  });
 
  /// Extrait un résumé court pour l'affichage dans le carousel (≤ 120 chars).
  String get excerpt {
    if (content.length <= 120) return content;
    return '${content.substring(0, 117)}…';
  }
 
  factory News.fromJson(Map<String, dynamic> json) => News(
    id:         json['id'] as int,
    title:      json['title'] as String,
    content:    json['content'] as String,
    imageUrl:   json['imageUrl'] as String?,
    pinned:     json['pinned'] as bool? ?? false,
    authorId:   json['authorId'] as int?,
    authorName: json['authorName'] as String?,
    createdAt:  DateTime.parse(json['createdAt'] as String),
  );
 
  Map<String, dynamic> toJson() => {
    'id':         id,
    'title':      title,
    'content':    content,
    'imageUrl':   imageUrl,
    'pinned':     pinned,
    'authorId':   authorId,
    'authorName': authorName,
    'createdAt':  createdAt.toIso8601String(),
  };
}
 