import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topics_page.dart';

part 'interactive_lessons_nav_event.dart';
part 'interactive_lessons_nav_state.dart';
part 'interactive_lessons_nav_bloc.freezed.dart';

@singleton
class InteractiveLessonsNavBloc
    extends Bloc<InteractiveLessonsNavEvent, InteractiveLessonsNavState> {
  InteractiveLessonsNavBloc()
      : super(const InteractiveLessonsNavState.initial(InteractiveLessonsNavStateData())) {
    on<SetInitial>(_onSetInitial);
    on<SetNextPage>(_onSetNextPage);
    on<SetPrevPage>(_onSetPrevPage);
    on<UpdateUnlockedChunks>(_onUpdateUnlockedChunks);
  }

  Future<void> _onSetInitial(
    SetInitial event,
    Emitter<InteractiveLessonsNavState> emit,
  ) async {
    final firstPage = event.pages.first;

    emit(InteractiveLessonsNavState.setPage(state.data.copyWith(
      pages: event.pages,
      activePage: firstPage,
      activePageIndex: 0,
      activeChunkIndex: 0,
      unlockedChunksByPage: _updateUnlockedChunks(firstPage.id, firstPage.chunks.first),
    )));
  }

  Future<void> _onSetNextPage(
    SetNextPage event,
    Emitter<InteractiveLessonsNavState> emit,
  ) async {
    final nextPageIndex = state.data.activePageIndex + 1;
    if (nextPageIndex >= state.data.pages.length) return;

    final nextPage = state.data.pages[nextPageIndex];
    emit(InteractiveLessonsNavState.setPage(state.data.copyWith(
      activePage: nextPage,
      activePageIndex: nextPageIndex,
      activeChunkIndex: 0,
      unlockedChunksByPage: _updateUnlockedChunks(nextPage.id, nextPage.chunks.first),
    )));
  }

  Future<void> _onSetPrevPage(
    SetPrevPage event,
    Emitter<InteractiveLessonsNavState> emit,
  ) async {
    final prevPageIndex = state.data.activePageIndex - 1;
    if (prevPageIndex < 0) return;

    final prevPage = state.data.pages[prevPageIndex];

    emit(InteractiveLessonsNavState.setPage(state.data.copyWith(
      activePage: prevPage,
      activePageIndex: prevPageIndex,
      activeChunkIndex: prevPage.chunks.length - 1,
    )));
  }

  Future<void> _onUpdateUnlockedChunks(
    UpdateUnlockedChunks event,
    Emitter<InteractiveLessonsNavState> emit,
  ) async {
    final pageId = state.data.activePage?.id ?? 0;
    final nextChunkIndex = state.data.activeChunkIndex + 1;

    if (nextChunkIndex >= (state.data.activePage?.chunks.length ?? 0)) return;

    final nextChunk = state.data.activePage?.chunks[nextChunkIndex];

    emit(InteractiveLessonsNavState.setUnlockedChunks(state.data.copyWith(
      unlockedChunksByPage: _updateUnlockedChunks(pageId, nextChunk!),
    )));
  }

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
