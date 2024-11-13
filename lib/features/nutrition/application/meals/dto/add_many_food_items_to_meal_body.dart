import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_items_list_element.dart';

part 'add_many_food_items_to_meal_body.freezed.dart';

part 'add_many_food_items_to_meal_body.g.dart';

@freezed
abstract class AddManyFoodItemsToMealBody implements _$AddManyFoodItemsToMealBody {
  const factory AddManyFoodItemsToMealBody({
    required List<AddFoodItemsListElement> foodItems,
  }) = _AddManyFoodItemsToMealBody;

  const AddManyFoodItemsToMealBody._();

  factory AddManyFoodItemsToMealBody.fromJson(Map<String, dynamic> json) =>
      _$AddManyFoodItemsToMealBodyFromJson(json);
}
