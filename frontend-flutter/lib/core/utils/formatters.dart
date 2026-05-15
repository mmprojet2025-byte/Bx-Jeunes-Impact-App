abstract class Formatters {
  /// "Jean Dupont" → "JD"
  static String initials(String firstName, String lastName) {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty  ? lastName[0].toUpperCase()  : '';
    return '$f$l';
  }
 
  /// "jean dupont" → "Jean Dupont"
  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return s.split(' ')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');
  }
 
  /// 1200 → "1.2k"
  static String compactNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
 
  /// Truncate long text with ellipsis
  static String truncate(String s, int maxLength) {
    if (s.length <= maxLength) return s;
    return '${s.substring(0, maxLength)}…';
  }
}
