import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_food_item_to_dish_body.freezed.dart';

part 'add_food_item_to_dish_body.g.dart';

@freezed
abstract class AddFoodItemToDishBody implements _$AddFoodItemToDishBody {
  const AddFoodItemToDishBody._();

  const factory AddFoodItemToDishBody({
    required double numberOfUnits,
    required String servingId,
    required String externalFoodItemId,
  }) = _AddFoodItemToDishBody;

  factory AddFoodItemToDishBody.fromJson(Map<String, dynamic> json) =>
      _$AddFoodItemToDishBodyFromJson(json);
}
