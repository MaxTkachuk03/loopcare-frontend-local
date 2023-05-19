import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

part 'create_dish_body.freezed.dart';

part 'create_dish_body.g.dart';

@freezed
abstract class CreateDishBody implements _$CreateDishBody {
  const CreateDishBody._();

  const factory CreateDishBody({
    required double numberOfUnits,
    required List<MealCategory> mealCategories,
    required String name,
  }) = _CreateDishBody;

  factory CreateDishBody.fromJson(Map<String, dynamic> json) =>
      _$CreateDishBodyFromJson(json);
}
