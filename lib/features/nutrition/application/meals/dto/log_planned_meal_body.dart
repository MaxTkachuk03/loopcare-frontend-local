import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_planned_meal_body.freezed.dart';

part 'log_planned_meal_body.g.dart';

@freezed
abstract class LogPlannedMealBody implements _$LogPlannedMealBody {
  const factory LogPlannedMealBody({
    required String loggingDate,
    required int plannedMealId,
  }) = _LogPlannedMealBody;

  const LogPlannedMealBody._();

  factory LogPlannedMealBody.fromJson(Map<String, dynamic> json) =>
      _$LogPlannedMealBodyFromJson(json);
}
