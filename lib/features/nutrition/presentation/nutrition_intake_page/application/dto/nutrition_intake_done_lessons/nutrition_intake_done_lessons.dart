import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_intake_done_lessons.g.dart';
part 'nutrition_intake_done_lessons.freezed.dart';

@freezed
class NutritionIntakeDoneLessons with _$NutritionIntakeDoneLessons {
  const factory NutritionIntakeDoneLessons({
    required int iLessonId,
    required String categoryName,
    required bool isLessonFinished,
  }) = _NutritionIntakeDoneLessons;

  factory NutritionIntakeDoneLessons.fromJson(Map<String, dynamic> json) =>
      _$NutritionIntakeDoneLessonsFromJson(json);
}
