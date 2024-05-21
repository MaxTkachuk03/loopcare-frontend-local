import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_description_item.freezed.dart';

part 'nutrition_description_item.g.dart';

@freezed
class NutritionValueDescriptionItem with _$NutritionValueDescriptionItem {
  const NutritionValueDescriptionItem._();

  const factory NutritionValueDescriptionItem({
    required double minValue,
    required double maxValue,
    required String description,
    required String label,
  }) = _NutritionValueDescriptionItem;

  factory NutritionValueDescriptionItem.fromJson(Map<String, dynamic> json) =>
      _$NutritionValueDescriptionItemFromJson(json);
}
