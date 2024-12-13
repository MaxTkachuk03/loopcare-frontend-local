import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'content_select_answer.freezed.dart';
part 'content_select_answer.g.dart';

@freezed
class ContentSelectAnswer with _$ContentSelectAnswer {
  const factory ContentSelectAnswer({
    required int id,
    required String label,
    @Default(null) bool? isCorrect,
  }) = _ContentSelectAnswer;

  factory ContentSelectAnswer.fromJson(Map<String, dynamic> json) =>
      _$ContentSelectAnswerFromJson(json);

  factory ContentSelectAnswer.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing ContentSelectAnswer: $json');

      // Parse individual fields with debug information
      final id = json['externalId'] as int;
      log.d('Parsed id: $id');

      final label = json['label'] as String;
      log.d('Parsed label: $label');

      final isCorrect = json['isCorrect'] as bool?;
      log.d('Parsed isCorrect: $isCorrect');

      // Return the parsed object
      return ContentSelectAnswer(
        id: id,
        label: label,
        isCorrect: isCorrect,
      );
    } catch (e, stackTrace) {
      log.w('Error in ContentSelectAnswer.debugFromJson: $e');
      log.w('Stack Trace: $stackTrace');
      log.i('Problematic JSON: $json');
      rethrow;
    }
  }
}
