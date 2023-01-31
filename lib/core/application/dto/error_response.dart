import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@immutable
@JsonSerializable()
class ErrorResponse {
  final String? message;

  const ErrorResponse(this.message);

  static ErrorResponse fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
