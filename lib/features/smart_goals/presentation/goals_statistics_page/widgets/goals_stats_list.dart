import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_statistics_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/goals_statistics_page/widgets/goals_stats_list_item.dart';

class GoalsStatsList extends StatelessWidget {
  const GoalsStatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsStatisticsBloc, SmartGoalsStatisticsState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.data.categoriesWithAccomplishedGoals.length,
          itemBuilder: (BuildContext context, int index) =>
              GoalsStatsListItem(item: state.data.categoriesWithAccomplishedGoals[index]),
          separatorBuilder: (_, __) => const SizedBox(height: 12.0),
        );
      },
    );
  }
}
