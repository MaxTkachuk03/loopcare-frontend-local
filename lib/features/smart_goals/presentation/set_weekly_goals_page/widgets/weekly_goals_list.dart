import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/set_weekly_goals_page/widgets/weekly_goal_list_item.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/set_weekly_goals_page/widgets/weekly_goals_list_divider.dart';

class WeeklyGoalsList extends StatelessWidget {
  const WeeklyGoalsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 1, color: AppColors.blueDarker),
        ),
      ),
      child: BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
        builder: (context, state) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.data.selectedGoals.length,
            itemBuilder: (BuildContext context, int index) =>
                WeeklyGoalListItem(item: state.data.selectedGoals[index]),
            separatorBuilder: (_, __) => const WeeklyGoalsListDivider(),
          );
        },
      ),
    );
  }
}
