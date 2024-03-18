part of 'education_lesson_bloc.dart';

@freezed
class EducationLessonState with _$EducationLessonState {
  const factory EducationLessonState.initial(EducationLessonData data) = Initial;

  const factory EducationLessonState.loading(EducationLessonData data) = Loading;

  const factory EducationLessonState.contentIsLoading(EducationLessonData data) = ContentIsLoading;

  const factory EducationLessonState.errorGettingContent(EducationLessonData data) = ErrorGettingContent;

  const factory EducationLessonState.contentLoaded(EducationLessonData data) = ContentLoaded;

  const factory EducationLessonState.lessonCompleted(EducationLessonData data) = LessonCompleted;

  const factory EducationLessonState.errorCompleteLesson(EducationLessonData data) = ErrorCompleteLesson;
}

@freezed
class EducationLessonData with _$EducationLessonData {
  const EducationLessonData._();

  const factory EducationLessonData({
    @Default('') String temporaryDirectory,
    @Default([]) List<LessonPage> pages,
    @Default(0) int totalPagesLength,
    @Default(0) int lessonId,
    ExtraActionTypes? extraAction,
    @Default(null) DateTime? lessonCompletedDate,
    @Default('') String lessonCategory,
    @Default(0) int lessonDuration,
    @Default('') String lessonImage,
    @Default('') String lessonTitle,
    @Default(false) bool isLoading,
    @Default(false) bool isAudioLoading,
    @Default(false) bool isSubtitleLoading,
    @Default(0) int lessonProgress,
    @Default(0) int currentProgressPageIndex,
    @Default(0) int currentPageIndex,
    @Default({}) Map<String, Set<AudioLessonContentType>> audioFilesCache,
    RequestError? error,
    @Default([]) List<LessonQuestion> questions,
  }) = _EducationLessonData;

  LessonPage get currentPage => pages[currentPageIndex];

  bool get isArticlePage => currentPage.type == EducationLessonPageType.text;

  bool get isAudioPage => currentPage.type == EducationLessonPageType.audio;

  String filePath(String url) {
    var urlArr = url.split('/');
    return "$temporaryDirectory/${urlArr[urlArr.length - 2]}/${urlArr.last}";
  }

  bool get isAudioAlreadyInCache {
    final cacheVal = audioFilesCache[lessonId.toString()];

    return cacheVal != null ? cacheVal.contains(AudioLessonContentType.audio) : false;
  }

  bool get isSubtitlesAlreadyInCache {
    final cacheVal = audioFilesCache[lessonId.toString()];

    return cacheVal != null ? cacheVal.contains(AudioLessonContentType.subtitles) : false;
  }

  bool get isLessonCompleted => lessonCompletedDate != null;

  bool get isLastPage => currentPageIndex == pages.length - 1;

  bool get isFirstPage => currentPageIndex == 0;

  bool get hasQuiz => questions.first.type == LessonQuestionType.quiz;

  String? get errorMessage => error?.maybeMap(conflict: (s) => s.error.message, orElse: () => null);

  List<LessonQuestion> get assignmentsQuestions =>
      questions.where((element) => element.type == LessonQuestionType.assignment).toList();

  List<LessonQuestion> get assignmentsQuestionsWithAnswers =>
      assignmentsQuestions.where((element) => element.lessonQuestionAnswers.isNotEmpty).toList();
}
