import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/scale_content/scale_content_feedback.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/scale_content/scale_content_value.dart';

part 'scale_content.freezed.dart';
part 'scale_content.g.dart';

@freezed
class ScaleContent with _$ScaleContent {
  const ScaleContent._();

  const factory ScaleContent({
    required String question,
    required String lowestText,
    required String highestText,
    required List<ScaleContentValue> values,
    required List<ScaleContentFeedback>? feedback,
  }) = _ScaleContent;

  bool get hasFeedback => feedback != null && feedback!.isNotEmpty;

  factory ScaleContent.fromJson(Map<String, dynamic> json) => _$ScaleContentFromJson(json);

  factory ScaleContent.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing ScaleContent: $json');

      final question = json['question'] as String? ?? '';
      log.d('Parsed question: $question');

      final lowestText = json['lowestText'] as String? ?? '';
      log.d('Parsed lowestText: $lowestText');

      final highestText = json['highestText'] as String? ?? '';
      log.d('Parsed highestText: $highestText');

      final values = (json['values'] as List<dynamic>?)
              ?.map((e) => ScaleContentValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      log.d('Parsed values: $values');

      final feedback = (json['feedback'] as List<dynamic>?)
          ?.map((e) => ScaleContentFeedback.debugFromJson(e as Map<String, dynamic>))
          .toList();
      log.d('Parsed feedback: $feedback');

      return ScaleContent(
        question: question,
        lowestText: lowestText,
        highestText: highestText,
        values: values,
        feedback: feedback,
      );
    } catch (e, stackTrace) {
      log.e('Error in ScaleContent.debugFromJson: $e', error: e, stackTrace: stackTrace);
      log.e('Problematic JSON: $json');
      rethrow;
    }
  }
}
