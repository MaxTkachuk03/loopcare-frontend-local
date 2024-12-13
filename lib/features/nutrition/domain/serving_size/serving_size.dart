import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/utils/double_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';

part 'serving_size.freezed.dart';

part 'serving_size.g.dart';

@freezed
abstract class ServingSize implements _$ServingSize {
  const ServingSize._();

  const factory ServingSize({
    @Default(null) String? servingId,
    @Default(false) bool isSelectedFavorite,
    @Default(0) double calcium,
    @Default(0) double calories,
    @Default(0) double carbohydrate,
    @Default(0) double cholesterol,
    @Default(0) double fat,
    @Default(0) double fiber,
    @Default(0) double? iron,
    @Default('') String measurementDescription,
    @Default(0) double metricServingAmount,
    @Default('') String metricServingUnit,
    @Default(0) double monounsaturatedFat,
    @Default(0) double numberOfUnits,
    @Default(0) double polyunsaturatedFat,
    @Default(0) double potassium,
    @Default(0) double protein,
    @Default(0) double saturatedFat,
    @Default('') String servingDescription,
    @Default('') String servingUrl,
    @Default(0) double sodium,
    @Default(0) double sugar,
    @Default(0) double transFat,
    @Default(0) double vitaminA,
    @Default(0) double vitaminC,
    @Default([]) List<String>? favoriteMealCategories,
  }) = _ServingSize;

  List<NutritionItem> get list {
    final beforeCapitalLetter = RegExp(r"(?=[A-Z])");

    return toJson()
        .entries
        .map((entry) {
          final nutritionValueType =
              NutritionValuesTypes.values.firstWhereOrNull((element) => element.name == entry.key);

          if (nutritionValueType == null) return null;

          return NutritionItem(
            name: entry.key.split(beforeCapitalLetter).join(' ').capitalizeOnlyFirstLetter(),
            key: entry.key,
            value: entry.value,
            unitLabel: nutritionValueType.unitLabel,
          );
        })
        .whereType<NutritionItem>()
        .toList();
  }

  String get servingLabel {
    var metricServingUnitLabel = ' $metricServingUnit';

    return '$measurementDescription ($metricServingAmount$metricServingUnitLabel)';
  }

  String get servingSizeLabel {
    return '${numberOfUnits.removeDecimalZeroFormat()} $measurementDescription';
  }

  factory ServingSize.fromJson(Map<String, dynamic> json) => _$ServingSizeFromJson(json);
}
