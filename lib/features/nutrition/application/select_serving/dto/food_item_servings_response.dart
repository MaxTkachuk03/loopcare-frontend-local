import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';

part 'food_item_servings_response.g.dart';

@immutable
@JsonSerializable()
class FoodItemServingsResponse {
  final List<FoodItemServing> data;

  const FoodItemServingsResponse(this.data);

  static FoodItemServingsResponse fromJson(Map<String, dynamic> json) =>
      _$FoodItemServingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FoodItemServingsResponseToJson(this);
}
