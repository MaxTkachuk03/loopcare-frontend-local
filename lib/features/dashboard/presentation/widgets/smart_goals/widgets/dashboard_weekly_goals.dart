import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/dashboard_weekly_goal_item.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goals_session.dart';

class DashboardWeeklyGoals extends StatefulWidget {
  const DashboardWeeklyGoals({super.key});

  @override
  State<DashboardWeeklyGoals> createState() => _DashboardWeeklyGoalsState();
}

class _DashboardWeeklyGoalsState extends State<DashboardWeeklyGoals> {
  int itemKey = 0;

  @override
  void initState() {
    super.initState();
    context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());
  }

  void _onErrorRetryHandler() => context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(builder: (context, state) {
      return state.maybeMap(
          error: (s) => ErrorScreen(error: s.data.error!, onButtonPressed: _onErrorRetryHandler),
          orElse: () {
            if (state.data.emptySessionState) {
              return const SizedBox.shrink();
            }
            itemKey = itemKey + 1;
            List<WeeklyGoalsSession> sessions = [...state.data.weeklyGoalsSessions];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Divider(
                  color: AppColors.blueLighter,
                  indent: 8.0,
                  endIndent: 8.0,
                ),
                const SizedBox(height: 4.0),
                ...sessions.map(
                  (session) => DashboardWeeklyGoalItem(
                    keyItem: itemKey,
                    sessionId: session.id!,
                    onRemoveFromLocal: () {
                      setState(() {
                        sessions.remove(session);
                      });
                    },
                    item: session.goal!,
                    editable:
                        !session.goal!.isAchieved || !session.hasQuickReviewWeeklyGoals && !session.goal!.isAchieved,
                  ),
                )
              ],
            );
          });
    });
  }
}
