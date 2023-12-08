part of 'assignments_bloc.dart';

@freezed
class AssignmentsState with _$AssignmentsState {
  const factory AssignmentsState.initial(AssignmentsStateData data) = AssignmentsStateInitial;

  const factory AssignmentsState.loading(AssignmentsStateData data) = AssignmentsStateLoading;

  const factory AssignmentsState.updated(AssignmentsStateData data) = AssignmentsStateUpdated;

  const factory AssignmentsState.error(AssignmentsStateData data) = AssignmentsStateError;
}

@freezed
class AssignmentsStateData with _$AssignmentsStateData {
  const AssignmentsStateData._();

  const factory AssignmentsStateData({
    @Default(0) int lessonId,
    @Default([]) List<LessonQuestion> questions,
    @Default(false) bool isLoading,
    @Default(null) RequestError? error,
  }) = _AssignmentsStateData;

  String? get errorMessage => error?.maybeMap(
        badRequest: (s) => s.error.message,
        notFound: (s) => s.error.message,
        orElse: () => null,
      );

  LessonQuestion questionForStep(int step) => questions.get(step);

  List<LessonQuestion> questionsForCurrentWeek(DateTime selectedDay) {
    return questions
        .where(
          (element) =>
              element.createdAt?.inRange(
                selectedDay.firstDayOfCurrentWeek.subtract(const Duration(days: 7)),
                selectedDay.lastDayOfCurrentWeek,
              ) ??
              false,
        )
        .toList();
  }
}
