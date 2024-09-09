import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_to_group_session_response.g.dart';

@immutable
@JsonSerializable()
class SignToGroupSessionsResponse {
  final int id;
  final int groupSessionId;
  final DateTime createdAt;

  const SignToGroupSessionsResponse({
    required this.id,
    required this.groupSessionId,
    required this.createdAt,
  });

  static SignToGroupSessionsResponse fromJson(Map<String, dynamic> json) =>
      _$SignToGroupSessionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignToGroupSessionsResponseToJson(this);
}
