part of 'buddy_bloc.dart';

@freezed
class BuddyState with _$BuddyState {
  const factory BuddyState.initial(BuddyStateData data) = BuddyStateInitial;

  const factory BuddyState.loading(BuddyStateData data) = BuddyStateLoading;

  const factory BuddyState.error(BuddyStateData data) = BuddyStateError;

  const factory BuddyState.stateQuestion(BuddyStateData data) = BuddyStateQuestion;

  const factory BuddyState.gotBuddy(BuddyStateData data) = BuddyStateGotBuddy;
}

@freezed
class BuddyStateData with _$BuddyStateData {
  const BuddyStateData._();

  const factory BuddyStateData({
    @Default(BuddyQuestions.liveTogether) BuddyQuestions currentQuestion,
    RequestError? error,
    @Default(false) bool isLoading,
    bool? liveTogether,
    String? email,
    String? relation,
    BuddyStatus? buddyState,
    Buddy? buddy,
    @Default(0) int currentStepProgress,
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
