import 'package:freezed_annotation/freezed_annotation.dart';

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
}
