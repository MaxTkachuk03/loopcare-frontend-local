import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_email_data.g.dart';

@immutable
@JsonSerializable()
class UpdateUserEmailData {
  final String email;
  final String password;

  const UpdateUserEmailData(this.email, this.password);

  factory UpdateUserEmailData.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserEmailDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserEmailDataToJson(this);
}
