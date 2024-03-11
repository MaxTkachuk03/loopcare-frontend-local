part of 'buddy_bloc.dart';

@freezed
class BuddyState with _$BuddyState {
  const factory BuddyState.initial(BuddyStateData data) = InitialBuddyState;

  const factory BuddyState.loading(BuddyStateData data) = LoadingBuddyState;

  const factory BuddyState.error(BuddyStateData data) = ErrorBuddyState;

  const factory BuddyState.noBuddy(BuddyStateData data) = NoBuddy;

  const factory BuddyState.stateQuestion(BuddyStateData data) = _BuddyStateQuestion;

  const factory BuddyState.sentBuddyInvitation(BuddyStateData data) = SentBuddyInvitation;

  const factory BuddyState.gotBuddy(BuddyStateData data) = _GotBuddyState;

  const factory BuddyState.removedBuddy(BuddyStateData data) = _RemovedBuddy;

  const factory BuddyState.resentInvitation(BuddyStateData data) = _ResentInvitation;
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
    Buddy? buddy,
    @Default(0) int currentStepProgress,
  }) = _BuddyStateData;

  String? get errorMessage => error?.maybeMap(conflict: (s) => s.error.error, orElse: () => null);

  bool get gotAllNecessaryData => liveTogether != null && relation != null && email != null;

  bool get isInvitationApproved => buddy?.state == BuddyStatus.approved.name;

  bool get isInvitationRejected => buddy?.state == BuddyStatus.rejected.name;

  bool get isBuddyNotAvailable => buddy?.state == BuddyStatus.left.name;

  bool get isInvitationPending => buddy?.state == BuddyStatus.invited.name;

  bool get navigateInviteAnotherBuddy => buddy != null && (isBuddyNotAvailable || isInvitationRejected);

  bool get showInviteAnotherBuddy => buddy != null;
}
