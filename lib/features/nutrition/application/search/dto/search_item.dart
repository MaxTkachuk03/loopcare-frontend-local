import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_food_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';

part 'search_item.freezed.dart';
part 'search_item.g.dart';

@freezed
class SearchItem with _$SearchItem {
  const SearchItem._();

  const factory SearchItem({
    required String id,
    required String name,
    String? image,
    SearchFoodItemType? foodItem,
    required SearchItemTypes type,
  }) = _SearchItem;

  String? get brandName => foodItem?.brand;

  String? get servingDescription => foodItem?.servingDescription;

  double? get calories => foodItem?.calories;

  factory SearchItem.fromJson(Map<String, dynamic> json) => _$SearchItemFromJson(json);
}
