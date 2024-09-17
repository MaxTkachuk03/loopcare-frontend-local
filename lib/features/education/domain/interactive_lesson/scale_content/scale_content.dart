import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/scale_content/scale_content_feedback.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/scale_content/scale_content_value.dart';

part 'scale_content.freezed.dart';
part 'scale_content.g.dart';

@freezed
class ScaleContent with _$ScaleContent {
  const factory ScaleContent({
    required String question,
    required String lowestText,
    required String highestText,
    required List<ScaleContentValue> values,
    required List<ScaleContentFeedback> feedback,
  }) = _ScaleContent;

  factory ScaleContent.fromJson(Map<String, dynamic> json) => _$ScaleContentFromJson(json);
}
