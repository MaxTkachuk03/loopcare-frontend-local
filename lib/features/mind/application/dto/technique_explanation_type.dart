enum TechniqueExplanationType {
  text,
  video,
  rating;

  const TechniqueExplanationType();

  bool get isVideo => this == video;
}
