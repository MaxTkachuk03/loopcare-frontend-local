import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'scale_content_feedback.freezed.dart';
part 'scale_content_feedback.g.dart';

@freezed
class ScaleContentFeedback with _$ScaleContentFeedback {
  const factory ScaleContentFeedback({
    required int id,
    required int minValue,
    required int maxValue,
    required String text,
  }) = _ScaleContentFeedback;

  factory ScaleContentFeedback.fromJson(Map<String, dynamic> json) =>
      _$ScaleContentFeedbackFromJson(json);
  factory ScaleContentFeedback.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing ScaleContentFeedback: $json');

      final id = json['id'] as int;
      log.d('Parsed id: $id');

      final minValue = json['minValue'] as int;
      log.d('Parsed minValue: $minValue');

      final maxValue = json['maxValue'] as int;
      log.d('Parsed maxValue: $maxValue');

      final text = json['text'] as String? ?? '';
      log.d('Parsed text: $text');

      return ScaleContentFeedback(
        id: id,
        minValue: minValue,
        maxValue: maxValue,
        text: text,
      );
    } catch (e, stackTrace) {
      log.e('Error in ScaleContentFeedback.debugFromJson: $e', error: e, stackTrace: stackTrace);
      log.e('Problematic JSON: $json');
      rethrow;
    }
  }
}
