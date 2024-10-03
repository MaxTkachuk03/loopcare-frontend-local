part of 'interactive_lessons_nav_bloc.dart';

@freezed
class InteractiveLessonsNavState with _$InteractiveLessonsNavState {
  const factory InteractiveLessonsNavState.initial(InteractiveLessonsNavStateData data) =
      InteractiveLessonsNavStateInitial;

  const factory InteractiveLessonsNavState.setPage(InteractiveLessonsNavStateData data) =
      InteractiveLessonsNavStateSetPage;

  const factory InteractiveLessonsNavState.setChunk(InteractiveLessonsNavStateData data) =
      InteractiveLessonsNavStateSetChunk;

  const factory InteractiveLessonsNavState.setUnlockedChunks(InteractiveLessonsNavStateData data) =
      InteractiveLessonsNavStateSetUnlockedChunks;
}

@freezed
class InteractiveLessonsNavStateData with _$InteractiveLessonsNavStateData {
  const InteractiveLessonsNavStateData._();

  const factory InteractiveLessonsNavStateData({
    @Default([]) List<InteractiveLessonTopicsPage> pages,
    @Default(null) InteractiveLessonTopicsPage? activePage,
    @Default(null) InteractiveLessonChunk? activeChunk,
    @Default({}) Map<int, List<InteractiveLessonChunk>> unlockedChunksByPage,
    @Default(0) int activePageIndex,
    @Default(0) int activeChunkIndex,
  }) = _InteractiveLessonsNavStateData;

  bool get isAllChunksUnlocked => false;

  bool get isLastPage => activePageIndex + 1 == pages.length;

  List<InteractiveLessonChunk> get activePageUnlockedChunks =>
      unlockedChunksByPage[activePage?.id ?? 0] ?? [];

  factory InteractiveLessonsNavStateData.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonsNavStateDataFromJson(json);
}
