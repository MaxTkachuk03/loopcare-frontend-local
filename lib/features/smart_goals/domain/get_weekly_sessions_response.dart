import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goals_session.dart';

part 'get_weekly_sessions_response.g.dart';

@immutable
@JsonSerializable()
class GetWeeklySessionsResponse {
  final List<WeeklyGoalsSession> data;

  const GetWeeklySessionsResponse({required this.data});

  static GetWeeklySessionsResponse fromJson(Map<String, dynamic> json) => _$GetWeeklySessionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetWeeklySessionsResponseToJson(this);
}
