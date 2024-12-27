import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/infrastructure/services/logger/logger.dart';

part 'interactive_lesson_text_area_history.freezed.dart';
part 'interactive_lesson_text_area_history.g.dart';

@freezed
class InteractiveLessonHistory with _$InteractiveLessonHistory {
  const InteractiveLessonHistory._();

  const factory InteractiveLessonHistory({
    int? id,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _InteractiveLessonHistory;

  factory InteractiveLessonHistory.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonHistoryFromJson(json);

  factory InteractiveLessonHistory.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing InteractiveLessonHistory: $json');

      final id = json['id'] != null
          ? (json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()))
          : null;
      log.d('History ID: $id');
      // Parse individual fields with debug output
      final text = json['text'] as String;
      log.d('Parsed text: $text');

      final createdAt =
          json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null;
      log.d('Parsed createdAt: $createdAt');

      final updatedAt =
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null;
      log.d('Parsed updatedAt: $updatedAt');

      // Return parsed object
      return InteractiveLessonHistory(
        id: id,
        text: text,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
    } catch (e, stackTrace) {
      log.w('Error in InteractiveLessonHistory.debugFromJson: $e');
      log.d('Stack Trace: $stackTrace');
      log.d('Problematic JSON: $json');
      rethrow;
    }
  }
}
