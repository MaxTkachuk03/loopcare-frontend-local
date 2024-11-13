import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/account/infrastructure/food_preference/dto/food_preference.dart';

part 'food_preferences.freezed.dart';
part 'food_preferences.g.dart';

@freezed
abstract class FoodPreferences implements _$FoodPreferences {
  const FoodPreferences._();

  const factory FoodPreferences({
    required List<FoodPreference>? hates,
    required List<FoodPreference>? dislike,
    required List<FoodPreference>? allergic,
  }) = _FoodPreferences;

  factory FoodPreferences.fromJson(Map<String, dynamic> json) => _$FoodPreferencesFromJson(json);
}
