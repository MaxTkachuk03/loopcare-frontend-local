import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_food_item_type.freezed.dart';
part 'search_food_item_type.g.dart';

@freezed
class SearchFoodItemType with _$SearchFoodItemType {
  const factory SearchFoodItemType({
    required String brand,
    required String servingDescription,
    required double calories,
  }) = _SearchFoodItemType;

  factory SearchFoodItemType.fromJson(Map<String, dynamic> json) =>
      _$SearchFoodItemTypeFromJson(json);
}
