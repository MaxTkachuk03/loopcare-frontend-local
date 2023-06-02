import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_page.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';

part 'education_lesson_event.dart';
part 'education_lesson_state.dart';
part 'education_lesson_bloc.freezed.dart';

@singleton
class EducationLessonBloc
    extends Bloc<EducationLessonEvent, EducationLessonState> {
  final EducationService _educationService;

  static const _defaultError =
      RequestError.unhandledError('Something went wrong, please try again');

  EducationLessonBloc(
    this._educationService,
  ) : super(const EducationLessonState.initial(EducationLessonData())) {
    on<GetLessonContent>(_onGetLessonContent);
    on<NextPage>(_onNextPage);
    on<PrevPage>(_onPrevPage);
    on<CompleteLesson>(_onCompleteLesson);
    on<DownloadFile>(_onDownloadFile);
  }

  Future<void> _onDownloadFile(
    DownloadFile event,
    Emitter<EducationLessonState> emit,
  ) async {
    var response = _educationService.downloadFile(event.url);
  }

  Future<void> _onGetLessonContent(
    GetLessonContent event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.loading(state.data.copyWith(
      isLoading: true,
      error: null,
    )));

    final response = await _educationService.getLessonContent(event.lessonId);

    response.fold(
      (l) {
        emit(EducationLessonState.errorGettingLessons(state.data.copyWith(
          error: l,
          isLoading: false,
        )));
      },
      (r) {
        r.pages.sort((a, b) => a.order.compareTo(b.order));

        if (r.pages.isEmpty) {
          emit(EducationLessonState.errorGettingLessons(state.data.copyWith(
            error: _defaultError,
            isLoading: false,
          )));

          return;
        }

        emit(
          EducationLessonState.contentLoaded(
            state.data.copyWith(
              pages: r.pages,
              currentPageIndex: event.pageIndex,
              lessonId: r.id,
              lessonCompletedDate: r.completedAt,
              lessonCategory: r.category,
              lessonDuration: r.duration,
              lessonImage: r.image,
              lessonTitle: r.title,
              isLoading: false,
              error: null,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onNextPage(
    NextPage event,
    Emitter<EducationLessonState> emit,
  ) async {
    if (state.data.isLastPage) return;

    emit(EducationLessonState.contentLoaded(state.data
        .copyWith(currentPageIndex: state.data.currentPageIndex + 1)));
  }

  Future<void> _onPrevPage(
    PrevPage event,
    Emitter<EducationLessonState> emit,
  ) async {
    if (state.data.currentPageIndex == 0) return;

    emit(EducationLessonState.contentLoaded(state.data
        .copyWith(currentPageIndex: state.data.currentPageIndex - 1)));
  }

  Future<void> _onCompleteLesson(
    CompleteLesson event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.loading(state.data.copyWith(
      isLoading: true,
      error: null,
    )));

    final response =
        await _educationService.completeLesson(state.data.lessonId);

    response.fold(
      (l) {
        emit(EducationLessonState.errorCompleteLesson(state.data.copyWith(
          error: l,
          isLoading: false,
        )));
      },
      (r) {
        emit(EducationLessonState.lessonCompleted(state.data.copyWith(
          error: null,
          isLoading: false,
        )));
      },
    );
  }
}
