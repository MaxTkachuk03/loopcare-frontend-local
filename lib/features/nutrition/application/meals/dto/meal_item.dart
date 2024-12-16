import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'meal_item.freezed.dart';

part 'meal_item.g.dart';

@freezed
class MealItem with _$MealItem {
  const MealItem._();

  const factory MealItem({
    required String? description,
    required double calorieDensity,
    required double? proteinDegree,
    required int id,
    required String? externalId,
    required String name,
    required MealItemType type,
    required ServingSize serving,
    required bool excludedFromCalculations,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MealItem;

  double get servingCalories => serving.calories;

  double get servingFiber => serving.fiber;

  double get servingCarbs => serving.carbohydrate;

  double get servingWeight => serving.metricServingAmount;

  double get servingProtein => serving.protein;

  bool get hasWeight => serving.metricServingAmount != 0;

  factory MealItem.fromJson(Map<String, dynamic> json) => _$MealItemFromJson(json);

  factory MealItem.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing MealItem: $json');

      // Parse and validate each field
      final id = json['id'] as int? ?? 0;
      log.d('Parsed id: $id');

      final description = json['description'] as String?;
      log.d('Parsed description: $description');

      final calorieDensity = (json['calorieDensity'] as num?)?.toDouble() ?? 0.0;
      log.d('Parsed calorieDensity: $calorieDensity');

      final proteinDegree = (json['proteinDegree'] as num?)?.toDouble();
      log.d('Parsed proteinDegree: $proteinDegree');

      final externalId = json['externalId'] as String?;
      log.d('Parsed externalId: $externalId');

      final name = json['name'] as String? ?? '';
      log.d('Parsed name: $name');

      final type = MealItemType.values.firstWhere(
            (e) => e.toString().split('.').last == json['type'],
        orElse: () => throw Exception('Invalid type value: ${json['type']}'),
      );
      log.d('Parsed type: $type');

      final serving = json['serving'] != null
          ? ServingSize.fromJson(json['serving'] as Map<String, dynamic>)
          : throw Exception('Missing "serving" field');
      log.d('Parsed serving: $serving');

      final excludedFromCalculations = json['excludedFromCalculations'] as bool? ?? false;
      log.d('Parsed excludedFromCalculations: $excludedFromCalculations');

      final createdAt = DateTime.parse(json['createdAt'] as String);
      log.d('Parsed createdAt: $createdAt');

      final updatedAt = DateTime.parse(json['updatedAt'] as String);
      log.d('Parsed updatedAt: $updatedAt');

      return MealItem(
        description: description,
        calorieDensity: calorieDensity,
        proteinDegree: proteinDegree,
        id: id,
        externalId: externalId,
        name: name,
        type: type,
        serving: serving,
        excludedFromCalculations: excludedFromCalculations,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
    } catch (e, stackTrace) {
      log.e('Error in MealItem.debugFromJson: $e');
      log.e('Stack Trace: $stackTrace');
      log.e('Problematic JSON: $json');
      rethrow;
    }
  }
}
