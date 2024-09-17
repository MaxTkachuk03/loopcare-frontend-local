part of 'interactive_lessons_bloc.dart';

@freezed
class InteractiveLessonsState with _$InteractiveLessonsState {
  const factory InteractiveLessonsState.initial(InteractiveLessonsStateData data) =
      InteractiveLessonsStateInitial;

  const factory InteractiveLessonsState.loading(InteractiveLessonsStateData data) =
      InteractiveLessonsStateLoading;

  const factory InteractiveLessonsState.error(InteractiveLessonsStateData data) =
      InteractiveLessonsStateError;

  const factory InteractiveLessonsState.lessonLoaded(InteractiveLessonsStateData data) =
      InteractiveLessonsStateLessonLoaded;
}

@freezed
class InteractiveLessonsStateData with _$InteractiveLessonsStateData {
  const InteractiveLessonsStateData._();

  const factory InteractiveLessonsStateData({
    @Default(null) InteractiveLesson? interactiveLesson,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _InteractiveLessonsStateData;
}
