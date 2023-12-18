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

  List<LessonQuestion> pastQuestions(DateTime selectedDay) {
    return questions
        .where(
          (element) =>
              element.openedAt?.inRange(
                selectedDay,
                DateTime.now().subtract(const Duration(days: 7)),
              ) ??
              false,
        )
        .toList();
  }

  List<LessonQuestion> questionsForCurrentWeek(DateTime selectedDay) {
    return questions
        .where(
          (element) =>
              element.openedAt?.inRange(
                selectedDay.firstDayOfCurrentWeek.subtract(const Duration(days: 7)),
                selectedDay.lastDayOfCurrentWeek,
              ) ??
              false,
        )
        .toList();
  }

  List<LessonQuestion> openedQuestionsForCurrentWeek(DateTime selectedDay) {
    return questions
        .where(
          (element) =>
              (element.openedAt?.inRange(
                    selectedDay.firstDayOfCurrentWeek.subtract(const Duration(days: 7)),
                    selectedDay.lastDayOfCurrentWeek,
                  ) ??
                  false) &&
              element.questionAnswer == null,
        )
        .toList();
  }

  List<LessonQuestion> doneTodayQuestions(DateTime selectedDay) {
    return questions
        .where(
          (element) => element.answeredAt?.isSameDate(selectedDay) ?? false,
        )
        .toList();
  }

  List<LessonQuestion> uniqueLessonsQuestions(
    List<LessonQuestion> data,
  ) {
    List<LessonQuestion> retList = [];
    List<int> lessonsList = [];

    for (var element in data) {
      if (lessonsList.contains(element.lessonId)) continue;

      lessonsList.add(element.lessonId);
      retList.add(element);
    }

    return retList;
  }
}
