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

  List<LessonQuestion> questionsForLesson(int lessonId) {
    return questions
        .where(
          (element) => element.lessonId == lessonId,
        )
        .toList();
  }

  LessonQuestion questionForStep(int lessonId, int step) => questionsForLesson(lessonId).get(step);

  List<LessonQuestion> pastAssignments(DateTime date) {
    final List<LessonQuestion> assignments = [];
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));

    for (var v in questionsByLessonId.values) {
      if (v.every((e) => e.isCompleted || e.isInDateRange(date, weekAgo))) {
        assignments.add(v.first);
      }
    }

    return assignments;
  }

  bool hasQuestionsForCurrentWeek(DateTime selectedDay) => questions.any((e) =>
      (!e.isCompleted || DateUtils.isSameDay(e.answeredAt, selectedDay)) &&
          (e.openedAt?.inRange(selectedDay.firstDayOfPreviousWeek, selectedDay.lastDayOfCurrentWeek) ?? false));

  Map<int, List<LessonQuestion>> get questionsByLessonId {
    final Map<int, List<LessonQuestion>> questionsByLessonId = {};

    for (var element in questions) {
      if (questionsByLessonId[element.lessonId] == null) {
        questionsByLessonId[element.lessonId] = [element];
      } else {
        questionsByLessonId[element.lessonId]?.add(element);
      }
    }

    return questionsByLessonId;
  }

  List<LessonQuestion> currentWeekAssignments(DateTime selectedDay) {
    final List<LessonQuestion> assignments = [];

    for (var v in questionsByLessonId.values) {
      if (v.every(
              (e) => e.isInDateRange(selectedDay.firstDayOfPreviousWeek, selectedDay.lastDayOfCurrentWeek)) &&
          v.any((e) => !e.isCompleted)) {
        assignments.add(v.first);
      }
    }

    return assignments;
  }

  List<LessonQuestion> todayDoneAssignments(DateTime selectedDay) {
    final List<LessonQuestion> assignments = [];

    for (var v in questionsByLessonId.values) {
      if (v.every((e) => e.isCompletedOnSelectedDate(selectedDay))) {
        assignments.add(v.first);
      }
    }

    return assignments;
  }
}
