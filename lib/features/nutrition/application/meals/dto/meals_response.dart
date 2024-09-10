import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';

part 'meals_response.g.dart';

@immutable
@JsonSerializable()
class MealsResponse {
  final List<MealsListItem> data;

  const MealsResponse(this.data);

  static MealsResponse fromJson(Map<String, dynamic> json) => _$MealsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealsResponseToJson(this);
}
