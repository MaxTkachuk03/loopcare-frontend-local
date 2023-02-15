import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';

part 'food_preference_response.g.dart';

@immutable
@JsonSerializable()
class FoodPreferenceResponse {
  final IList<FoodPreference> data;

  const FoodPreferenceResponse(this.data);

  static FoodPreferenceResponse fromJson(Map<String, dynamic> json) =>
      _$FoodPreferenceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FoodPreferenceResponseToJson(this);
}
