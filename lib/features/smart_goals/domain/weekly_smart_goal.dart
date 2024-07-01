import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
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

  String get shortTitle => smartGoal.shortTitle;

  String get categoryName => smartGoal.category.name;

  int get requiredCompletions => smartGoal.requiredCompletionDays;

  int get requiredDays => smartGoal.lengthInDays;

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

  int progressForDate(DateTime? date) {
    if (progressLogs == null || date == null) {
      return 0;
    }
    final log = progressLogs!.firstWhereOrNull((log) {
      return log.date.dateOnly == date.dateOnly;
    });
    return log?.times ?? 0;
  }

  bool get isAchieved {
    if (progressLogs == null) {
      return false;
    }
    return completionsDays >= requiredCompletions;
  }

  factory WeeklySmartGoal.fromJson(Map<String, dynamic> json) => _$WeeklySmartGoalFromJson(json);

  int get completionsDays {
    if (progressLogs == null) {
      return 0;
    }
    return progressLogs!.where((log) => log.times > 0).toList().length;
  }
}
