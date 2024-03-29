part of 'mental_questions_bloc.dart';

@freezed
class MentalQuestionsEvent with _$MentalQuestionsEvent {

  const factory MentalQuestionsEvent.setAnswer({
    required MentalHealthAnswer answer,
    required String testName,
    required String question,
    required String selectedOption,
  }) = _SetAnswer;

  const factory MentalQuestionsEvent.getTestResults({
    required MentalHealthTest test,
    @Default(false) bool isCompleted,
  }) = _GetTestResults;

  const factory MentalQuestionsEvent.startTestFromBeginning() = _StartTestFromBeginning;

  const factory MentalQuestionsEvent.resetData() = _ResetData;
}
