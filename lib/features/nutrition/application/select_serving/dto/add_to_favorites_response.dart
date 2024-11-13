import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'add_to_favorites_response.g.dart';

@immutable
@JsonSerializable()
class AddToFavoritesResponse {
  final String? brandName;
  final String? foodDescription;
  final String id;
  final String foodName;
  final String foodType;
  final String foodUrl;
  final ServingSize serving;

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
