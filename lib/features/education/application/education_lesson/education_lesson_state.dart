part of 'education_lesson_bloc.dart';

@freezed
class EducationLessonState with _$EducationLessonState {
  const factory EducationLessonState.initial(EducationLessonData data) = Initial;

  const factory EducationLessonState.loading(EducationLessonData data) = Loading;

  const factory EducationLessonState.contentIsLoading(EducationLessonData data) = ContentIsLoading;

  const factory EducationLessonState.errorGettingContent(EducationLessonData data) =
      ErrorGettingContent;

  const factory EducationLessonState.contentLoaded(EducationLessonData data) = ContentLoaded;

  const factory EducationLessonState.lessonCompleted(EducationLessonData data) = LessonCompleted;

  const factory EducationLessonState.errorCompleteLesson(EducationLessonData data) =
      ErrorCompleteLesson;
}

@freezed
class EducationLessonData with _$EducationLessonData {
  const EducationLessonData._();

  const factory EducationLessonData({
    @Default(0) int id,
    @Default('') String title,
    @Default(0) int duration,
    @Default(LessonContentType.text) LessonContentType contentType,
    @Default('') String imageUrl,
    @Default('') String cardImageUrl,
    @Default('') String audioUrl,
    @Default('') String htmlUrl,
    @Default(null) String? subtitleImages,
    @Default(null) Quiz? quiz,
    @Default('') String conclusion,
    @Default('') String unlockTitle,
    @Default('') String unlockDescription,
    @Default('') String temporaryDirectory,
    ExtraActionTypes? extraAction,
    @Default(0) int progress,
    @Default({}) Map<String, Set<AudioLessonContentType>> audioFilesCache,
    @Default('') String audioFilePath,
    @Default('') String subtitleFilePath,
    @Default(false) bool isAudioLoading,
    @Default(false) bool isSubtitleLoading,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _EducationLessonData;

  bool get isArticlePage => contentType.name == LessonContentType.text.name;

  bool get isAudioPage => contentType.name == LessonContentType.audio.name;

  bool get isAudioLoaded => audioFilePath.isNotEmpty;

  bool get isBuddyUnlocked => extraAction == ExtraActionTypes.unlockBuddy;

  bool get isFoodLoggingUnlocked => extraAction == ExtraActionTypes.unlockFoodLogging;

  bool get isPhysicalActivitiesUnlocked => extraAction == ExtraActionTypes.unlockPhysicalActivities;

  bool get isAssignmentsUnlocked => extraAction == ExtraActionTypes.unlockAssignments;

  bool get isGroupPreferencesUnlocked => extraAction == ExtraActionTypes.setupGroupingPreferences;

  bool get isLessonCompleted => true; //lessonCompletedDate != null;

  String get quizInstruction => quiz?.instruction ?? '';

  int get quizQuestionsAmount => quiz?.questions.length ?? 0;

  bool get isAudioAlreadyInCache {
    final cacheVal = audioFilesCache[id.toString()];

    return cacheVal != null ? cacheVal.contains(AudioLessonContentType.audio) : false;
  }

  bool get isSubtitlesAlreadyInCache {
    final cacheVal = audioFilesCache[id.toString()];

    return cacheVal != null ? cacheVal.contains(AudioLessonContentType.subtitles) : false;
  }

  bool get hasQuiz => quiz != null;

  String? get errorMessage => error?.message;

  String filePath(String url) {
    var urlArr = url.split('/');
    return "$temporaryDirectory/$id/${urlArr.last}";
  }

  // List<LessonQuestion> get assignmentsQuestions =>
  //     questions.where((element) => element.type == LessonQuestionType.assignment).toList();
  //
  // List<LessonQuestion> get assignmentsQuestionsWithAnswers =>
  //     assignmentsQuestions.where((element) => element.lessonQuestionAnswers.isNotEmpty).toList();
}
