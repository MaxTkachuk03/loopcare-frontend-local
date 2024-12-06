import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'interactive_lesson_chunk.freezed.dart';
part 'interactive_lesson_chunk.g.dart';

@freezed
class InteractiveLessonChunk with _$InteractiveLessonChunk {
  const InteractiveLessonChunk._();

  const factory InteractiveLessonChunk({
    required int id,
    required String title,
    required int pageId,
    required List<int> componentsIds,
  }) = _InteractiveLessonChunk;

  factory InteractiveLessonChunk.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonChunkFromJson(json);

  factory InteractiveLessonChunk.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing InteractiveLessonChunk: $json');

      // Validate and parse individual fields
      final id = json['id'] as int;
      log.d('Parsed id: $id');

      final title = json['title'] as String;
      log.d('Parsed title: $title');

      final pageId = json['pageId'] as int;
      log.d('Parsed pageId: $pageId');

      final componentsIds = (json['componentIds'] as List).map((e) => e as int).toList();
      log.d('Parsed componentsIds: $componentsIds');

      return InteractiveLessonChunk(
        id: id,
        title: title,
        pageId: pageId,
        componentsIds: componentsIds,
      );
    } catch (e, stackTrace) {
      log.d('Error in InteractiveLessonChunk.fromJson: $e');
      log.d('Stack Trace: $stackTrace');
      log.d('Problematic JSON: $json');
      rethrow; // Propagate the error up the stack
    }
  }
}
