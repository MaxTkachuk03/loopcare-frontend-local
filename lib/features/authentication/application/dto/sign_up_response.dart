import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response.g.dart';

@immutable
@JsonSerializable()
class SignUpResponse {
  final int userId;

  const SignUpResponse(this.userId);

  static SignUpResponse fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}
