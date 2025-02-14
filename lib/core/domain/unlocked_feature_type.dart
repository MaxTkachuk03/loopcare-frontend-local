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
  moodLogging,
  stepCounter,
  commitment;

  bool get isGrouping => this == grouping;
}
