import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_type.dart';

part 'diabetes_types_response.g.dart';

@immutable
@JsonSerializable()
class DiabetesTypesResponse {
  final List<DiabetesType> data;

  const DiabetesTypesResponse(this.data);

  static DiabetesTypesResponse fromJson(Map<String, dynamic> json) =>
      _$DiabetesTypesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DiabetesTypesResponseToJson(this);
}
