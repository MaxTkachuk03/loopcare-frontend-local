import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';

part 'get_reflections_response.g.dart';

@immutable
@JsonSerializable()
class GetReflectionsResponse {
  final List<Reflection> data;

  const GetReflectionsResponse({required this.data});

  static GetReflectionsResponse fromJson(Map<String, dynamic> json) =>
      _$GetReflectionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetReflectionsResponseToJson(this);
}
