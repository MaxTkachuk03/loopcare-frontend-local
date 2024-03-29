import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_email_data.g.dart';

@immutable
@JsonSerializable()
class ValidateEmailData {
  final String email;

  const ValidateEmailData(this.email);

  factory ValidateEmailData.fromJson(Map<String, dynamic> json) =>
      _$ValidateEmailDataFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateEmailDataToJson(this);
}
