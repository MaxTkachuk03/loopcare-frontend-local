import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';

part 'interactive_lesson_topics_page.freezed.dart';
part 'interactive_lesson_topics_page.g.dart';

@freezed
class InteractiveLessonTopicsPage with _$InteractiveLessonTopicsPage {
  const InteractiveLessonTopicsPage._();

  const factory InteractiveLessonTopicsPage({
    required int id,
    required String title,
    required int pageNumber,
    required List<InteractiveLessonChunk> chunks,
  }) = _InteractiveLessonTopicsPage;

  factory InteractiveLessonTopicsPage.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonTopicsPageFromJson(json);
}
