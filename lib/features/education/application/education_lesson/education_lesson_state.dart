part of 'education_lesson_bloc.dart';

@freezed
class EducationLessonState with _$EducationLessonState {
  const factory EducationLessonState.initial(EducationLessonData data) =
      Initial;

  const factory EducationLessonState.loading(EducationLessonData data) =
      Loading;

  const factory EducationLessonState.contentLoaded(EducationLessonData data) =
      ContentLoaded;

  const factory EducationLessonState.audioContent(EducationLessonData data) =
      AudioContent;

  const factory EducationLessonState.textContent(EducationLessonData data) =
      TextContent;

  const factory EducationLessonState.lessonCompleted(EducationLessonData data) =
      LessonCompleted;

  const factory EducationLessonState.errorCompleteLesson(
      EducationLessonData data) = ErrorCompleteLesson;

  const factory EducationLessonState.errorGettingLessons(
      EducationLessonData data) = ErrorGettingLessons;
}

@freezed
class EducationLessonData with _$EducationLessonData {
  const EducationLessonData._();

  const factory EducationLessonData({
    @Default([]) List<LessonPage> pages,
    @Default(0) int lessonId,
    @Default(null) DateTime? lessonCompletedDate,
    @Default('') String lessonCategory,
    @Default(0) int lessonDuration,
    @Default('') String lessonImage,
    @Default('') String lessonTitle,
    @Default(false) bool isLoading,
    @Default(0) int currentPageIndex,
    RequestError? error,
  }) = _EducationLessonData;

  LessonPage get currentPage {
    return pages[currentPageIndex];
  }

  bool get isLastPage => currentPageIndex == pages.length - 1;

  bool get isFirstPage => currentPageIndex == 0;
}
