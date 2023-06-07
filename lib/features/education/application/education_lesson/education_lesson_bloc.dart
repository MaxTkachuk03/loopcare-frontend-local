import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_page.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:path_provider/path_provider.dart';

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
  ) : super(
          const EducationLessonState.initial(
            EducationLessonData(),
          ),
        ) {
    on<GetLessonContent>(_onGetLessonContent);
    on<NextPage>(_onNextPage);
    on<PrevPage>(_onPrevPage);
    on<CompleteLesson>(_onCompleteLesson);
    on<DownloadAudioFile>(_onDownloadAudioFile);
    on<DownloadSubtitlesFile>(_onDownloadSubtitlesFile);
    on<Init>(_onInit);
  }

  Future<void> _onInit(
    Init event,
    Emitter<EducationLessonState> emit,
  ) async {
    var tempDir = await getTemporaryDirectory();

    emit(
      EducationLessonState.contentLoaded(
        state.data.copyWith(
          temporaryDirectory: tempDir.path,
        ),
      ),
    );
  }

  Future<void> _onDownloadAudioFile(
    DownloadAudioFile event,
    Emitter<EducationLessonState> emit,
  ) async {
    final response = await _educationService.downloadFile(
      event.url,
      state.data.filePath(event.url),
    );
    response.fold((l) {}, (r) {
      emit(
        EducationLessonState.contentLoaded(
          state.data.copyWith(
            isLoading: false,
            audioFilePath: state.data.filePath(event.url),
          ),
        ),
      );
    });
  }

  Future<void> _onDownloadSubtitlesFile(
    DownloadSubtitlesFile event,
    Emitter<EducationLessonState> emit,
  ) async {
    final response = await _educationService.downloadFile(
      event.url,
      state.data.filePath(event.url),
    );
    response.fold((l) {}, (r) {
      emit(
        EducationLessonState.contentLoaded(
          state.data.copyWith(
            isLoading: false,
            subtitleFilePath: state.data.filePath(event.url),
          ),
        ),
      );
    });
  }

  Future<void> _onGetLessonContent(
    GetLessonContent event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(
      EducationLessonState.loading(
        state.data.copyWith(
          isLoading: true,
          error: null,
        ),
      ),
    );

    final response = await _educationService.getLessonContent(event.lessonId);

    response.fold(
      (l) {
        emit(
          EducationLessonState.errorGettingLessons(
            state.data.copyWith(
              error: l,
              isLoading: false,
            ),
          ),
        );
      },
      (r) async {
        r.pages.sort((a, b) => a.order.compareTo(b.order));

        if (r.pages.isEmpty) {
          emit(
            EducationLessonState.errorGettingLessons(
              state.data.copyWith(
                error: _defaultError,
                isLoading: false,
              ),
            ),
          );

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
