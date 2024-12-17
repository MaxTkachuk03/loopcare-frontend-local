import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

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

  factory MealTimingContent.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing MealTimingContent: $json');

      // Parse and validate individual fields
      final question = json['question'] as String? ?? '';
      log.d('Parsed question: $question');

      // use 'injected' so we have generic DTO on server
      // will need to convert to a known JSON DTO object on
      // flutter side per component

      final rawMeals = json['injected'];
      List<dynamic> mealsList = [];

// Handle the case where injected meals are already a List or null
      if (rawMeals != null) {
        if (rawMeals is List<dynamic>) {
          mealsList = rawMeals;
          log.d('Injected meals as List: $mealsList');
        } else {
          log.e('Unexpected type for rawMeals: ${rawMeals.runtimeType}');
          throw Exception('Injected meals must be a List<dynamic>');
        }
      } else {
        log.d('Injected meals is null');
      }

// Now map mealsList to your model
      final parsedMeals =
          mealsList.map((meal) => MealsListItem.fromJson(meal as Map<String, dynamic>)).toList();

      log.d('Parsed meals: $parsedMeals');

      return MealTimingContent(
        question: question,
        meals: parsedMeals,
      );
    } catch (e, stackTrace) {
      log.e('Error in MealTimingContent.debugFromJson: $e');
      log.e('Stack Trace: $stackTrace');
      log.e('Problematic JSON: $json');
      rethrow;
    }
  }
}
