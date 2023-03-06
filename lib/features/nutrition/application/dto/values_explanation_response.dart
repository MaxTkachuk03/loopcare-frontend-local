import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/nutrition_value.dart';

part 'values_explanation_response.g.dart';

@immutable
@JsonSerializable()
class ValuesExplanationResponse {
  final List<NutritionValue> data;

  const ValuesExplanationResponse(this.data);

  static ValuesExplanationResponse fromJson(Map<String, dynamic> json) =>
      _$ValuesExplanationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValuesExplanationResponseToJson(this);
}
