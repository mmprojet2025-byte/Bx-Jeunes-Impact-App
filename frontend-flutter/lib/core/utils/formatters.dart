abstract class Formatters {
  static String initials(String fn, String ln) =>
      r'${fn.isNotEmpty ? fn[0].toUpperCase() : ""}${ln.isNotEmpty ? ln[0].toUpperCase() : ""}';
  static String capitalize(String s) => s.isEmpty ? s :
      s.split(' ').map((w) => w.isEmpty ? w : r'${w[0].toUpperCase()}${w.substring(1).toLowerCase()}').join(' ');
  static String compactNumber(int n) => n >= 1000 ? r'${(n/1000).toStringAsFixed(1)}k' : r'$n';
  static String truncate(String s, int max) => s.length <= max ? s : r'${s.substring(0,max)}…';
}
