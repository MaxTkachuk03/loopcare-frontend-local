part of 'interactive_lessons_bloc.dart';

@freezed
class InteractiveLessonsEvent with _$InteractiveLessonsEvent {
  const factory InteractiveLessonsEvent.getInteractiveLesson(
      {required int lessonId,
      DateTime? date,
      RiverModuleItemState? lessonStatus}) = GetInteractiveLesson;

  const factory InteractiveLessonsEvent.setNextPage() = SetNextPage;

  const factory InteractiveLessonsEvent.setPrevPage() = SetPrevPage;

  const factory InteractiveLessonsEvent.saveAnswer(
          InteractiveLessonComponentProgress progress, InteractiveLessonChunkComponent component) =
      SaveAnswer;

  const factory InteractiveLessonsEvent.unlockNextChunk() = UnlockNextChunk;

  const factory InteractiveLessonsEvent.updateMealTime(DateTime updatedAt, MealCategory category,
      InteractiveLessonChunkComponentMealTiming mealTimingComponent, int index) = UpdateMealTime;

  const factory InteractiveLessonsEvent.getMealTime() = GetMealTime;
}
