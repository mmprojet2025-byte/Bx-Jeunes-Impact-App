abstract class DateHelpers {
  /// "25 MAI 2024"
  static String formatFull(DateTime d) {
    const months = [
      '', 'JAN', 'FÉV', 'MAR', 'AVR', 'MAI', 'JUIN',
      'JUL', 'AOÛ', 'SEP', 'OCT', 'NOV', 'DÉC',
    ];
    return '${d.day} ${months[d.month]} ${d.year}';
  }
 
  /// "25 MAI"
  static String formatShort(DateTime d) {
    const months = [
      '', 'JAN', 'FÉV', 'MAR', 'AVR', 'MAI', 'JUIN',
      'JUL', 'AOÛ', 'SEP', 'OCT', 'NOV', 'DÉC',
    ];
    return '${d.day} ${months[d.month]}';
  }
 
  /// Day number "25"
  static String day(DateTime d) => d.day.toString();
 
  /// Month abbreviation "MAI"
  static String monthAbbr(DateTime d) {
    const months = [
      '', 'JAN', 'FÉV', 'MAR', 'AVR', 'MAI', 'JUIN',
      'JUL', 'AOÛ', 'SEP', 'OCT', 'NOV', 'DÉC',
    ];
    return months[d.month];
  }
 
  /// "25 Mai 2024 • 14:00"
  static String formatDateTime(DateTime d) {
    const months = [
      '', 'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc',
    ];
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '${d.day} ${months[d.month]} ${d.year} • $h:$m';
  }
 
  /// "il y a 2 heures" / "il y a 3 jours"
  static String timeAgo(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'à l\'instant';
    if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'il y a ${diff.inHours} h';
    if (diff.inDays < 7) return 'il y a ${diff.inDays} j';
    return formatShort(d);
  }
 
  static bool isUpcoming(DateTime d) => d.isAfter(DateTime.now());
  static bool isPast(DateTime d) => d.isBefore(DateTime.now());
}
