part of 'mental_health_bloc.dart';

@freezed
class MentalHealthState with _$MentalHealthState {
  const MentalHealthState._();

  factory MentalHealthState.initial() => const MentalHealthState(data: MentalHealthData());

  const factory MentalHealthState({
    required MentalHealthData data,
  }) = _MentalHealthState;

  factory MentalHealthState.fromJson(Map<String, dynamic> json) => _$MentalHealthStateFromJson(json);
}

@freezed
class MentalHealthData with _$MentalHealthData {
  const MentalHealthData._();

  const factory MentalHealthData({
    @Default([]) List<MentalHealthTest> tests,
    @Default([]) List<int> questionsListId,
    @Default(0) int totalQuestionsLength,
    @Default(0) int currentTestIndex,
    @Default(0) int currentPage,
    @Default(0) int currentQuestionIndex,
    @Default([]) List<MentalHealthAnswer> answers,
    @Default({}) Map<MentalHealthTestType, TestResult> results,
    @Default(false) bool isLoading,
    @Default(false) bool isCompleted,
    @JsonKey(ignore: true) RequestError? error,
    DateTime? startTestTime,
  }) = _MentalHealthData;

  factory MentalHealthData.fromJson(Map<String, dynamic> json) => _$MentalHealthDataFromJson(json);

  MentalHealthTest? get currentTest {
    if (tests.isEmpty) return null;
    return tests[currentTestIndex];
  }

  MentalHealthQuestion? get currentQuestion {
    return currentTest?.questions[currentQuestionIndex];
  }

  bool get isLastQuestion {
    return currentQuestionIndex + 1 == currentTest?.questions.length;
  }

  bool get isFirstQuestion {
    return currentQuestionIndex == 0;
  }

  bool get isLastTest {
    return currentTestIndex + 1 == tests.length;
  }

  bool get isFirstTest {
    return currentTestIndex == 0;
  }

  int get progressPercentage {
    final currentQuestionId = currentQuestion?.id;

    if (currentQuestionId == null) return 0;

    final index = questionsListId.indexOf(currentQuestionId) + 1;
    return (index * 100) ~/ totalQuestionsLength;
  }
}
