import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_type.dart';

part 'diabetes_type_response.g.dart';

@immutable
@JsonSerializable()
class DiabetesTypeResponse {
  final DiabetesType data;

  const DiabetesTypeResponse(this.data);

  static DiabetesTypeResponse fromJson(Map<String, dynamic> json) =>
      _$DiabetesTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DiabetesTypeResponseToJson(this);
}
