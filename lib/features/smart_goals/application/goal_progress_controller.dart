import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/progress_smart_goal_log.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';

class GoalProgressController {
  final SmartGoalsBloc bloc;
  final WeeklySmartGoal weeklyGoal;

  late ValueNotifier<ProgressSmartGoalLog?> selectedValueNotifier = ValueNotifier(null);
  final List<String> tabs = [
    LocalizedTexts.weeklyModalProgress.tr(),
    LocalizedTexts.weeklyModalInfo.tr(),
  ];

  GoalProgressController({required this.bloc, required this.weeklyGoal}) {
    if (bloc.state.data.logs.isNotEmpty) {
      selectedValueNotifier.value = bloc.state.data.logs.last;
    }
  }

  void onIncrease() {
    if (selectedValueNotifier.value == null) {
      return;
    }
    selectedValueNotifier.value =
        ProgressSmartGoalLog(date: selectedValueNotifier.value!.date, times: selectedValueNotifier.value!.times + 1);
    bloc.add(SmartGoalsEvent.updateLoggerTimes(goalProgress: selectedValueNotifier.value!));
  }

  void onDecrease() {
    if (selectedValueNotifier.value == null || (selectedValueNotifier.value?.times ?? -1) <= 0) {
      return;
    }
    selectedValueNotifier.value =
        ProgressSmartGoalLog(date: selectedValueNotifier.value!.date, times: selectedValueNotifier.value!.times - 1);
    bloc.add(SmartGoalsEvent.updateLoggerTimes(goalProgress: selectedValueNotifier.value!));
  }

  String getTimes(ProgressSmartGoalLog progressGoal) {
    if (progressGoal.times > 1) {
      return LocalizedTexts.weeklyTimes.tr(args: [progressGoal.times.toString()]);
    }
    return LocalizedTexts.weeklyTime.tr(args: [progressGoal.times.toString()]);
  }

  String getTimesSelectedDay() {
    if (selectedValueNotifier.value == null) {
      return '';
    }
    if (selectedValueNotifier.value!.times > 1) {
      return LocalizedTexts.weeklyTimes.tr(args: [selectedValueNotifier.value!.times.toString()]);
    }
    return LocalizedTexts.weeklyTime.tr(args: [selectedValueNotifier.value!.times.toString()]);
  }
}
