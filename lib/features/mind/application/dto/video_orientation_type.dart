enum VideoOrientationType {
  /// Taller than wide.
  portrait,

  /// Wider than tall.
  landscape;

  bool get isPortrait => this == portrait;
}
