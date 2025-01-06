import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_type.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topic.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topics_page.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_state.dart';

import '../dto/save_interactive_lesson_progress_body.dart';

part 'interactive_lessons_bloc.freezed.dart';

part 'interactive_lessons_event.dart';

part 'interactive_lessons_state.dart';

@singleton
class InteractiveLessonsBloc extends Bloc<InteractiveLessonsEvent, InteractiveLessonsState> {
  final EducationService _educationService;

  InteractiveLessonsBloc(this._educationService)
      : super(const InteractiveLessonsState.initial(InteractiveLessonsStateData())) {
    on<GetInteractiveLesson>(_onGetInteractiveLesson);
    on<SetNextPage>(_onSetNextPage);
    on<SetPrevPage>(_onSetPrevPage);
    on<UnlockNextChunk>(_onUnlockNextChunk);
    on<SaveAnswer>(_onSaveAnswer);
    on<GetMealTime>(_onGetMealTime);
    on<UpdateMealTime>(_onUpdateMealTime);
    on<SetAnswerDate>(_onSetAnswerDate);
  }

  Future<void> _onGetMealTime(
    GetMealTime event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    final mealTimingComponent = state.data.unlockedChunkComponents
        .whereType<InteractiveLessonChunkComponentMealTiming>()
        .firstOrNull;

    final mealsListItems = mealTimingComponent!.content.meals;

    final mealsTime = mealsListItems
        .where((meals) => meals.mealCategory == MealCategory.inbetweens.originalValue)
        .expand((meals) => meals.mealItems.map((meal) => meal.updatedAt))
        .toList();

    emit(InteractiveLessonsState.lessonLoaded(
      state.data.copyWith(mealsTime: mealsTime),
    ));
  }

  Future<void> _onUpdateMealTime(
    UpdateMealTime event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    final updatedMealsTime = List<DateTime>.from(state.data.mealsTime);

    updatedMealsTime[event.index] = event.updatedAt;

    emit(InteractiveLessonsState.lessonLoaded(
      state.data.copyWith(mealsTime: updatedMealsTime),
    ));
  }

  Future<void> _onGetInteractiveLesson(
    GetInteractiveLesson event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    emit(const InteractiveLessonsState.initial(InteractiveLessonsStateData()));

    emit(InteractiveLessonsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _educationService.getInteractiveLesson(event.lessonId, event.date);

    response.fold(
      (l) => emit(InteractiveLessonsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        if (r.pages.isEmpty) return;
        final activePage = r.pages.values.first;

        if (r.chunks.isEmpty) return;
        final activeChunk = r.chunks.values.first;

        final activePageUnlockedChunks = state.data.getPagesUnlockedChunks(activePage.id);
        final hasUnlockedChunks = activePageUnlockedChunks.isNotEmpty;
        final unlockedChunksByPage = hasUnlockedChunks
            ? state.data.unlockedChunksByPage
            : _updateUnlockedChunks(activePage.id, activeChunk);

        final components = state.data.components.isEmpty ? r.components : state.data.components;

        final unlockedChunkComponents = components.values
            .where((component) =>
                component.chunkId == activeChunk.id &&
                activeChunk.componentsIds.contains(component.id))
            .toList();

        emit(InteractiveLessonsState.lessonLoaded(state.data.copyWith(
          id: r.id,
          lessonStatus: event.lessonStatus ?? RiverModuleItemState.unlocked,
          type: r.type!,
          title: r.title,
          jumpBoardTitle: r.jumpBoardTitle,
          jumpBoardDescription: r.jumpBoardDescription,
          conclusion: r.conclusion,
          unlockTitle: r.unlockTitle!,
          unlockDescription: r.unlockDescription!,
          unlockedChunkComponents: unlockedChunkComponents,
          topics: r.topics,
          pages: r.pages,
          chunks: r.chunks,
          components: components,
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

  Future<void> _onSaveAnswer(
    SaveAnswer event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    final activeChunk = state.data.activeChunk;
    final int chunkId = event.component.chunkId;
    String convertedDate;

    final InteractiveLessonChunkComponent componentWithProgress =
        event.component.copyWith(progress: event.progress);

    final componentInx = event.component.id;
    final updatedComponents = Map<int, InteractiveLessonChunkComponent>.from(state.data.components);

    updatedComponents.updateAll((key, component) {
      if (component.id == componentInx && component.chunkId == chunkId) {
        return componentWithProgress;
      }
      return component;
    });

    final unlockedChunkComponents = updatedComponents.values
        .where((component) =>
            component.chunkId == activeChunk!.id &&
            activeChunk.componentsIds.contains(component.id))
        .toList();
    if (state.data.answerDate.isNotEmpty) {
      final date = DateTime.parse(state.data.answerDate);
      convertedDate = DateFormat("yyyy-MM-dd").format(date);
    } else {
      convertedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    }

    final data = SaveInteractiveLessonProgressBody(
        lessonId: state.data.id,
        topicId: state.data.activePage!.topicId,
        pageId: state.data.activePage!.id,
        componentId: event.component.id,
        answerType: event.component.type.name,
        answeredAt: convertedDate,
        progress: componentWithProgress.progress!);

    final response = await _educationService.saveInteractiveLessonProgress(chunkId, data);

    response.fold(
        (l) => emit(InteractiveLessonsState.error(state.data.copyWith(error: l, isLoading: false))),
        (r) {
      emit(
        InteractiveLessonsState.saveAnswer(
          state.data.copyWith(
            components: updatedComponents,
            unlockedChunkComponents: unlockedChunkComponents,
            allTextAreasAdded: state.data.hasProgress(unlockedChunkComponents),
          ),
        ),
      );
    });
  }

  Future<void> _onSetNextPage(
    SetNextPage event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    final nextPageIndex = state.data.activePageIndex + 1;
    if (nextPageIndex >= state.data.pages.length) return;

    final topic = state.data.topics.values.first;

    if (state.data.pages.isEmpty) return;
    final nextPage =
        state.data.pages.values.where((page) => page.id == topic.pagesIds[nextPageIndex]).first;

    final unlockedChunks = state.data.getPagesUnlockedChunks(nextPage.id);
    final hasUnlockedChunks = unlockedChunks.isNotEmpty;
    final activeChunk =
        hasUnlockedChunks ? unlockedChunks.last : state.data.getActiveChunk(nextPage);

    final unlockedChunksByPage = hasUnlockedChunks
        ? state.data.unlockedChunksByPage
        : _updateUnlockedChunks(nextPage.id, activeChunk);

    final unlockedChunkComponents = state.data.getChunkComponents(activeChunk);

    emit(InteractiveLessonsState.setPage(state.data.copyWith(
      activePage: nextPage,
      activePageIndex: nextPageIndex,
      unlockedChunkComponents: unlockedChunkComponents,
      activeChunkIndex: hasUnlockedChunks ? unlockedChunks.length - 1 : 0,
      activeChunk: activeChunk,
      unlockedChunksByPage: unlockedChunksByPage,
      allTextAreasAdded: state.data.hasProgress(unlockedChunkComponents),
    )));
  }

  Future<void> _onSetPrevPage(
    SetPrevPage event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    final prevPageIndex = state.data.activePageIndex - 1;
    if (prevPageIndex < 0 || prevPageIndex >= state.data.pages.length) return;

    final topic = state.data.topics.values.first;

    if (state.data.pages.isEmpty) return;
    final prevPage = state.data.pages.values
        .where((page) => page.topicId == topic.id && page.id == topic.pagesIds[prevPageIndex])
        .first;

    final activeChunk = state.data.getActiveChunk(prevPage);

    final unlockedChunkComponents = state.data.getChunkComponents(activeChunk);

    emit(InteractiveLessonsState.setPage(state.data.copyWith(
        activePage: prevPage,
        activePageIndex: prevPageIndex,
        activeChunkIndex: prevPage.chunksIds.length - 1,
        activeChunk: activeChunk,
        allTextAreasAdded: true,
        unlockedChunkComponents: unlockedChunkComponents)));
  }

  Future<void> _onUnlockNextChunk(
    UnlockNextChunk event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    final activePage = state.data.activePage;

    final nextChunkIndex = state.data.activeChunkIndex + 1;

    if (activePage == null || nextChunkIndex >= activePage.chunksIds.length) {
      return;
    }

    final nextChunk = state.data.chunks.values
        .where((chunk) =>
            chunk.pageId == activePage.id && chunk.id == activePage.chunksIds[nextChunkIndex])
        .first;

    final unlockedChunkComponents = state.data.getChunkComponents(nextChunk);

    emit(InteractiveLessonsState.setUnlockedChunks(state.data.copyWith(
      activeChunk: nextChunk,
      activeChunkIndex: nextChunkIndex,
      unlockedChunkComponents: unlockedChunkComponents,
      unlockedChunksByPage: _updateUnlockedChunks(activePage.id, nextChunk),
      allTextAreasAdded: state.data.hasProgress(unlockedChunkComponents),
    )));
  }

  Future<void> _onSetAnswerDate(
    SetAnswerDate event,
    Emitter<InteractiveLessonsState> emit,
  ) async {
    emit(InteractiveLessonsState.lessonLoaded(state.data.copyWith(answerDate: event.answerDate)));
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
