part of 'education_lesson_bloc.dart';

@freezed
class EducationLessonEvent with _$EducationLessonEvent {
  const factory EducationLessonEvent.getLessonContent({
    required int lessonId,
    required int pageIndex,
  }) = GetLessonContent;

  const factory EducationLessonEvent.nextPage() = NextPage;

  const factory EducationLessonEvent.prevPage() = PrevPage;

  const factory EducationLessonEvent.progressForward() = ProgressForward;

  const factory EducationLessonEvent.progressBack() = ProgressBack;

  const factory EducationLessonEvent.completeLesson() = CompleteLesson;

  const factory EducationLessonEvent.downloadAudioFile(String url) = DownloadAudioFile;

  const factory EducationLessonEvent.downloadSubtitlesFile(String url) = DownloadSubtitlesFile;

  const factory EducationLessonEvent.init() = Init;
}
