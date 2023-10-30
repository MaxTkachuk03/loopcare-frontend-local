import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recommendations/recommendation_recipe.dart';

part 'recommendations_response.g.dart';

@immutable
@JsonSerializable()
class RecommendationsResponse {
  final List<RecommendationRecipe> data;

  const RecommendationsResponse({
    required this.data,
  });

  static RecommendationsResponse fromJson(Map<String, dynamic> json) =>
      _$RecommendationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationsResponseToJson(this);
}
