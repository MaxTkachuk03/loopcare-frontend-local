import 'package:freezed_annotation/freezed_annotation.dart';

part 'interactive_lesson_topics_page.freezed.dart';
part 'interactive_lesson_topics_page.g.dart';

@freezed
class InteractiveLessonTopicsPage with _$InteractiveLessonTopicsPage {
  const InteractiveLessonTopicsPage._();

  const factory InteractiveLessonTopicsPage({
    required int id,
    required String title,
    required int pageNumber,
    required int topicId,
    required List<int> chunksIds,
  }) = _InteractiveLessonTopicsPage;

  factory InteractiveLessonTopicsPage.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonTopicsPageFromJson(json);
}
