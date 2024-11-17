import 'package:freezed_annotation/freezed_annotation.dart';

part 'interactive_lesson_text_area_history.freezed.dart';
part 'interactive_lesson_text_area_history.g.dart';


@freezed
class InteractiveLessonTextAreaHistory with _$InteractiveLessonTextAreaHistory {
  const InteractiveLessonTextAreaHistory._();

  const factory InteractiveLessonTextAreaHistory({
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _InteractiveLessonTextAreaHistory;

  factory InteractiveLessonTextAreaHistory.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonTextAreaHistoryFromJson(json);
}