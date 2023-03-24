import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';

part 'add_to_favorites_response.g.dart';

@immutable
@JsonSerializable()
class AddToFavoritesResponse {
  final String brandName;
  final String? foodDescription;
  final String id;
  final String foodName;
  final String foodType;
  final String foodUrl;
  final FoodItemServing serving;

  const AddToFavoritesResponse(
    this.brandName,
    this.foodDescription,
    this.id,
    this.foodName,
    this.foodType,
    this.foodUrl,
    this.serving,
  );

  static AddToFavoritesResponse fromJson(Map<String, dynamic> json) =>
      _$AddToFavoritesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddToFavoritesResponseToJson(this);
}
