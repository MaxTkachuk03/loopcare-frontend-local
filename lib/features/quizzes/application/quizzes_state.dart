part of 'quizzes_bloc.dart';

@freezed
class QuizzesState with _$QuizzesState {
  const factory QuizzesState.initial(QuizzesStateData data) = QuizzesStateInitial;

  const factory QuizzesState.loading(QuizzesStateData data) = QuizzesStateLoading;

  const factory QuizzesState.updated(QuizzesStateData data) = QuizzesStateUpdated;

  const factory QuizzesState.error(QuizzesStateData data) = QuizzesStateError;
}

@freezed
class QuizzesStateData with _$QuizzesStateData {
  const QuizzesStateData._();

  const factory QuizzesStateData({
    @Default(0) int currentStep,
    @Default([]) List<LessonQuestion> quizzes,
    @Default(false) bool isLoading,
    @Default(null) RequestError? error,
  }) = _QuizzesStateData;

  String? get errorMessage => error?.maybeMap(
        badRequest: (s) => s.error.message,
        notFound: (s) => s.error.message,
        orElse: () => null,
      );

  LessonQuestion get qustionForCurrentStep => quizzes.get(currentStep);

  LessonQuestion questionForStep(int step) => quizzes.get(step);
}
