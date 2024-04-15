import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_tab_bar.dart';
import 'package:loopcare_frontend/features/smart_goals/application/goal_progress_controller.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_days_progress.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_goal_info.dart';
import 'package:provider/provider.dart';

class WeeklyGoalModal extends StatefulWidget {
  final WeeklySmartGoal weeklyGoal;
  final void Function() onDone;

  const WeeklyGoalModal({
    super.key,
    required this.weeklyGoal,
    required this.onDone,
  });

  @override
  State<WeeklyGoalModal> createState() => _WeeklyGoalModalState();
}

class _WeeklyGoalModalState extends State<WeeklyGoalModal> with SingleTickerProviderStateMixin {
  late GoalProgressController controller;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<SmartGoalsBloc>();
    bloc.add(SmartGoalsEvent.resetLoggerTimes(weeklyGoal: widget.weeklyGoal));
    controller = GoalProgressController(
      bloc: bloc,
      weeklyGoal: widget.weeklyGoal,
    );
    _tabController = TabController(
      vsync: this,
      length: controller.tabs.length,
      animationDuration: Duration.zero,
      initialIndex: 0,
    )..addListener(_onTabsChanged);
    ;
  }

  void _onTabsChanged() => setState(() {});

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_onTabsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: CustomTabBar.blue(
            tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
            tabController: _tabController,
          ),
        ),
        Flexible(
          child: TabBarView(controller: _tabController, children: [
            WeeklyDaysProgress(
              weeklyGoal: widget.weeklyGoal,
              controller: controller,
              onDone: widget.onDone,
            ),
            WeeklyGoalInfo(weeklyGoal: widget.weeklyGoal),
          ]),
        ),
      ],
    );
  }
}
