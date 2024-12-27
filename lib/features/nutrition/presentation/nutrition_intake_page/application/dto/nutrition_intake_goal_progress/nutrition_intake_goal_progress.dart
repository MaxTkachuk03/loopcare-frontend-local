import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_intake_goal_progress.g.dart';
part 'nutrition_intake_goal_progress.freezed.dart';

@freezed
class NutritionIntakeGoalProgress with _$NutritionIntakeGoalProgress {
  const factory NutritionIntakeGoalProgress({
    required int iLessonId,
    required String categoryName,
    required bool isLessonFinished,
  }) = _NutritionIntakeGoalProgress;

  factory NutritionIntakeGoalProgress.fromJson(Map<String, dynamic> json) =>
      _$NutritionIntakeGoalProgressFromJson(json);
}
