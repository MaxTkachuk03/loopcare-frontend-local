part of 'interactive_lessons_bloc.dart';

@freezed
class InteractiveLessonsState with _$InteractiveLessonsState {
  const factory InteractiveLessonsState.initial(InteractiveLessonsStateData data) =
      InteractiveLessonsStateInitial;

  const factory InteractiveLessonsState.loading(InteractiveLessonsStateData data) =
      InteractiveLessonsStateLoading;

  const factory InteractiveLessonsState.error(InteractiveLessonsStateData data) =
      InteractiveLessonsStateError;

  const factory InteractiveLessonsState.lessonLoaded(InteractiveLessonsStateData data) =
      InteractiveLessonsStateLessonLoaded;

  const factory InteractiveLessonsState.setPage(InteractiveLessonsStateData data) =
      InteractiveLessonsStateSetPage;

  const factory InteractiveLessonsState.setChunk(InteractiveLessonsStateData data) =
      InteractiveLessonsStateSetChunk;

  const factory InteractiveLessonsState.setUnlockedChunks(InteractiveLessonsStateData data) =
      InteractiveLessonsStateSetUnlockedChunks;
}

@freezed
class InteractiveLessonsStateData with _$InteractiveLessonsStateData {
  const InteractiveLessonsStateData._();

  const factory InteractiveLessonsStateData({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String jumpBoardTitle,
    @Default('') String jumpBoardDescription,
    @Default('') String conclusion,
    @Default('') String unlockTitle,
    @Default('') String unlockDescription,
    @Default({}) Map<int, InteractiveLessonTopic> topics,
    @Default({}) Map<int, InteractiveLessonTopicsPage> pages,
    @Default({}) Map<int, InteractiveLessonChunk> chunks,
    @Default({}) Map<int, InteractiveLessonChunkComponent> components,
    @Default(null) InteractiveLessonTopicsPage? activePage,
    @Default(null) InteractiveLessonChunk? activeChunk,
    @Default(0) int activePageIndex,
    @Default(0) int activeChunkIndex,
    @Default({}) Map<int, List<InteractiveLessonChunk>> unlockedChunksByPage,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _InteractiveLessonsStateData;

  List<InteractiveLessonChunk> getPagesUnlockedChunks(int pageId) =>
      unlockedChunksByPage[pageId] ?? [];

  bool hasUnlockedChunks(int pageId) => getPagesUnlockedChunks(pageId).isNotEmpty;
}
