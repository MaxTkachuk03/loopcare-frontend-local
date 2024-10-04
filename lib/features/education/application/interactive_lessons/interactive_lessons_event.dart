part of 'interactive_lessons_bloc.dart';

@freezed
class InteractiveLessonsEvent with _$InteractiveLessonsEvent {
  const factory InteractiveLessonsEvent.getInteractiveLesson({required int lessonId}) =
      GetInteractiveLesson;

  const factory InteractiveLessonsEvent.setNextPage() = SetNextPage;

  const factory InteractiveLessonsEvent.setPrevPage() = SetPrevPage;

  const factory InteractiveLessonsEvent.unlockNextChunk() = UnlockNextChunk;
}
