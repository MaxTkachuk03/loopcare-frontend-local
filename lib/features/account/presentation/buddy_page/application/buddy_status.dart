enum BuddyStatus {
  invited,
  rejected,
  approved,
  left,
}

BuddyStatus fromBuddyStatusString(String format) {
  switch (format) {
    case 'left':
      return BuddyStatus.left;
    case 'rejected':
      return BuddyStatus.rejected;
    case 'approved':
      return BuddyStatus.approved;

    default:
      return BuddyStatus.invited;
  }
}
