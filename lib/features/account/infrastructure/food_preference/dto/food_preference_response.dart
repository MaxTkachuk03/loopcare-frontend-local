import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/account/infrastructure/food_preference/dto/food_preference.dart';

part 'food_preference_response.g.dart';

@immutable
@JsonSerializable()
class FoodPreferenceResponse {
  final List<FoodPreference> data;

  const FoodPreferenceResponse(this.data);

  static FoodPreferenceResponse fromJson(Map<String, dynamic> json) =>
      _$FoodPreferenceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FoodPreferenceResponseToJson(this);
}
