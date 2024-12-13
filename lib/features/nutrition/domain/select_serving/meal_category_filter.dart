import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_category_filter.freezed.dart';

part 'meal_category_filter.g.dart';

@freezed
abstract class MealCategoryFilter implements _$MealCategoryFilter {
  const MealCategoryFilter._();

  const factory MealCategoryFilter({
    required String name,
    required String title,
    required bool selected,
  }) = _MealCategoryFilter;

  factory MealCategoryFilter.fromJson(Map<String, dynamic> json) =>
      _$MealCategoryFilterFromJson(json);
}
