import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_food_items_list_element.freezed.dart';

part 'add_food_items_list_element.g.dart';

@freezed
class AddFoodItemsListElement with _$AddFoodItemsListElement {
  const factory AddFoodItemsListElement({
    required double numberOfUnits,
    required String servingId,
    required String externalFoodItemId,
  }) = _AddFoodItemsListElement;

  factory AddFoodItemsListElement.fromJson(Map<String, dynamic> json) =>
      _$AddFoodItemsListElementFromJson(json);
}
