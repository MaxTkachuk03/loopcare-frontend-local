enum TechniqueExplanationType {
  // rating,
  text,
  video;

  const TechniqueExplanationType();

  bool get isVideo => this == video;
}
