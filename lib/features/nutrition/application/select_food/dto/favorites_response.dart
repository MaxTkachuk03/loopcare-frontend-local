import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/favorites_item/favorites_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';

part 'favorites_response.g.dart';

@immutable
@JsonSerializable()
class FavoritesResponse {
  final List<FavoritesItem> data;

  const FavoritesResponse(this.data);

  static FavoritesResponse fromJson(Map<String, dynamic> json) =>
      _$FavoritesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritesResponseToJson(this);
}
