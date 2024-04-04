import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/upcoming_goal_item.dart';

class UpcomingGoalsList extends StatefulWidget {
  const UpcomingGoalsList({super.key});

  @override
  State<UpcomingGoalsList> createState() => _UpcomingGoalsListState();
}

class _UpcomingGoalsListState extends State<UpcomingGoalsList> {
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
        orElse: () => Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: state.data.weeklyGoals.isNotEmpty ? state.data.weeklyGoals.length + 2 : 0,
              itemBuilder: (BuildContext context, int index) {
                if ((index == 0 || index == state.data.weeklyGoals.length + 1) && state.data.weeklyGoals.isNotEmpty) {
                  return Container(); // zero height: not visible
                }
                final item = state.data.weeklyGoals[index - 1];
                return UpcomingGoalItem(
                  item: item,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.0,
                  height: 2.0,
                  color: AppColors.blueDarker,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
