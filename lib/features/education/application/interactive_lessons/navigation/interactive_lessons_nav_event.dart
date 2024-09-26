part of 'interactive_lessons_nav_bloc.dart';

@freezed
class InteractiveLessonsNavEvent with _$InteractiveLessonsNavEvent {
  const factory InteractiveLessonsNavEvent.setInitial(List<InteractiveLessonTopicsPage> pages) =
      SetInitial;

  const factory InteractiveLessonsNavEvent.updateUnlockedChunks() = UpdateUnlockedChunks;

  const factory InteractiveLessonsNavEvent.setNextPage() = SetNextPage;

  const factory InteractiveLessonsNavEvent.setPrevPage() = SetPrevPage;
}
