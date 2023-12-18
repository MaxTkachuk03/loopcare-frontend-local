part of 'quizzes_bloc.dart';

@freezed
class QuizzesEvent with _$QuizzesEvent {
  const factory QuizzesEvent.getLessonQuizzes(int lessonId) = GetLessonQuizzes;

  const factory QuizzesEvent.saveLessonAnswer(
    int lessonQuestionId, {
    List<int>? lessonQuestionOptionIds,
  }) = SaveLessonAnswer;
}
