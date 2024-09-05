import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_preference.freezed.dart';

part 'food_preference.g.dart';

@freezed
abstract class FoodPreference implements _$FoodPreference {
  const FoodPreference._();

  const factory FoodPreference({
    required int id,
    required String name,
  }) = _FoodPreference;

  factory FoodPreference.fromJson(Map<String, dynamic> json) => _$FoodPreferenceFromJson(json);
}
