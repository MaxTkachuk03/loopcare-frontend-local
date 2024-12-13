import 'dart:convert';

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
      // Safely handle stringified JSON or null
      List<dynamic> mealsList = [];

      if (rawMeals != null) {
        try {
          if (rawMeals is String) {
            // Decode the stringified JSON
            mealsList = jsonDecode(rawMeals) as List<dynamic>;
            log.d('Decoded mealsList: $mealsList');
          } else if (rawMeals is List<dynamic>) {
            // Handle case where it is already a List
            mealsList = rawMeals;
          } else {
            log.e('Unexpected type for rawMeals: ${rawMeals.runtimeType}');
          }
        } catch (e) {
          log.e('Error decoding injected meals: $e');
        }
      } else {
        log.d('Injected meals is null');
      }

// Now you can map the mealsList to your model
      final parsedMeals = mealsList
          .map((meal) => MealsListItem.debugFromJson(meal as Map<String, dynamic>))
          .toList();

      log.d('parsedMeals field: $parsedMeals');

      final meals = parsedMeals.map((e) {
        if (e is Map<String, dynamic>) {
          log.d('Raw meal item: $e');
          return MealsListItem.debugFromJson(e as Map<String, dynamic>);
        } else {
          log.d('Meal item already parsed: $e');
          return e; // Already deserialized
        }
      }).toList();
      log.d('Parsed meals: $meals');

      return MealTimingContent(
        question: question,
        meals: meals,
      );
    } catch (e, stackTrace) {
      log.e('Error in MealTimingContent.debugFromJson: $e');
      log.e('Stack Trace: $stackTrace');
      log.e('Problematic JSON: $json');
      rethrow;
    }
  }
}
