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
    @Default(0) int activePageIndex,
    @Default(0) int activeChunkIndex,
    @Default({}) Map<int, List<InteractiveLessonChunk>> unlockedChunksByPage,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _InteractiveLessonsStateData;

  List<InteractiveLessonChunk> getPagesUnlockedChunks(int pageId) =>
      unlockedChunksByPage[pageId] ?? [];

  bool get isAllCheckedPerChunk {
    if (activePage != null) {
      // final activeChunk = getActiveChunk(activePage);
      print('activeChunk,${activeChunk}');
      final List<InteractiveLessonChunkComponent> activeChunks = [];
      for (var component in components.values) {
        if (component.chunkId == activeChunk!.id && component.isValid) {
          activeChunks.add(component);
        }
      }
      return activeChunks.length == activeChunk!.componentsIds.length;
    }

    return false;
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
          InteractiveLessonChunk chunk) =>
      components.values
          .where((component) =>
              component.chunkId == chunk.id &&
              chunk.componentsIds.contains(component.id))
          .toList();

  //blocState.;
}
