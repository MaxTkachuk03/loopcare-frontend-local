part of 'education_lesson_bloc.dart';

@freezed
class EducationLessonEvent with _$EducationLessonEvent {
  const factory EducationLessonEvent.getLessonContent({required int lessonId}) = GetLessonContent;

  const factory EducationLessonEvent.answerQuizQuestion({
    required int questionOptionId,
    required int questionId,
  }) = AnswerQuizQuestion;

  const factory EducationLessonEvent.nextPage() = NextPage;

  const factory EducationLessonEvent.prevPage() = PrevPage;

  const factory EducationLessonEvent.progressForward() = ProgressForward;

  const factory EducationLessonEvent.progressBack() = ProgressBack;

  const factory EducationLessonEvent.completeLesson() = CompleteLesson;

  const factory EducationLessonEvent.downloadAudioFile(String url) = DownloadAudioFile;

  const factory EducationLessonEvent.downloadSubtitlesFile(String url) = DownloadSubtitlesFile;

  const factory EducationLessonEvent.init() = Init;
}
