import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/topic.dart';

part 'group_sessions_response.g.dart';

@immutable
@JsonSerializable()
class GroupSessionsResponse {
  final List<Topic> data;

  const GroupSessionsResponse({
    required this.data,
  });

  static GroupSessionsResponse fromJson(Map<String, dynamic> json) => _$GroupSessionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupSessionsResponseToJson(this);
}
