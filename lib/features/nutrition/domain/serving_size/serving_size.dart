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
    required String? servingId,
    required bool? isSelectedFavorite,
    required double calcium,
    required double calories,
    required double carbohydrate,
    required double cholesterol,
    required double fat,
    required double fiber,
    required double? iron,
    required String? measurementDescription,
    required double? metricServingAmount,
    required String? metricServingUnit,
    required double? monounsaturatedFat,
    required double numberOfUnits,
    required double? polyunsaturatedFat,
    required double? potassium,
    required double protein,
    required double saturatedFat,
    required String? servingDescription,
    required String? servingUrl,
    required double? sodium,
    required double? sugar,
    required double? transFat,
    required double? vitaminA,
    required double? vitaminC,
    required List<String>? favoriteMealCategories,
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
    var metricServingUnitLabel = metricServingUnit != null ? ' $metricServingUnit' : '';

    return '$measurementDescription ($metricServingAmount$metricServingUnitLabel)';
  }

  String get servingSizeLabel {
    return '${numberOfUnits.removeDecimalZeroFormat()} ${measurementDescription ?? 'serving'}';
  }

  factory ServingSize.fromJson(Map<String, dynamic> json) => _$ServingSizeFromJson(json);
}
