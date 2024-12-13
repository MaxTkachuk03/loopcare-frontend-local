part of 'buddy_bloc.dart';

@freezed
class BuddyEvent with _$BuddyEvent {
  const factory BuddyEvent.liveTogether({required bool liveTogether}) = BuddyLiveTogether;

  const factory BuddyEvent.relation({required String relation}) = BuddyRelation;

  const factory BuddyEvent.email({required String email}) = BuddyEmail;

  const factory BuddyEvent.inviteBuddy() = InviteBuddy;

  const factory BuddyEvent.removeBuddy() = RemoveBuddy;

  const factory BuddyEvent.resendInvitation() = ResendInvitation;

  const factory BuddyEvent.removeInvitation() = RemoveInvitation;

  const factory BuddyEvent.updateBuddyState(Account? data) = UpdateBuddyState;

  const factory BuddyEvent.updateBuddyStatus(BuddyStatus? status) = UpdateBuddyStatus;
}
