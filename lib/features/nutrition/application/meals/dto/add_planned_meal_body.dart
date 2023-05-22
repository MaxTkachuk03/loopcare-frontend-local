import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_planned_meal_body.freezed.dart';

part 'add_planned_meal_body.g.dart';

@freezed
abstract class AddPlannedMealBody implements _$AddPlannedMealBody {
  const factory AddPlannedMealBody({
    required List<String> planningDates,
    required String mealCategory,
  }) = _AddPlannedMealBody;

  const AddPlannedMealBody._();

  factory AddPlannedMealBody.fromJson(Map<String, dynamic> json) =>
      _$AddPlannedMealBodyFromJson(json);
}
