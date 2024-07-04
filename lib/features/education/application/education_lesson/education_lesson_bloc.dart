import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_page.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/audio_lesson_content_type.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_content_type.dart';
import 'package:loopcare_frontend/features/quizzes/domain/quiz.dart';
import 'package:loopcare_frontend/features/quizzes/domain/quiz_question.dart';
import 'package:path_provider/path_provider.dart';

part 'education_lesson_bloc.freezed.dart';
part 'education_lesson_event.dart';
part 'education_lesson_state.dart';

@singleton
class EducationLessonBloc extends Bloc<EducationLessonEvent, EducationLessonState> {
  final EducationService _educationService;

  final _defaultError = const RequestError.unhandledResponse(
      ServerErrorData(message: LocalizedTexts.somethingWentWrong));

  EducationLessonBloc(this._educationService)
      : super(const EducationLessonState.initial(EducationLessonData())) {
    on<GetLessonContent>(_onGetLessonContent);
    // on<NextPage>(_onNextPage);
    // on<PrevPage>(_onPrevPage);
    // on<ProgressForward>(_onProgressForward);
    // on<ProgressBack>(_onProgressBack);
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

    emit(EducationLessonState.initial(state.data.copyWith(temporaryDirectory: tempDir.path)));
  }

  Future<void> _onDownloadAudioFile(
    DownloadAudioFile event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.loading(state.data.copyWith(isAudioLoading: true, isLoading: true)));

    final safeUrl = state.data.filePath(event.url.split('?')[0]);

    if (state.data.isAudioAlreadyInCache) {
      emit(
        EducationLessonState.contentLoaded(state.data.copyWith(
          audioFilePath: safeUrl,
          isAudioLoading: false,
          isLoading: false,
        )),
      );

      return;
    }

    final response = await _educationService.downloadFile(event.url, safeUrl);

    response.fold(
      (l) {
        emit(EducationLessonState.contentLoaded(
            state.data.copyWith(error: l, isAudioLoading: false, isLoading: false)));
      },
      (r) {
        emit(
          EducationLessonState.contentLoaded(state.data.copyWith(
            isAudioLoading: false,
            isLoading: false,
            audioFilePath: safeUrl,
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
    emit(EducationLessonState.loading(
        state.data.copyWith(isSubtitleLoading: true, isLoading: true)));

    if (state.data.isSubtitlesAlreadyInCache) {
      emit(
        EducationLessonState.contentLoaded(state.data.copyWith(
          isSubtitleLoading: false,
          isLoading: false,
          subtitleFilePath: state.data.filePath(event.url),
        )),
      );

      return;
    }

    final response =
        await _educationService.downloadFile(event.url, state.data.filePath(event.url));

    response.fold(
        (l) => emit(EducationLessonState.contentLoaded(
            state.data.copyWith(error: l, isSubtitleLoading: false, isLoading: false))), (r) {
      emit(
        EducationLessonState.contentLoaded(state.data.copyWith(
          isSubtitleLoading: false,
          isLoading: false,
          subtitleFilePath: state.data.filePath(event.url),
          audioFilesCache: _updateAudioCacheValue(AudioLessonContentType.subtitles),
        )),
      );
    });
  }

  Future<void> _onGetLessonContent(
    GetLessonContent event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.contentIsLoading(state.data.copyWith(isLoading: true, error: null)));

    final response = await _educationService.getLessonContent(event.lessonId);

    response.fold(
      (l) => emit(EducationLessonState.errorGettingContent(
          state.data.copyWith(error: l, isLoading: false))),
      (r) async {
        emit(
          EducationLessonState.contentLoaded(
            state.data.copyWith(
              id: r.id,
              title: r.title,
              duration: r.duration,
              contentType: r.contentType,
              imageUrl: r.imageUrl,
              cardImageUrl: r.cardImageUrl,
              audioUrl: r.audioUrl,
              htmlUrl: r.htmlUrl,
              subtitleImages: r.subtitleImages,
              quiz: r.quiz,
              conclusion: r.conclusion ?? '',
              unlockTitle: r.unlockTitle ?? '',
              unlockDescription: r.unlockDescription ?? '',
              progress: 0,
              isLoading: false,
              error: null,
            ),
          ),
        );
      },
    );
  }

  // Future<void> _onNextPage(
  //   NextPage event,
  //   Emitter<EducationLessonState> emit,
  // ) async {
  //   // if (state.data.isLastPage) return;
  //
  //   emit(EducationLessonState.contentLoaded(
  //       state.data.copyWith(currentPageIndex: state.data.currentPageIndex + 1)));
  // }
  //
  // Future<void> _onPrevPage(
  //   PrevPage event,
  //   Emitter<EducationLessonState> emit,
  // ) async {
  //   if (state.data.currentPageIndex == 0) return;
  //
  //   emit(EducationLessonState.contentLoaded(
  //       state.data.copyWith(currentPageIndex: state.data.currentPageIndex - 1)));
  // }

  Future<void> _onCompleteLesson(
    CompleteLesson event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.loading(state.data.copyWith(isLoading: true, error: null)));

    final response = await _educationService.completeLesson(state.data.id);

    response.fold(
      (l) => emit(EducationLessonState.errorCompleteLesson(
          state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
        EducationLessonState.lessonCompleted(
          state.data.copyWith(
              // totalPagesLength: r.pages.length,
              // lessonProgress: 0,
              // lessonId: r.id,
              // lessonCompletedDate: r.completedAt,
              // lessonCategory: r.category,
              // lessonDuration: r.duration,
              // lessonImage: r.image,
              // lessonTitle: r.title,
              // isLoading: false,
              // error: null,
              // questions: r.questions,
              ),
        ),
      ),
    );
  }

  // FutureOr<void> _onProgressForward(ProgressForward event, Emitter<EducationLessonState> emit) {
  //   final newProgressIndexPage = state.data.currentProgressPageIndex + 1;
  //
  //   emit(EducationLessonState.contentLoaded(state.data.copyWith(
  //       currentProgressPageIndex: newProgressIndexPage,
  //       lessonProgress: (100 * newProgressIndexPage) ~/ state.data.totalPagesLength)));
  // }
  //
  // FutureOr<void> _onProgressBack(ProgressBack event, Emitter<EducationLessonState> emit) {
  //   if (state.data.currentProgressPageIndex == 0) return null;
  //
  //   final newProgressIndexPage = state.data.currentProgressPageIndex - 1;
  //
  //   emit(EducationLessonState.contentLoaded(state.data.copyWith(
  //       currentProgressPageIndex: newProgressIndexPage,
  //       lessonProgress: (100 * newProgressIndexPage) ~/ state.data.totalPagesLength)));
  // }

  // FIXME cache to prevent multiple download request, the root of the issue wrong bloc structure and logic, could be fixed during education refactoring with chapters
  Map<String, Set<AudioLessonContentType>> _updateAudioCacheValue(AudioLessonContentType newValue) {
    final Map<String, Set<AudioLessonContentType>> cache = {...state.data.audioFilesCache};

    final cacheKey = state.data.id.toString();

    var value = cache[cacheKey];

    if (value != null) {
      value.add(newValue);
    } else {
      value = {newValue};
    }

    cache[cacheKey] = value;

    return cache;
  }
}
