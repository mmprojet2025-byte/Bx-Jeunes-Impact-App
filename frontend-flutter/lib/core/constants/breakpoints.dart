/// Centralized responsive breakpoints for the mobile and tablet app.
///
/// The app targets phones and tablets only: roughly 375px to 1024px wide.
abstract final class Breakpoints {
  /// Widths below this value are treated as phones.
  static const double phoneMax = 599.0;

  /// Widths equal to or above this value are treated as tablets.
  static const double tablet = 600.0;

  /// Intended minimum supported phone width.
  static const double minSupportedWidth = 375.0;

  /// Intended maximum supported tablet width.
  static const double maxSupportedWidth = 1024.0;
}
