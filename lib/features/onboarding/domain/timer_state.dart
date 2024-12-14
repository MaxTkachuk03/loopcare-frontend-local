enum TimerState {
  active,
  completed,
  empty,
}

extension TimerStateExtension on TimerState {
  bool get isCompleted => this == TimerState.completed;

  bool get isActive => this == TimerState.active;
}
