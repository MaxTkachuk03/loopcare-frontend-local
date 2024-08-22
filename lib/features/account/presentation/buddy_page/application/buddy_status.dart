enum BuddyStatus {
  invited,
  rejected,
  approved,
  left,
}

extension BuddyStatusExtension on BuddyStatus? {
  bool get isRejectedOrLeft => this != null
      && this != BuddyStatus.invited
      && this != BuddyStatus.approved;
}
