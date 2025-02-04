part of 'commitment_bloc.dart';

@freezed
class CommitmentState with _$CommitmentState {
  const factory CommitmentState.initial(CommitmentStateData data) = CommitmentStateInitial;

  const factory CommitmentState.loading(CommitmentStateData data) = CommitmentStateLoading;

  const factory CommitmentState.commitmentLoaded(CommitmentStateData data) = CommitmentStateLoaded;

  const factory CommitmentState.error(CommitmentStateData data) = CommitmentStateError;
}

@freezed
class CommitmentStateData with _$CommitmentStateData {
  const CommitmentStateData._();

  const factory CommitmentStateData({
    @Default(false) bool isLoading,
    RequestError? error,
    @Default(0) int completedCommitments,
    @Default(0) int totalCommitments,
    @Default(false) bool isCommitmentUnlocked,
    @Default(true) bool showCommitmentWidget,
  }) = _CommitmentStateData;
}
