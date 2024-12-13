import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topics_page.dart';

part 'interactive_lessons_nav_bloc.freezed.dart';
part 'interactive_lessons_nav_bloc.g.dart';
part 'interactive_lessons_nav_event.dart';
part 'interactive_lessons_nav_state.dart';

@singleton
class InteractiveLessonsNavBloc
    extends HydratedBloc<InteractiveLessonsNavEvent, InteractiveLessonsNavState> {
  InteractiveLessonsNavBloc()
      : super(const InteractiveLessonsNavState.initial(InteractiveLessonsNavStateData())) {
    on<SetInitial>(_onSetInitial);
    on<SetNextPage>(_onSetNextPage);
    on<SetPrevPage>(_onSetPrevPage);
    on<UnlockNextChunk>(_onUnlockNextChunk);
  }

  @override
  InteractiveLessonsNavState? fromJson(Map<String, dynamic> json) =>
      InteractiveLessonsNavState.initial(InteractiveLessonsNavStateData.fromJson(json));

  @override
  Map<String, dynamic>? toJson(InteractiveLessonsNavState state) => state.data.toJson();

  Future<void> _onSetInitial(
    SetInitial event,
    Emitter<InteractiveLessonsNavState> emit,
  ) async {
    final firstPage = event.pages.first;

    final unlockedChunks = state.data.unlockedChunksByPage[firstPage.id] ?? [];
    final hasUnlockedChunks = unlockedChunks.isNotEmpty;

    emit(InteractiveLessonsNavState.setPage(state.data.copyWith(
      pages: event.pages,
      activePage: firstPage,
      activePageIndex: 0,
      activeChunkIndex: hasUnlockedChunks ? unlockedChunks.length - 1 : 0,
      // unlockedChunksByPage: hasUnlockedChunks
      //     ? state.data.unlockedChunksByPage
      //     : _updateUnlockedChunks(firstPage.id, firstPage.chunks.first),
    )));
  }

  Future<void> _onSetNextPage(
    SetNextPage event,
    Emitter<InteractiveLessonsNavState> emit,
  ) async {
    final nextPageIndex = state.data.activePageIndex + 1;
    if (nextPageIndex >= state.data.pages.length) return;

    final nextPage = state.data.pages[nextPageIndex];

    final unlockedChunks = state.data.unlockedChunksByPage[nextPage.id] ?? [];
    final hasUnlockedChunks = unlockedChunks.isNotEmpty;

    emit(InteractiveLessonsNavState.setPage(state.data.copyWith(
      activePage: nextPage,
      activePageIndex: nextPageIndex,
      activeChunkIndex: hasUnlockedChunks ? unlockedChunks.length - 1 : 0,
      // activeChunk: hasUnlockedChunks ? unlockedChunks.last : nextPage.chunks.first,
      // unlockedChunksByPage: hasUnlockedChunks
      //     ? state.data.unlockedChunksByPage
      //     : _updateUnlockedChunks(nextPage.id, nextPage.chunks.first),
    )));
  }

  Future<void> _onSetPrevPage(
    SetPrevPage event,
    Emitter<InteractiveLessonsNavState> emit,
  ) async {
    final prevPageIndex = state.data.activePageIndex - 1;
    if (prevPageIndex < 0 || prevPageIndex >= state.data.pages.length) return;

    final prevPage = state.data.pages[prevPageIndex];

    emit(InteractiveLessonsNavState.setPage(state.data.copyWith(
      activePage: prevPage,
      activePageIndex: prevPageIndex,
      // activeChunk: prevPage.chunks.last,
      // activeChunkIndex: prevPage.chunks.length - 1,
    )));
  }

  Future<void> _onUnlockNextChunk(
    UnlockNextChunk event,
    Emitter<InteractiveLessonsNavState> emit,
  ) async {
    final activePage = state.data.activePage;

    final nextChunkIndex = state.data.activeChunkIndex + 1;

    if (activePage == null || nextChunkIndex >= activePage.chunksIds.length) return;

    // final nextChunk = activePage.chunksIds[nextChunkIndex];

    emit(InteractiveLessonsNavState.setUnlockedChunks(state.data.copyWith(
      // activeChunk: nextChunk,
      activeChunkIndex: nextChunkIndex,
      // unlockedChunksByPage: _updateUnlockedChunks(activePage.id, nextChunk),
    )));
  }

  // ignore: unused_element
  Map<int, List<InteractiveLessonChunk>> _updateUnlockedChunks(
    int pageId,
    InteractiveLessonChunk chunk,
  ) {
    final unlockedChunks = state.data.unlockedChunksByPage[pageId] ?? [];
    if (unlockedChunks.contains(chunk)) return state.data.unlockedChunksByPage;

    return {
      ...state.data.unlockedChunksByPage,
      pageId: [...unlockedChunks, chunk],
    };
  }
}
