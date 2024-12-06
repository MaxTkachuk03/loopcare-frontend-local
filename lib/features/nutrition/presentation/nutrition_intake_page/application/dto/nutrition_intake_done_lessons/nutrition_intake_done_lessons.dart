import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_intake_done_lessons.g.dart';
part 'nutrition_intake_done_lessons.freezed.dart';

@freezed
class NitritionIntakeDoneLessons with _$NitritionIntakeDoneLessons{
  const factory NitritionIntakeDoneLessons({
    required int categoryId,
    required bool isCompleted,
  }) = _NitritionIntakeDoneLessons;

   factory NitritionIntakeDoneLessons.fromJson(Map<String, dynamic> json) =>
      _$NitritionIntakeDoneLessonsFromJson(json);

  
}
