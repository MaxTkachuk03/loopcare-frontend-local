import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_goal_progress.freezed.dart';
part 'smart_goal_progress.g.dart';

@freezed
class SmartGoalProgress with _$SmartGoalProgress {
  const SmartGoalProgress._();

  const factory SmartGoalProgress({
    required DateTime date,
    required int times,
  }) = _SmartGoalProgress;

  factory SmartGoalProgress.fromJson(Map<String, dynamic> json) => _$SmartGoalProgressFromJson(json);
}
