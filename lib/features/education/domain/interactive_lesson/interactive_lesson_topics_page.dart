import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'interactive_lesson_topics_page.freezed.dart';
part 'interactive_lesson_topics_page.g.dart';

@freezed
class InteractiveLessonTopicsPage with _$InteractiveLessonTopicsPage {
  const InteractiveLessonTopicsPage._();

  const factory InteractiveLessonTopicsPage({
    required int id,
    required String title,
    required int order,
    required int topicId,
    required List<int> chunksIds,
  }) = _InteractiveLessonTopicsPage;

  factory InteractiveLessonTopicsPage.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonTopicsPageFromJson(json);

  factory InteractiveLessonTopicsPage.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing InteractiveLessonTopicsPage: $json');

      // Validate and parse individual fields
      final id = json['id'] as int;
      log.d('Parsed id: $id');

      final title = json['title'] as String;
      log.d('Parsed title: $title');

      final order = json['order'] as int;
      log.d('Parsed pageNumber: $order');

      final topicId = json['topicId'] as int;
      log.d('Parsed topicId: $topicId');

      log.d('Raw chunkIds: ${json['chunkIds']}');

      final chunkIds = (json['chunkIds'] as List).map((e) => e as int).toList();
      log.d('Parsed chunksIds: $chunkIds');

      return InteractiveLessonTopicsPage(
        id: id,
        title: title,
        order: order,
        topicId: topicId,
        chunksIds: chunkIds,
      );
    } catch (e, stackTrace) {
      log.d('Error in InteractiveLessonTopicsPage.fromJson: $e');
      log.d('Stack Trace: $stackTrace');
      log.d('Problematic JSON: $json');
      rethrow; // Propagate the error up the stack
    }
  }
}
