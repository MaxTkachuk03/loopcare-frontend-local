import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'meals_list_item.freezed.dart';

part 'meals_list_item.g.dart';

@freezed
class MealsListItem with _$MealsListItem {
  const MealsListItem._();

  const factory MealsListItem({
    required int id,
    required List<MealItem> mealItems,
    required DateTime? loggingDate,
    required String mealCategory,
    required double calorieDensity,
    required double proteinDegree,
    required ServingSize serving,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<DateTime>? planningDates,
  }) = _MealItem;

  get order {
    if (mealCategory == 'breakfast') return 1;
    if (mealCategory == 'lunch') return 2;
    if (mealCategory == 'dinner') return 3;
    if (mealCategory == 'inBetweens') return 4;
    if (mealCategory == 'drinks') return 5;
    return 0;
  }

  factory MealsListItem.fromJson(Map<String, dynamic> json) =>
      _$MealsListItemFromJson(json);
}
