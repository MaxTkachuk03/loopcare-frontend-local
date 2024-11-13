import 'package:freezed_annotation/freezed_annotation.dart';

part 'interactive_lesson_component_progress.freezed.dart';
part 'interactive_lesson_component_progress.g.dart';


@freezed
class InteractiveLessonComponentProgress with _$InteractiveLessonComponentProgress {
  const InteractiveLessonComponentProgress._();

  const factory InteractiveLessonComponentProgress({
    int? optionId,
    List<int>? optionIds,
    List<int>? order,
    String? response,
  }) = _InteractiveLessonComponentProgress;

  factory InteractiveLessonComponentProgress.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonComponentProgressFromJson(json);
}