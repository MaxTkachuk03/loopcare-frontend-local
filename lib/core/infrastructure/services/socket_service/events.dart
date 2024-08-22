class SocketEvents {
  SocketEvents._();

  static const String slotCancelled = 'SLOT_CANCELLED';
  static const String topicAvailable = 'TOPIC_AVAILABLE';
  static const String topicUnavailable = 'TOPIC_UNAVAILABLE';
  static const String newTopicAvailable = 'NEW_TOPIC_AVAILABLE';
  static const String topicSlotFinished = 'SLOT_FINISHED';
  static const String topicSlotStarted = 'SLOT_STARTED';
  static const String topicSlotStartedSoon = 'SLOT_STARTING_SOON';
  static const String error = 'ERROR';
  static const String buddyInvited = 'BUDDY_INVITED';
  static const String buddyRejectInvite = 'BUDDY_REJECTED_INVITE';
  static const String buddyLeft = 'BUDDY_LEFT';
  static const String buddyAcceptedInvite = 'BUDDY_ACCEPTED_INVITE';
}
