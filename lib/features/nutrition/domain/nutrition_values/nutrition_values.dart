import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values/nutrition_values_types.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

part 'nutrition_values.freezed.dart';

part 'nutrition_values.g.dart';

@freezed
abstract class NutritionValues implements _$NutritionValues {
  const NutritionValues._();

  const factory NutritionValues({
    required double calcium,
    required double calories,
    required double carbohydrate,
    required double cholesterol,
    required double fat,
    required double fiber,
    required double iron,
    required double monounsaturatedFat,
    required double polyunsaturatedFat,
    required double potassium,
    required double protein,
    required double saturatedFat,
    required double sodium,
    required double sugar,
    required double transFat,
    required double vitaminA,
    required double vitaminC,
  }) = _NutritionValues;

  List<NutritionItem> get list {
    final beforeCapitalLetter = RegExp(r"(?=[A-Z])");

    return toJson().entries.map((entry) {
      final nutritionValueType = NutritionValuesTypes.values
          .firstWhere((element) => element.name == entry.key);

      return NutritionItem(
        name: entry.key
            .split(beforeCapitalLetter)
            .join(' ')
            .capitalizeOnlyFirstLetter(),
        key: entry.key,
        unitLabel: nutritionValueType.unitLabel,
      );
    }).toList();
  }

  factory NutritionValues.fromJson(Map<String, dynamic> json) =>
      _$NutritionValuesFromJson(json);
}
