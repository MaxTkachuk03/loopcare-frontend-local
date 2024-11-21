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

  const factory InteractiveLessonsState.saveAnswer(InteractiveLessonsStateData data) =
      InteractiveLessonsStateSaveAnswer;
}

@freezed
class InteractiveLessonsStateData with _$InteractiveLessonsStateData {
  const InteractiveLessonsStateData._();

  const factory InteractiveLessonsStateData({
    @Default(0) int id,
    @Default('') String type,
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
    @Default([]) List<InteractiveLessonChunkComponent> unlockedChunkComponents,
    @Default(0) int activePageIndex,
    @Default(0) int activeChunkIndex,
    @Default({}) Map<int, List<InteractiveLessonChunk>> unlockedChunksByPage,
    @Default(false) bool isLoading,
    @Default(false) bool allTextAreasAdded,
    RequestError? error,
  }) = _InteractiveLessonsStateData;

  List<InteractiveLessonChunk> getPagesUnlockedChunks(int pageId) =>
      unlockedChunksByPage[pageId] ?? [];

  bool get isAllComponentChecked {
    final componentsWithProgress = unlockedChunkComponents.where((c) {
      if (c is InteractiveLessonChunkComponentTextArea) {
        return allTextAreasAdded;
      }

      return c.progress != null;
    });

    final quizComponents = unlockedChunkComponents.where((c) =>
        c.type != InteractiveLessonComponentType.image &&
        c.type != InteractiveLessonComponentType.markdown);

    return componentsWithProgress.length == quizComponents.length;
  }

  List<InteractiveLessonChunk> get activePageUnlockedChunks =>
      unlockedChunksByPage[activePage?.id ?? 0] ?? [];

  InteractiveLessonChunk getActiveChunk(InteractiveLessonTopicsPage page) => chunks.values
      .where((chunk) => chunk.id == page.chunksIds.first && chunk.pageId == page.id)
      .first;

  bool get isAllChunksUnlocked =>
      getPagesUnlockedChunks(activePage?.id ?? 0).length ==
      chunks.values.where((chunk) => chunk.pageId == (activePage?.id ?? 0)).length;

  bool get isLastPage => activePageIndex + 1 == pages.length;

  bool hasUnlockedChunks(int pageId) => getPagesUnlockedChunks(pageId).isNotEmpty;

  List<InteractiveLessonChunkComponent> getChunkComponents(InteractiveLessonChunk chunk) {
    final componentsChunk = components.values
        .where((component) =>
            component.chunkId == chunk.id && chunk.componentsIds.contains(component.id))
        .toList();

    return componentsChunk;
  }
}
