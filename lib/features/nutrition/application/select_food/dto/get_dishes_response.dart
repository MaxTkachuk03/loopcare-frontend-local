import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';

part 'get_dishes_response.g.dart';

@immutable
@JsonSerializable()
class GetDishesResponse {
  final List<Dish> data;

  const GetDishesResponse(this.data);

  static GetDishesResponse fromJson(Map<String, dynamic> json) => _$GetDishesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDishesResponseToJson(this);
}
