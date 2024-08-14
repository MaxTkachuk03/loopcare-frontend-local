enum RiverModuleState {
  locked,
  inProgress,
  completed;

  bool get isLocked => this == locked;

  bool get isInProgress => this == inProgress;

  bool get isCompleted => this == completed;
}
