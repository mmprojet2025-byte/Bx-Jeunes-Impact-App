// Wrapper générique pour les réponses paginées Spring Boot.
//
// Format JSON Spring Page<T> :
// {
//   "content": [...],
//   "totalElements": 42,
//   "totalPages": 3,
//   "number": 0,          ← numéro de page (0-indexed)
//   "size": 20,
//   "first": true,
//   "last": false,
//   "empty": false
// }
//
// Usage dans un repository :
//   final page = await _api.get<PaginatedResponse<Activity>>(
//     AppConfig.activitiesEndpoint,
//     fromJson: (json) => PaginatedResponse.fromJson(
//       json as Map<String, dynamic>,
//       (item) => Activity.fromJson(item as Map<String, dynamic>),
//     ),
//   );
//   final activities = page.content;  // List<Activity>
//   final hasMore    = page.hasMore;  // bool
 
// Note : freezed ne supporte pas les classes génériques de manière native.
// On utilise json_serializable manuellement + une classe manuelle immutable.
 
 
class PaginatedResponse<T> {
  final List<T> content;
  final int totalElements;
  final int totalPages;
 
  /// Numéro de page actuel (0-indexed côté Spring)
  final int number;
  final int size;
  final bool first;
  final bool last;
  final bool empty;
 
  const PaginatedResponse({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.number,
    required this.size,
    required this.first,
    required this.last,
    required this.empty,
  });
 
  // ── Helpers ───────────────────────────────────────────────
 
  /// Page courante (1-indexed pour l'affichage)
  int get currentPage => number + 1;
 
  bool get hasMore    => !last;
  bool get hasPrev    => !first;
  bool get isEmpty    => empty;
  bool get isNotEmpty => !empty;
 
  // ── Serialization ─────────────────────────────────────────
 
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) {
    final rawContent = json['content'] as List<dynamic>? ?? [];
    return PaginatedResponse<T>(
      content:       rawContent.map(fromJsonT).toList(),
      totalElements: json['totalElements'] as int? ?? 0,
      totalPages:    json['totalPages']    as int? ?? 1,
      number:        json['number']        as int? ?? 0,
      size:          json['size']          as int? ?? 20,
      first:         json['first']         as bool? ?? true,
      last:          json['last']          as bool? ?? true,
      empty:         json['empty']         as bool? ?? true,
    );
  }
 
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) => {
        'content':       content.map(toJsonT).toList(),
        'totalElements': totalElements,
        'totalPages':    totalPages,
        'number':        number,
        'size':          size,
        'first':         first,
        'last':          last,
        'empty':         empty,
      };
 
  /// Crée une réponse vide (utile pour les tests et les états initiaux)
 static PaginatedResponse<T> createEmpty<T>() => PaginatedResponse<T>(
        content:       [],
        totalElements: 0,
        totalPages:    0,
        number:        0,
        size:          20,
        first:         true,
        last:          true,
        empty:         true,
      );
 
  /// Fusionne plusieurs pages (utile pour l'infinite scroll)
  PaginatedResponse<T> appendPage(PaginatedResponse<T> nextPage) =>
      PaginatedResponse<T>(
        content:       [...content, ...nextPage.content],
        totalElements: nextPage.totalElements,
        totalPages:    nextPage.totalPages,
        number:        nextPage.number,
        size:          nextPage.size,
        first:         first,
        last:          nextPage.last,
        empty:         false,
      );
}

 