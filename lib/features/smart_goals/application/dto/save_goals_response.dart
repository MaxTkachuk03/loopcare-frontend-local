import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';

part 'save_goals_response.g.dart';

@immutable
@JsonSerializable()
class SaveGoalsResponse {
  final DateTime startedAt;
  final DateTime finishedAt;
  final List<SmartGoal> goals;

  const SaveGoalsResponse({
    required this.startedAt,
    required this.finishedAt,
    required this.goals,
  });

  static SaveGoalsResponse fromJson(Map<String, dynamic> json) => _$SaveGoalsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaveGoalsResponseToJson(this);
}
