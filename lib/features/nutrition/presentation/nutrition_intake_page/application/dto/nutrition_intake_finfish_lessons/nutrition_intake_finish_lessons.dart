import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_intake_finish_lessons.g.dart';
part 'nutrition_intake_finish_lessons.freezed.dart';

@freezed
class NutritionIntakeFinishLessons with _$NutritionIntakeFinishLessons {
  const factory NutritionIntakeFinishLessons({
    required String message,
    required bool isLessonFinished,
  }) = _NutritionIntakeFinishLessons;

  factory NutritionIntakeFinishLessons.fromJson(Map<String, dynamic> json) =>
      _$NutritionIntakeFinishLessonsFromJson(json);
}
