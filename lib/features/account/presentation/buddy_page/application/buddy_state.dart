part of 'buddy_bloc.dart';

@freezed
class BuddyState with _$BuddyState {
  const factory BuddyState.initial(BuddyStateData data) = BuddyStateInitial;

  const factory BuddyState.loading(BuddyStateData data) = BuddyStateLoading;

  const factory BuddyState.error(BuddyStateData data) = BuddyStateError;

  const factory BuddyState.stateQuestion(BuddyStateData data) = BuddyStateQuestion;

  const factory BuddyState.gotBuddy(BuddyStateData data) = BuddyStateGotBuddy;

  const factory BuddyState.invited(BuddyStateData data) = BuddyStateInvited;

  const factory BuddyState.approved(BuddyStateData data) = BuddyStateApproved;

  const factory BuddyState.rejected(BuddyStateData data) = BuddyStateRejected;

  const factory BuddyState.left(BuddyStateData data) = BuddyStateLeft;
}

@freezed
class BuddyStateData with _$BuddyStateData {
  const BuddyStateData._();

  const factory BuddyStateData({
    BuddyStatus? buddyState,
    Buddy? buddy,
    bool? liveTogether,
    String? email,
    String? relation,
    RequestError? error,
    @Default(false) bool isLoading,
  }) = _BuddyStateData;

  String get errorMessage => error?.message ?? LocalizedTexts.errorSomethingWentWrong;

  bool get gotAllNecessaryData => liveTogether != null && relation != null && email != null;

  bool get isInvitationApproved => buddyState == BuddyStatus.approved;

  bool get isInvitationRejected => buddyState == BuddyStatus.rejected;

  bool get isBuddyNotAvailable => buddyState == BuddyStatus.left;

  bool get isInvitationPending => buddyState == BuddyStatus.invited;

  bool get canInviteOtherBuddy => isBuddyNotAvailable || isInvitationRejected;

  bool get hasBuddyState => buddyState != null;
}
