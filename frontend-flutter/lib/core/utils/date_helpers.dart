
/// Utilitaires de formatage de dates pour l'app Bx-Jeunes Impact.
/// Toutes les méthodes sont statiques — pas d'instanciation nécessaire.
abstract class DateHelpers {
  // Mois en français abrégés
  static const _months = [
    'jan', 'fév', 'mar', 'avr', 'mai', 'juin',
    'juil', 'août', 'sep', 'oct', 'nov', 'déc',
  ];

  static const _monthsFull = [
    'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
    'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
  ];

  /// "14 jan" — utilisé dans les cartes news
  static String formatShort(DateTime date) {
    return '${date.day} ${_months[date.month - 1]}';
  }

  /// "14 janvier 2025" — utilisé dans les détails
  static String formatLong(DateTime date) {
    return '${date.day} ${_monthsFull[date.month - 1]} ${date.year}';
  }

  /// "14 jan à 18h30" — utilisé dans les cartes activités
  static String formatDateTime(DateTime date) {
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '${date.day} ${_months[date.month - 1]} à ${h}h$m';
  }

  /// "Il y a 2 jours" / "Dans 3 jours" — relatif à aujourd'hui
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);
    final days = diff.inDays.abs();

    if (days == 0) return "Aujourd'hui";
    if (days == 1) return diff.isNegative ? 'Hier' : 'Demain';
    if (diff.isNegative) return 'Il y a $days jours';
    return 'Dans $days jours';
  }

  /// Retourne true si la date est dans le futur
  static bool isUpcoming(DateTime date) => date.isAfter(DateTime.now());

  /// "18:30"
  static String formatTime(DateTime date) {
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
