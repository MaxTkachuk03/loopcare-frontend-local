enum UnlockedFeatureType {
  allowGroupSessions,
  reflections,
  foodLogging,
  calorieDensity,
  smartGoals,
  weightLogging,
  physicalActivity,
  buddy,
  grouping,
  proteinDegree,
  mind,
  fiberIndicator,
  calorieTracker,
  moodLogging;

  bool get isGrouping => this == grouping;
}
