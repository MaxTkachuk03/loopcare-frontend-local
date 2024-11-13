part of 'interactive_lessons_bloc.dart';

@freezed
class InteractiveLessonsState with _$InteractiveLessonsState {
  const factory InteractiveLessonsState.initial(
      InteractiveLessonsStateData data) = InteractiveLessonsStateInitial;

  const factory InteractiveLessonsState.loading(
      InteractiveLessonsStateData data) = InteractiveLessonsStateLoading;

  const factory InteractiveLessonsState.error(
      InteractiveLessonsStateData data) = InteractiveLessonsStateError;

  const factory InteractiveLessonsState.lessonLoaded(
      InteractiveLessonsStateData data) = InteractiveLessonsStateLessonLoaded;

  const factory InteractiveLessonsState.setPage(
      InteractiveLessonsStateData data) = InteractiveLessonsStateSetPage;

  const factory InteractiveLessonsState.setChunk(
      InteractiveLessonsStateData data) = InteractiveLessonsStateSetChunk;

  const factory InteractiveLessonsState.setUnlockedChunks(
          InteractiveLessonsStateData data) =
      InteractiveLessonsStateSetUnlockedChunks;

  const factory InteractiveLessonsState.toggleComponentClicked(
          InteractiveLessonsStateData data) =
      InteractiveLessonsStateToggleComponentClicked;

  const factory InteractiveLessonsState.saveAnswer(
      InteractiveLessonsStateData data) =
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
    @Default([]) List<InteractiveLessonProgress> progress,
    RequestError? error,
  }) = _InteractiveLessonsStateData;

  List<InteractiveLessonChunk> getPagesUnlockedChunks(int pageId) =>
      unlockedChunksByPage[pageId] ?? [];

  bool get isAllCheckedPerChunk {
    final List<InteractiveLessonChunkComponent> activeChunks = [];
    for (var component in unlockedChunkComponents) {
      if (component.chunkId == activeChunk!.id && component.isValid) {
        activeChunks.add(component);
      }
    }
    return activeChunks.length == activeChunk!.componentsIds.length;
  }

  List<InteractiveLessonChunk> get activePageUnlockedChunks =>
      unlockedChunksByPage[activePage?.id ?? 0] ?? [];

  InteractiveLessonChunk getActiveChunk(InteractiveLessonTopicsPage page) =>
      chunks.values
          .where((chunk) =>
              chunk.id == page.chunksIds.first && chunk.pageId == page.id)
          .first;

  bool get isAllChunksUnlocked =>
      getPagesUnlockedChunks(activePage?.id ?? 0).length ==
      chunks.values
          .where((chunk) => chunk.pageId == (activePage?.id ?? 0))
          .length;

  bool get isLastPage => activePageIndex + 1 == pages.length;

  bool hasUnlockedChunks(int pageId) =>
      getPagesUnlockedChunks(pageId).isNotEmpty;

  List<InteractiveLessonChunkComponent> getChunkComponents(
      InteractiveLessonChunk chunk) {
    final componentsChunk = components.values
        .where((component) =>
            component.chunkId == chunk.id &&
            chunk.componentsIds.contains(component.id))
        .toList();

    return componentsChunk;
  }

  Answers? getAnswers(InteractiveLessonChunkComponent component) {
    final matchingProgress = progress.where(
          (c) => c.chunkId == component.chunkId && c.componentId == component.id,
    ).toList();

    if (matchingProgress.isEmpty) {
      return null; // Or handle this case as needed
    }

    return matchingProgress.first.answers;
  }
  //blocState.;
}
