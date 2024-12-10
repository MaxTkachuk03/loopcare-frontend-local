import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/nutrition_intake_done_lessons/nutrition_intake_done_lessons.dart';

part 'get_nutrition_intake_response.freezed.dart';
part 'get_nutrition_intake_response.g.dart';

@freezed
class GetNutritionIntakeResponse with _$GetNutritionIntakeResponse {
  const GetNutritionIntakeResponse._();

  factory GetNutritionIntakeResponse({
    required bool isDayClosed,
    required List<NutritionIntakeDoneLessons> progress,
  }) = _GetNutritionIntakeResponse;

  factory GetNutritionIntakeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetNutritionIntakeResponseFromJson(json);
}
