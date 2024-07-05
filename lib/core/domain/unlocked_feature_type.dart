enum UnlockedFeatureType {
  allowGroupSessions,
  assignments,
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
  calorieTracker;

  bool get isGrouping => this == grouping;
}
