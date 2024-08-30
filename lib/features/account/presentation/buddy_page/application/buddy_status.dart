enum BuddyStatus {
  invited,
  rejected,
  approved,
  left,
}

extension BuddyStatusExtension on BuddyStatus? {
  bool get isInvited => this == BuddyStatus.invited;

  bool get isRejected => this == BuddyStatus.rejected;

  bool get isApproved => this == BuddyStatus.approved;

  bool get isLeft => this == BuddyStatus.left;

  bool get isRejectedOrLeft => this != null
      && this != BuddyStatus.invited
      && this != BuddyStatus.approved;
}
