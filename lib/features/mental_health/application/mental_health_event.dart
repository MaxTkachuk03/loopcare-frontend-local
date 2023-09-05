part of 'mental_health_bloc.dart';

@freezed
class MentalHealthEvent with _$MentalHealthEvent {
  const factory MentalHealthEvent.getMentalHealthTests() = _GetMentalHealthTests;

  const factory MentalHealthEvent.nextTest() = _NextTest;

  const factory MentalHealthEvent.prevTest() = _PrevTest;

  const factory MentalHealthEvent.prevQuestion() = _PrevQuestion;

  const factory MentalHealthEvent.nextQuestion() = _NextQuestion;

  const factory MentalHealthEvent.nextPage() = _NextPage;

  const factory MentalHealthEvent.setAnswer(MentalHealthAnswer answer) = _SetAnswer;

  const factory MentalHealthEvent.getTestResults() = _GetTestResults;

  const factory MentalHealthEvent.setCompleted(bool value) = _SetCompleted;

  const factory MentalHealthEvent.setStartTime(DateTime time) = _SetStartTime;

  const factory MentalHealthEvent.startTestFromBeginning() = _StartTestFromBeginning;

  const factory MentalHealthEvent.resetData() = _ResetData;
}
