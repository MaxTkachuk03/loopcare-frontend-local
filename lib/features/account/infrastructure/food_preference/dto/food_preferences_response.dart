import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/account/infrastructure/food_preference/dto/food_preference.dart';

part 'food_preferences_response.g.dart';

@immutable
@JsonSerializable()
class FoodPreferencesResponse {
  final List<FoodPreference>? hates;
  final List<FoodPreference>? allergic;
  final List<FoodPreference>? dislike;
  final int? period;

  const FoodPreferencesResponse({
    required this.hates,
    required this.allergic,
    required this.dislike,
    required this.period,
  });

  static FoodPreferencesResponse fromJson(Map<String, dynamic> json) =>
      _$FoodPreferencesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FoodPreferencesResponseToJson(this);
}
