import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_statistics.dart';

part 'get_goals_statistics_response.g.dart';

@immutable
@JsonSerializable()
class GetGoalsStatisticsResponse {
  final List<SmartGoalStatistics> data;

  const GetGoalsStatisticsResponse({required this.data});

  static GetGoalsStatisticsResponse fromJson(Map<String, dynamic> json) =>
      _$GetGoalsStatisticsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetGoalsStatisticsResponseToJson(this);
}
