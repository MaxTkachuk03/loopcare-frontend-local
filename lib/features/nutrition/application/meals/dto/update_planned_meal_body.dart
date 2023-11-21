import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_planned_meal_body.freezed.dart';

part 'update_planned_meal_body.g.dart';

@freezed
abstract class UpdatePlannedMealBody implements _$UpdatePlannedMealBody {
  const UpdatePlannedMealBody._();

  const factory UpdatePlannedMealBody({
    required List<String> planningDates,
  }) = _UpdatePlannedMealBody;

  factory UpdatePlannedMealBody.fromJson(Map<String, dynamic> json) => _$UpdatePlannedMealBodyFromJson(json);
}
