part of 'commitment_bloc.dart';

@freezed
class CommitmentEvent with _$CommitmentEvent {
  const factory CommitmentEvent.getCommitment({required DateTime date}) = GetCommitment;
}
