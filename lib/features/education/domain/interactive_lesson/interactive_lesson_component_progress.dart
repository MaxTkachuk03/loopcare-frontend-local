import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_text_area_history.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

part 'interactive_lesson_component_progress.freezed.dart';

part 'interactive_lesson_component_progress.g.dart';

@freezed
class InteractiveLessonComponentProgress
    with _$InteractiveLessonComponentProgress {
  const InteractiveLessonComponentProgress._();

  const factory InteractiveLessonComponentProgress({
    List<int>? optionIds,
    List<int>? order,
    String? text,
    int? survey,
    MealCategory? mealCategory,
    required String type,
    List<InteractiveLessonTextAreaHistory>? history,
  }) = _InteractiveLessonComponentProgress;

  factory InteractiveLessonComponentProgress.fromJson(
          Map<String, dynamic> json) =>
      _$InteractiveLessonComponentProgressFromJson(json);
}
