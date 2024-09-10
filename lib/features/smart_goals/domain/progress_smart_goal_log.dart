import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_smart_goal_log.freezed.dart';
part 'progress_smart_goal_log.g.dart';

@freezed
class ProgressSmartGoalLog with _$ProgressSmartGoalLog {
  const ProgressSmartGoalLog._();

  const factory ProgressSmartGoalLog({
    required String date,
    required int times,
  }) = _ProgressSmartGoalLog;

  factory ProgressSmartGoalLog.fromJson(Map<String, dynamic> json) =>
      _$ProgressSmartGoalLogFromJson(json);
}
