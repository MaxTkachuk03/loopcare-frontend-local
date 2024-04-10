import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/dashboard_weekly_goal_item.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';

class DashboardWeeklyGoalsList extends StatefulWidget {
  const DashboardWeeklyGoalsList({super.key});

  @override
  State<DashboardWeeklyGoalsList> createState() => _DashboardWeeklyGoalsListState();
}

class _DashboardWeeklyGoalsListState extends State<DashboardWeeklyGoalsList> {
  @override
  void initState() {
    super.initState();
    context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());
  }

  void _onErrorRetryHandler() {
    // context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(builder: (context, state) {
      return state.maybeMap(
          loading: (_) => const Loader(),
          error: (s) => ErrorScreen(error: s.data.error!, onButtonPressed: _onErrorRetryHandler),
          orElse: () {
            return const _EmptyGoalsList();
            if (!state.data.hasWeeklyGoals) return const _EmptyGoalsList();
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: state.data.weeklyGoals.length,
              itemBuilder: (BuildContext context, int index) {
                final item = state.data.weeklyGoals[index];
                return DashboardWeeklyGoalItem(
                  item: item,
                );
              },
            );
          });
    });
  }
}

class _EmptyGoalsList extends StatelessWidget {
  const _EmptyGoalsList();

  void _onChooseGoalsHandler(BuildContext context) {
    // context.router.pushNamed(AppRoutes.setWeeklyGoals);
    // TODO for testing purposes goal review functionality
    final goal = context.read<SmartGoalsBloc>().state.data.firstGoalForReview;
    if (goal == null) return;
    final isLast = context.read<SmartGoalsBloc>().state.data.isLastGoalInSession(goal);

    context.router.push(GoalReviewRoute(goal: goal, isLast: isLast));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: CustomText.w400(
            LocalizedTexts.noGoalsSelected.tr(),
            style: context.textTheme.bodySmall,
          ),
        ),
        CustomElevatedButton.greenSmall(
          label: LocalizedTexts.chooseGoalsForUpcomingDays.tr(),
          onPressed: () => _onChooseGoalsHandler(context),
        ),
      ],
    );
  }
}
