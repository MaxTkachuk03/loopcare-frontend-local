enum RiverModuleItemAnimationState {
  no,
  unlock,
  idling,
  bounced,
  read,
  complete,
  reversCompletion;

  const RiverModuleItemAnimationState();

  bool get isNoAnimation => this == no;

  bool get isUnlock => this == unlock;

  bool get isIdling => this == idling;

  bool get isBounced => this == bounced;

  bool get isRead => this == read;

  bool get isCompleted => this == complete;

  bool get isReversCompletion => this == reversCompletion;
}
