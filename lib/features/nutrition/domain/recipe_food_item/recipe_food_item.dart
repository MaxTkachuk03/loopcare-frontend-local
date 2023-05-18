import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'recipe_food_item.freezed.dart';

part 'recipe_food_item.g.dart';

@freezed
abstract class RecipeFoodItem implements _$RecipeFoodItem {
  const RecipeFoodItem._();

  const factory RecipeFoodItem({
    required String id,
    required String externalId,
    required String foodName,
    required String foodType,
    required String brandName,
    required String? foodDescription,
    required ServingSize serving,
  }) = _RecipeFoodItem;

  factory RecipeFoodItem.fromJson(Map<String, dynamic> json) =>
      _$RecipeFoodItemFromJson(json);
}
