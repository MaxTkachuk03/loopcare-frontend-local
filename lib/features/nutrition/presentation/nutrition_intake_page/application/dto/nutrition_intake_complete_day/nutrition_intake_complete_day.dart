import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_intake_complete_day.g.dart';
part 'nutrition_intake_complete_day.freezed.dart';

@freezed
class NutritionIntakeCompleteDay with _$NutritionIntakeCompleteDay {
  const factory NutritionIntakeCompleteDay({
    required String message,
    required bool isDayClosed,
  }) = _NutritionIntakeCompleteDay;

  factory NutritionIntakeCompleteDay.fromJson(Map<String, dynamic> json) =>
      _$NutritionIntakeCompleteDayFromJson(json);
}
