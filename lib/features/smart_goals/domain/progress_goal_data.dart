import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/progress_smart_goal_log.dart';

part 'progress_goal_data.g.dart';

@immutable
@JsonSerializable()
class ProgressGoalData {
  final int reviewId;
  final List<ProgressSmartGoalLog>? progress;

  const ProgressGoalData({
    required this.reviewId,
    this.progress,
  });

  factory ProgressGoalData.fromJson(Map<String, dynamic> json) => _$ProgressGoalDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressGoalDataToJson(this);
}
