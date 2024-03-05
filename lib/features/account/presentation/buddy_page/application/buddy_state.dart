part of 'buddy_bloc.dart';

@freezed
class BuddyState with _$BuddyState {
  const factory BuddyState.initial(BuddyStateData data) = InitialBuddyState;

  const factory BuddyState.loading(BuddyStateData data) = LoadingBuddyState;

  const factory BuddyState.error(BuddyStateData data) = ErrorBuddyState;

  const factory BuddyState.noBuddy(BuddyStateData data) = NoBuddy;

  const factory BuddyState.stateQuestion(BuddyStateData data) = _BuddyStateQuestion;
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
    @Default(0) int currentStepProgress,
  }) = _BuddyStateData;

  String? get errorMessage => error?.maybeMap(conflict: (s) => s.error.error, orElse: () => null);
}
