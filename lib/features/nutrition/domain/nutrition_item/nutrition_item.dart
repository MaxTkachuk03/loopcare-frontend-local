import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_item.freezed.dart';

part 'nutrition_item.g.dart';

@freezed
abstract class NutritionItem implements _$NutritionItem {
  const NutritionItem._();

  const factory NutritionItem({
    required String name,
    required String key,
    required double value,
    required String unitLabel,
  }) = _NutritionItem;

  factory NutritionItem.fromJson(Map<String, dynamic> json) => _$NutritionItemFromJson(json);
}
