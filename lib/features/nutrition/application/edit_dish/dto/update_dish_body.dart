import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

part 'update_dish_body.freezed.dart';

part 'update_dish_body.g.dart';

@freezed
abstract class UpdateDishBody implements _$UpdateDishBody {
  const UpdateDishBody._();

  const factory UpdateDishBody({
    required double numberOfUnits,
    required double numberOfServings,
    required List<MealCategory> mealCategories,
    required String name,
  }) = _UpdateDishBody;

  factory UpdateDishBody.fromJson(Map<String, dynamic> json) => _$UpdateDishBodyFromJson(json);
}
