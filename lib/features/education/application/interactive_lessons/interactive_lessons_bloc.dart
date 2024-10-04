import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topic.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topics_page.dart';

part 'interactive_lessons_event.dart';
part 'interactive_lessons_state.dart';
part 'interactive_lessons_bloc.freezed.dart';

@singleton
class InteractiveLessonsBloc extends Bloc<InteractiveLessonsEvent, InteractiveLessonsState> {
  final EducationService _educationService;

  InteractiveLessonsBloc(this._educationService)
      : super(const InteractiveLessonsState.initial(InteractiveLessonsStateData())) {
    on<GetInteractiveLesson>(_onGetInteractiveLesson);
    on<SetNextPage>(_onSetNextPage);
    on<SetPrevPage>(_onSetPrevPage);
    on<UnlockNextChunk>(_onUnlockNextChunk);
  }

  Future<void> _onGetInteractiveLesson(
    GetInteractiveLesson event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    emit(InteractiveLessonsState.loading(state.data.copyWith(isLoading: true)));

    // TODO: Delete after dev phase
    await Future.delayed(const Duration(milliseconds: 500));

    final response = await _educationService.getInteractiveLesson(event.lessonId);

    response.fold(
      (l) => emit(InteractiveLessonsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        final activePage = r.pages[r.topics.values.first.pagesIds.first];
        if (activePage == null) return;

        final activeChunk = r.chunks[activePage.chunksIds.first];
        if (activeChunk == null) return;

        final activePageUnlockedChunks = state.data.getPagesUnlockedChunks(activePage.id);
        final hasUnlockedChunks = activePageUnlockedChunks.isNotEmpty;
        final unlockedChunksByPage = hasUnlockedChunks
            ? state.data.unlockedChunksByPage
            : _updateUnlockedChunks(activePage.id, activeChunk);

        emit(InteractiveLessonsState.lessonLoaded(state.data.copyWith(
          id: r.id,
          title: r.title,
          jumpBoardTitle: r.jumpBoardTitle,
          jumpBoardDescription: r.jumpBoardDescription,
          conclusion: r.conclusion,
          unlockTitle: r.unlockTitle,
          unlockDescription: r.unlockDescription,
          topics: r.topics,
          pages: r.pages,
          chunks: r.chunks,
          components: r.components,
          activePage: activePage,
          activeChunk: activeChunk,
          activePageIndex: 0,
          activeChunkIndex: hasUnlockedChunks ? activePageUnlockedChunks.length - 1 : 0,
          unlockedChunksByPage: unlockedChunksByPage,
          isLoading: false,
        )));
      },
    );
  }

  Future<void> _onSetNextPage(
    SetNextPage event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    final nextPageIndex = state.data.activePageIndex + 1;
    if (nextPageIndex >= state.data.pages.length) return;

    final topic = state.data.topics.values.first;

    final nextPage = state.data.pages[topic.pagesIds[nextPageIndex]];
    if (nextPage == null) return;

    final unlockedChunks = state.data.getPagesUnlockedChunks(nextPage.id);
    final hasUnlockedChunks = unlockedChunks.isNotEmpty;

    final activeChunk =
        hasUnlockedChunks ? unlockedChunks.last : state.data.chunks[nextPage.chunksIds.first];
    if (activeChunk == null) return;

    final unlockedChunksByPage = hasUnlockedChunks
        ? state.data.unlockedChunksByPage
        : _updateUnlockedChunks(nextPage.id, activeChunk);

    emit(InteractiveLessonsState.setPage(state.data.copyWith(
      activePage: nextPage,
      activePageIndex: nextPageIndex,
      activeChunkIndex: hasUnlockedChunks ? unlockedChunks.length - 1 : 0,
      activeChunk: activeChunk,
      unlockedChunksByPage: unlockedChunksByPage,
    )));
  }

  Future<void> _onSetPrevPage(
    SetPrevPage event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    final prevPageIndex = state.data.activePageIndex - 1;
    if (prevPageIndex < 0 || prevPageIndex >= state.data.pages.length) return;

    final topic = state.data.topics.values.first;

    final prevPage = state.data.pages[topic.pagesIds[prevPageIndex]];
    if (prevPage == null) return;

    final activeChunk = state.data.chunks[prevPage.chunksIds.last];
    if (activeChunk == null) return;

    emit(InteractiveLessonsState.setPage(state.data.copyWith(
      activePage: prevPage,
      activePageIndex: prevPageIndex,
      activeChunkIndex: prevPage.chunksIds.length - 1,
      activeChunk: activeChunk,
    )));
  }

  Future<void> _onUnlockNextChunk(
    UnlockNextChunk event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    final activePage = state.data.activePage;

    final nextChunkIndex = state.data.activeChunkIndex + 1;

    if (activePage == null || nextChunkIndex >= activePage.chunksIds.length) return;

    final nextChunk = state.data.chunks[activePage.chunksIds[nextChunkIndex]];
    if (nextChunk == null) return;

    emit(InteractiveLessonsState.setUnlockedChunks(state.data.copyWith(
      activeChunk: nextChunk,
      activeChunkIndex: nextChunkIndex,
      unlockedChunksByPage: _updateUnlockedChunks(activePage.id, nextChunk),
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
