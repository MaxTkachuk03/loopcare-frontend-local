import 'package:freezed_annotation/freezed_annotation.dart';

part 'reflection_feedback.freezed.dart';

part 'reflection_feedback.g.dart';

@freezed
class ReflectionFeedback with _$ReflectionFeedback {
  const ReflectionFeedback._();

  const factory ReflectionFeedback({
    required int id,
    required String text,
    required int minValue,
    required int maxValue,
  }) = _ReflectionFeedback;

  factory ReflectionFeedback.fromJson(Map<String, dynamic> json) =>
      _$ReflectionFeedbackFromJson(json);
}
