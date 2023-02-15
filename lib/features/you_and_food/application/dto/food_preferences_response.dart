import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_preferences_response.g.dart';

@immutable
@JsonSerializable()
class FoodPreferencesResponse {
  final IList<int>? hates;
  final IList<int>? allergic;
  final IList<int>? dislike;
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
