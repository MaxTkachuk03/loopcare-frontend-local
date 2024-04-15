import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goal_progress_log.dart';

part 'weekly_smart_goal.freezed.dart';
part 'weekly_smart_goal.g.dart';

@freezed
class WeeklySmartGoal with _$WeeklySmartGoal {
  const WeeklySmartGoal._();

  const factory WeeklySmartGoal({
    required int id,
    required SmartGoal smartGoal,
    int? difficulty,
    bool? isTryAgain,
    List<WeeklyGoalProgressLog>? progressLogs,
  }) = _WeeklySmartGoal;

  String get title => smartGoal.title;

  String get titleShort => smartGoal.titleShort;

  String get categoryName => smartGoal.category.name;

  int get requiredCompletions => smartGoal.requiredCompletions;

  int get requiredDays => smartGoal.requiredDays;

  int get completionsAmount {
    int times = 0;
    if (progressLogs == null) {
      return 0;
    }
    for (var log in progressLogs!) {
      times = times + log.times;
    }
    return times;
  }

  bool get isAchieved {
    if (progressLogs == null) {
      return false;
    }
    return completionsAmount >= smartGoal.requiredCompletions;
    // && progressLogs!.length >= smartGoal.requiredDays;
  }

  factory WeeklySmartGoal.fromJson(Map<String, dynamic> json) => _$WeeklySmartGoalFromJson(json);

  int get completionsDays {
    if (progressLogs == null) {
      return 0;
    }
    //Todo need clarify log.times > 0&&smartGoal.requiredCompletions == log.times => day is completed and added in progress bar
    return progressLogs!.where((log) => log.times > 0).toList().length;
  }
}
