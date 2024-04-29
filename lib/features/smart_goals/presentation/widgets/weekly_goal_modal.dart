import 'package:auto_route/auto_route.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
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
  final GlobalKey _tabFirstKey = GlobalKey();
  final GlobalKey _tabSecondKey = GlobalKey();
  final GlobalKey _tabKey = GlobalKey();
  final ValueNotifier<double> _height = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    final bloc = context.read<SmartGoalsBloc>();
    controller = GoalProgressController(
      bloc: bloc,
      weeklyGoal: widget.weeklyGoal,
    );
    _tabController = TabController(
      vsync: this,
      length: controller.tabs.length,
      animationDuration: const Duration(microseconds: 500),
      initialIndex: 0,
    )..addListener(_onTabsChanged);
  }

  void _onTabsChanged() => _calculateHeight();

  void _calculateHeight() {
    if (_tabController.previousIndex == 0) {
      final heightFirstTab = _tabFirstKey.currentContext?.size?.height ?? 0;
      _height.value = heightFirstTab;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_onTabsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: CustomTabBar.blue(
            tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
            tabController: _tabController,
          ),
        ),
        AutoScaleTabBarView(
          key: _tabKey,
          controller: _tabController,
          children: [
            WeeklyDaysProgress(
              key: _tabFirstKey,
              weeklyGoal: widget.weeklyGoal,
              controller: controller,
              onDone: widget.onDone,
            ),
            ValueListenableBuilder<double>(
              valueListenable: _height,
              builder: (context, height, _) {
                return SizedBox(
                  height: height,
                  child: WeeklyGoalInfo(
                    key: _tabSecondKey,
                    weeklyGoal: widget.weeklyGoal,
                    onDone: widget.onDone,
                  ),
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.done.tr().capitalize(),
            onPressed: () {
              widget.onDone();
              context.router.pop();
            },
          ),
        ),
      ],
    );
  }
}
