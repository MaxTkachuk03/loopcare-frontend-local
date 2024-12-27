import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_text_area_history.dart';

import '../../../../core/infrastructure/services/logger/logger.dart';

part 'interactive_lesson_component_progress.freezed.dart';

part 'interactive_lesson_component_progress.g.dart';

@freezed
class InteractiveLessonComponentProgress with _$InteractiveLessonComponentProgress {
  const InteractiveLessonComponentProgress._();

  const factory InteractiveLessonComponentProgress({
    List<int>? optionIds,
    List<int>? order,
    String? text,
    int? survey,
    required String type,
    List<InteractiveLessonHistory>? history,
  }) = _InteractiveLessonComponentProgress;

  factory InteractiveLessonComponentProgress.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonComponentProgressFromJson(json);

  factory InteractiveLessonComponentProgress.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing InteractiveLessonComponentProgress: $json');

      // Parse individual fields with debug output
      final optionIds = (json['optionIds'] as List<dynamic>?)?.map((e) => e as int).toList();
      log.d('Parsed optionIds: $optionIds');

      final order = (json['order'] as List<dynamic>?)?.map((e) => e as int).toList();
      log.d('Parsed order: $order');

      final text = json['text'] as String?;
      log.d('Parsed text: $text');

      final survey = json['survey'] as int?;
      log.d('Parsed survey: $survey');

      final type = json['type'] as String;
      log.d('Parsed type: $type');

      final history = (json['history'] as List<dynamic>?)
          ?.map((e) => InteractiveLessonHistory.debugFromJson(e as Map<String, dynamic>))
          .toList();
      log.d('Parsed history: $history');

      // Return parsed object
      return InteractiveLessonComponentProgress(
        optionIds: optionIds,
        order: order,
        text: text,
        survey: survey,
        type: type,
        history: history,
      );
    } catch (e, stackTrace) {
      log.w('Error in InteractiveLessonComponentProgress.debugFromJson: $e');
      log.d('Stack Trace: $stackTrace');
      log.d('Problematic JSON: $json');
      rethrow;
    }
  }
}
