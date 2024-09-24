import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_feedback.freezed.dart';
part 'content_feedback.g.dart';

@freezed
class ContentFeedback with _$ContentFeedback {
  const factory ContentFeedback({
    required String correct,
    required String incorrect,
    required String? revealed,
  }) = _ContentFeedback;

  factory ContentFeedback.fromJson(Map<String, dynamic> json) => _$ContentFeedbackFromJson(json);
}
