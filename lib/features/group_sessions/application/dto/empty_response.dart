import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'empty_response.g.dart';

@immutable
@JsonSerializable()
class EmptyResponse {
  const EmptyResponse();

  static EmptyResponse fromJson(Map<String, dynamic> json) => _$EmptyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyResponseToJson(this);
}
