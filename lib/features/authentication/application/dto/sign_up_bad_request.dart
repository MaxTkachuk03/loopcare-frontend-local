import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_bad_request.g.dart';

@immutable
@JsonSerializable()
class SignUpBadRequest {
  final String? message;

  const SignUpBadRequest(
    this.message,
  );

  static SignUpBadRequest fromJson(Map<String, dynamic> json) =>
      _$SignUpBadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpBadRequestToJson(this);
}
