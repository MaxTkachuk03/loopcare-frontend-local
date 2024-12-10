import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';

part 'meal_timing_content.freezed.dart';
part 'meal_timing_content.g.dart';

@freezed
class MealTimingContent with _$MealTimingContent {
  const factory MealTimingContent({
    required String question,
    required List<MealsListItem> meals,
  }) = _MealTimingContent;

  factory MealTimingContent.fromJson(Map<String, dynamic> json) =>
      _$MealTimingContentFromJson(json);
}
