part of 'assignments_bloc.dart';

@freezed
class AssignmentsEvent with _$AssignmentsEvent {
  const factory AssignmentsEvent.getLessonQuestions(int lessonId) = GetLessonQuestions;

  const factory AssignmentsEvent.setCurrentStep(int step) = SetCurrentStep;

  const factory AssignmentsEvent.saveLessonAnswerText(
    int lessonQuestionId, {
    String? text,
  }) = SaveLessonAnswerText;

  const factory AssignmentsEvent.updateLessonAnswerText(
    int lessonQuestionId, {
    String? text,
  }) = UpdateLessonAnswerText;

  const factory AssignmentsEvent.saveLessonAnswerOption(
    int lessonQuestionId, {
    List<int>? lessonQuestionOptionIds,
  }) = SaveLessonAnswerOption;

  const factory AssignmentsEvent.updateLessonAnswerOption(
    int lessonQuestionId, {
    List<int>? lessonQuestionOptionIds,
  }) = UpdateLessonAnswerOption;
}
