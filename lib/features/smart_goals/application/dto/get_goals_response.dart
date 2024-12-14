import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';

part 'get_goals_response.g.dart';

@immutable
@JsonSerializable()
class GetGoalsResponse {
  final List<SmartGoal> data;

  const GetGoalsResponse({required this.data});

  static GetGoalsResponse fromJson(Map<String, dynamic> json) => _$GetGoalsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetGoalsResponseToJson(this);
}
