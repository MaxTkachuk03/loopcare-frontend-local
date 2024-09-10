part of 'mental_questions_bloc.dart';

@freezed
class MentalQuestionsState with _$MentalQuestionsState {
  const MentalQuestionsState._();

  const factory MentalQuestionsState({
    @Default([]) List<MentalHealthAnswer> answers,
    @Default({}) Map<MentalHealthTestType, TestResult> results,
    @Default(false) bool isLoading,
    @Default(false) bool isCompleted,
    @Default(false) bool isFailed,
    // ignore: invalid_annotation_target
    @JsonKey(includeFromJson: false, includeToJson: false) RequestError? error,
    DateTime? startTestTime,
  }) = _MentalQuestionsState;

  factory MentalQuestionsState.initial() => const MentalQuestionsState();

  factory MentalQuestionsState.fromJson(Map<String, dynamic> json) =>
      _$MentalQuestionsStateFromJson(json);

  bool get isPhq8TestHigh =>
      results[MentalHealthTestType.phq8]?.interpretation == InterpretationType.high;

  bool showEmergencyBtn(MentalHealthTestType type) {
    if (type == MentalHealthTestType.who5) return false;

    final testResult = results[type];

    return testResult?.interpretation == InterpretationType.high;
  }

  MentalHealthTestAnswer get registrationData => MentalHealthTestAnswer(answers: answers);
}
