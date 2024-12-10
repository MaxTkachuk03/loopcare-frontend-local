import 'package:freezed_annotation/freezed_annotation.dart';
import 'content_select_answer.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'select_content.freezed.dart';
part 'select_content.g.dart';

@freezed
class SelectContent with _$SelectContent {
  const factory SelectContent({
    required String question,
    required List<ContentSelectAnswer> answers,
    @Default(null) String? feedbackCorrect,
    @Default(null) String? feedbackIncorrect,
  }) = _SelectContent;

  factory SelectContent.fromJson(Map<String, dynamic> json) => _$SelectContentFromJson(json);

  factory SelectContent.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing SelectContent: $json');

      // Parse individual fields with debug information
      final question = json['question'] as String;
      log.d('Parsed question: $question');

      log.d('Raw answers field: ${json['answers']}');
      log.d('Answers type: ${json['answers'].runtimeType}');

      final answers = (json['answers'] as List<dynamic>)
          .map((e) => ContentSelectAnswer.debugFromJson(e as Map<String, dynamic>))
          .toList();
      log.d('Parsed answers: $answers');

      final feedbackCorrect = json['feedbackCorrect'] as String?;
      log.d('Parsed feedbackCorrect: $feedbackCorrect');

      final feedbackIncorrect = json['feedbackIncorrect'] as String?;
      log.d('Parsed feedbackIncorrect: $feedbackIncorrect');

      // Return the parsed object
      return SelectContent(
        question: question,
        answers: answers,
        feedbackCorrect: feedbackCorrect,
        feedbackIncorrect: feedbackIncorrect,
      );
    } catch (e, stackTrace) {
      log.w('Error in SelectContent.debugFromJson: $e');
      log.w('Stack Trace: $stackTrace');
      log.i('Problematic JSON: $json');
      rethrow;
    }
  }
}
