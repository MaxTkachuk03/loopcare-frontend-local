import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_page.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/audio_lesson_content_type.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_type.dart';
import 'package:path_provider/path_provider.dart';

part 'education_lesson_event.dart';

part 'education_lesson_state.dart';

part 'education_lesson_bloc.freezed.dart';

@singleton
class EducationLessonBloc extends Bloc<EducationLessonEvent, EducationLessonState> {
  final EducationService _educationService;

  static const _defaultError = RequestError.unhandledError('Something went wrong, please try again');

  EducationLessonBloc(
    this._educationService,
  ) : super(const EducationLessonState.initial(EducationLessonData())) {
    on<GetLessonContent>(_onGetLessonContent);
    on<NextPage>(_onNextPage);
    on<PrevPage>(_onPrevPage);
    on<ProgressForward>(_onProgressForward);
    on<ProgressBack>(_onProgressBack);
    on<CompleteLesson>(_onCompleteLesson);
    on<DownloadAudioFile>(_onDownloadAudioFile);
    on<DownloadSubtitlesFile>(_onDownloadSubtitlesFile);
    on<DownloadSVGFile>(_onDownloadSVGFile);
    on<Init>(_onInit);
  }

  Future<void> _onInit(
    Init event,
    Emitter<EducationLessonState> emit,
  ) async {
    var tempDir = await getTemporaryDirectory();

    emit(EducationLessonState.contentLoaded(state.data.copyWith(temporaryDirectory: tempDir.path)));
  }

  Future<void> _onDownloadSVGFile(
    DownloadSVGFile event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.contentLoaded(state.data.copyWith(isSvgLoaded: false, svgFile: '')));

    final response = await _educationService.downloadFile(
      event.url,
      state.data.filePath(event.url),
    );
    response.fold((l) {}, (r) {
      emit(
        EducationLessonState.contentLoaded(
          state.data.copyWith(
            isSvgLoaded: true,
            svgFile: state.data.filePath(event.url),
          ),
        ),
      );
    });
  }

  Future<void> _onDownloadAudioFile(
    DownloadAudioFile event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.contentLoaded(state.data.copyWith(isAudioLoading: true)));

    if (state.data.isAudioAlreadyInCache) {
      emit(
        EducationLessonState.contentLoaded(state.data.copyWith(
          isAudioLoading: false,
          pages: _updateLessonPageAudioFilePath(state.data.filePath(event.url)),
        )),
      );

      return;
    }

    final response = await _educationService.downloadFile(event.url, state.data.filePath(event.url));

    response.fold(
      (l) => emit(EducationLessonState.contentLoaded(state.data.copyWith(error: l, isAudioLoading: false))),
      (r) {
        emit(
          EducationLessonState.contentLoaded(state.data.copyWith(
            isAudioLoading: false,
            pages: _updateLessonPageAudioFilePath(state.data.filePath(event.url)),
            audioFilesCache: _updateAudioCacheValue(AudioLessonContentType.audio),
          )),
        );
      },
    );
  }

  Future<void> _onDownloadSubtitlesFile(
    DownloadSubtitlesFile event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.contentLoaded(state.data.copyWith(isSubtitleLoading: true)));

    if (state.data.isSubtitlesAlreadyInCache) {
      emit(
        EducationLessonState.contentLoaded(state.data.copyWith(
            isSubtitleLoading: false,
            pages: _updateLessonPageSubtitleFilePath(state.data.filePath(event.url)))),
      );

      return;
    }

    final response = await _educationService.downloadFile(event.url, state.data.filePath(event.url));

    response.fold(
        (l) =>
            emit(EducationLessonState.contentLoaded(state.data.copyWith(error: l, isSubtitleLoading: false))),
        (r) {
      emit(
        EducationLessonState.contentLoaded(state.data.copyWith(
          isSubtitleLoading: false,
          pages: _updateLessonPageSubtitleFilePath(state.data.filePath(event.url)),
          audioFilesCache: _updateAudioCacheValue(AudioLessonContentType.subtitles),
        )),
      );
    });
  }

  Future<void> _onGetLessonContent(
    GetLessonContent event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.loading(state.data.copyWith(isLoading: true, error: null)));

    final response = await _educationService.getLessonContent(event.lessonId);

    response.fold(
      (l) {
        emit(EducationLessonState.errorGettingLessons(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) async {
        r.pages.sort((a, b) => a.order.compareTo(b.order));

        if (r.pages.isEmpty) {
          emit(EducationLessonState.errorGettingLessons(
              state.data.copyWith(error: _defaultError, isLoading: false)));

          return;
        }

        emit(
          EducationLessonState.contentLoaded(
            state.data.copyWith(
              extraAction: r.extraAction,
              pages: r.pages,
              totalPagesLength: r.extraAction == ExtraActionTypes.setupGroupingPreferences
                  ? r.pages.length + groupLessonRoutes.length
                  : r.pages.length,
              currentPageIndex: event.pageIndex,
              currentProgressPageIndex: event.pageIndex,
              lessonProgress: 0,
              lessonId: r.id,
              lessonCompletedDate: r.completedAt,
              lessonCategory: r.category,
              lessonDuration: r.duration,
              lessonImage: r.image,
              lessonTitle: r.title,
              isLoading: false,
              error: null,
              questions: r.questions,
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

    emit(EducationLessonState.contentLoaded(
        state.data.copyWith(currentPageIndex: state.data.currentPageIndex + 1)));
  }

  Future<void> _onPrevPage(
    PrevPage event,
    Emitter<EducationLessonState> emit,
  ) async {
    if (state.data.currentPageIndex == 0) return;

    emit(EducationLessonState.contentLoaded(
        state.data.copyWith(currentPageIndex: state.data.currentPageIndex - 1)));
  }

  Future<void> _onCompleteLesson(
    CompleteLesson event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.loading(state.data.copyWith(isLoading: true, error: null)));

    final response = await _educationService.completeLesson(state.data.lessonId);

    response.fold(
      (l) {
        emit(EducationLessonState.errorCompleteLesson(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) {
        emit(
          EducationLessonState.lessonCompleted(
            state.data.copyWith(
              extraAction: r.extraAction,
              pages: r.pages,
              totalPagesLength: r.extraAction == ExtraActionTypes.setupGroupingPreferences
                  ? r.pages.length + groupLessonRoutes.length
                  : r.pages.length,
              lessonProgress: 0,
              lessonId: r.id,
              lessonCompletedDate: r.completedAt,
              lessonCategory: r.category,
              lessonDuration: r.duration,
              lessonImage: r.image,
              lessonTitle: r.title,
              isLoading: false,
              error: null,
              questions: r.questions,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onProgressForward(ProgressForward event, Emitter<EducationLessonState> emit) {
    final newProgressIndexPage = state.data.currentProgressPageIndex + 1;

    emit(EducationLessonState.contentLoaded(state.data.copyWith(
        currentProgressPageIndex: newProgressIndexPage,
        lessonProgress: (100 * newProgressIndexPage) ~/ state.data.totalPagesLength)));
  }

  FutureOr<void> _onProgressBack(ProgressBack event, Emitter<EducationLessonState> emit) {
    if (state.data.currentProgressPageIndex == 0) return null;

    final newProgressIndexPage = state.data.currentProgressPageIndex - 1;

    emit(EducationLessonState.contentLoaded(state.data.copyWith(
        currentProgressPageIndex: newProgressIndexPage,
        lessonProgress: (100 * newProgressIndexPage) ~/ state.data.totalPagesLength)));
  }

  // FIXME cache to prevent multiple download request, the root of the issue wrong bloc structure and logic, could be fixed during education refactoring with chapters
  Map<String, Set<AudioLessonContentType>> _updateAudioCacheValue(AudioLessonContentType newValue) {
    final Map<String, Set<AudioLessonContentType>> cache = {...state.data.audioFilesCache};

    final cacheKey = state.data.lessonId.toString();

    var value = cache[cacheKey];

    if (value != null) {
      value.add(newValue);
    } else {
      value = {newValue};
    }

    cache[cacheKey] = value;

    return cache;
  }

  List<LessonPage> _updateLessonPageSubtitleFilePath(String newValue) {
    final List<LessonPage> pages = [...state.data.pages];

    pages[state.data.currentPageIndex] =
        pages[state.data.currentPageIndex].copyWith.content(subtitleFilePath: newValue);

    return pages;
  }

  List<LessonPage> _updateLessonPageAudioFilePath(String newValue) {
    final List<LessonPage> pages = [...state.data.pages];

    pages[state.data.currentPageIndex] =
        pages[state.data.currentPageIndex].copyWith.content(audioFilePath: newValue);

    return pages;
  }
}
