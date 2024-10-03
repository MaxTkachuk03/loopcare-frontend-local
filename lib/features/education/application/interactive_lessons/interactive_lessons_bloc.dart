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
        final activeChunk = r.chunks[activePage?.chunksIds.first];

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
          activeChunkIndex: 0,
          isLoading: false,
        )));
      },
    );
  }
}
