import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/dto/save_lesson_quiz_question_answer_body.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/audio_lesson_content_type.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_content_type.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:path_provider/path_provider.dart';

part 'education_lesson_bloc.freezed.dart';
part 'education_lesson_event.dart';
part 'education_lesson_state.dart';

@singleton
class EducationLessonBloc
    extends Bloc<EducationLessonEvent, EducationLessonState> {
  final EducationService _educationService;

  EducationLessonBloc(this._educationService)
      : super(const EducationLessonState.initial(EducationLessonData())) {
    on<Init>(_onInit);
    on<GetLessonContent>(_onGetLessonContent);
    on<AnswerQuizQuestion>(_onAnswerQuizQuestion);
    on<DownloadAudioFile>(_onDownloadAudioFile);
    on<DownloadSubtitlesFile>(_onDownloadSubtitlesFile);
  }

  Future<void> _onInit(
    Init event,
    Emitter<EducationLessonState> emit,
  ) async {
    var tempDir = await getTemporaryDirectory();

    emit(EducationLessonState.initial(
        state.data.copyWith(temporaryDirectory: tempDir.path)));
  }

  Future<void> _onGetLessonContent(
    GetLessonContent event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.contentIsLoading(
        state.data.copyWith(isLoading: true, error: null)));

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
              audioUrl: r.audioUrl ?? '',
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

  Future<void> _onAnswerQuizQuestion(
    AnswerQuizQuestion event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.contentIsLoading(
        state.data.copyWith(isLoading: true, error: null)));

    final quizId = state.data.quiz?.id;

    if (quizId == null) return;

    final data = SaveLessonQuizQuestionAnswerBody(
      lessonQuizQuestionOptionIds: [event.questionOptionId],
      lessonQuizQuestionId: event.questionId,
    );

    final response =
        await _educationService.saveLessonQuizQuestionAnswer(quizId, data);

    response.fold(
      (l) => emit(EducationLessonState.contentLoaded(
          state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(EducationLessonState.contentLoaded(
          state.data.copyWith(quiz: r, isLoading: false))),
    );
  }

  Future<void> _onDownloadAudioFile(
    DownloadAudioFile event,
    Emitter<EducationLessonState> emit,
  ) async {
    emit(EducationLessonState.loading(
        state.data.copyWith(isAudioLoading: true, isLoading: true)));

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
        emit(EducationLessonState.contentLoaded(state.data
            .copyWith(error: l, isAudioLoading: false, isLoading: false)));
      },
      (r) {
        emit(
          EducationLessonState.contentLoaded(state.data.copyWith(
            isAudioLoading: false,
            isLoading: false,
            audioFilePath: safeUrl,
            audioFilesCache:
                _updateAudioCacheValue(AudioLessonContentType.audio),
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

    final response = await _educationService.downloadFile(
        event.url, state.data.filePath(event.url));

    response.fold(
        (l) => emit(EducationLessonState.contentLoaded(state.data.copyWith(
            error: l, isSubtitleLoading: false, isLoading: false))), (r) {
      emit(
        EducationLessonState.contentLoaded(state.data.copyWith(
          isSubtitleLoading: false,
          isLoading: false,
          subtitleFilePath: state.data.filePath(event.url),
          audioFilesCache:
              _updateAudioCacheValue(AudioLessonContentType.subtitles),
        )),
      );
    });
  }

  Map<String, Set<AudioLessonContentType>> _updateAudioCacheValue(
      AudioLessonContentType newValue) {
    final Map<String, Set<AudioLessonContentType>> cache = {
      ...state.data.audioFilesCache
    };

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
