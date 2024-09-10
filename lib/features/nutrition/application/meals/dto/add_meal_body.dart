import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_meal_body.freezed.dart';

part 'add_meal_body.g.dart';

@freezed
abstract class AddMealBody implements _$AddMealBody {
  const factory AddMealBody({
    required String loggingDate,
    required String mealCategory,
  }) = _AddMealBody;

  const AddMealBody._();

  factory AddMealBody.fromJson(Map<String, dynamic> json) => _$AddMealBodyFromJson(json);
}
