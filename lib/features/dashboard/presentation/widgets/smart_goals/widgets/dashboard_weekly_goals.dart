import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/dashboard_weekly_goal_item.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/weekly_goals_empty_state.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';

class DashboardWeeklyGoals extends StatefulWidget {
  const DashboardWeeklyGoals({super.key});

  @override
  State<DashboardWeeklyGoals> createState() => _DashboardWeeklyGoalsState();
}

class _DashboardWeeklyGoalsState extends State<DashboardWeeklyGoals> {
  @override
  void initState() {
    super.initState();
    context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());
  }

  void _onErrorRetryHandler() => context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());

  void _onQuickReviewHandler() {
    final goal = context.read<SmartGoalsBloc>().state.data.firstGoalForReview;

    if (goal == null) return;

    final isLast = context.read<SmartGoalsBloc>().state.data.isLastGoalInSession(goal);

    context.router.push(GoalReviewRoute(goal: goal, isLast: isLast));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(builder: (context, state) {
      return state.maybeMap(
          loading: (_) => const Loader(),
          error: (s) => ErrorScreen(error: s.data.error!, onButtonPressed: _onErrorRetryHandler),
          orElse: () {
            if (!state.data.hasWeeklyGoals || !state.data.hasReviewDelay) {
              return const WeeklyGoalsEmptyState();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.data.weeklyGoals.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.data.weeklyGoals[index];
                    return DashboardWeeklyGoalItem(
                      item: item,
                      editable: !state.data.hasQuickReviewWeeklyGoals,
                    );
                  },
                ),
                if (state.data.hasQuickReviewWeeklyGoals)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomElevatedButton.greenSmall(
                      label: LocalizedTexts.weeklyQuickReview.tr(),
                      onPressed: _onQuickReviewHandler,
                    ),
                  ),
              ],
            );
          });
    });
  }
}
