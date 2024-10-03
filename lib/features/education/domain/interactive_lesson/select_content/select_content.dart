import 'package:freezed_annotation/freezed_annotation.dart';
import 'content_select_answer.dart';

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
}
