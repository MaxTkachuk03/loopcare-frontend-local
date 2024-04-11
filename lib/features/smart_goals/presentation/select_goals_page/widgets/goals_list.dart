import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_page/widgets/goals_list_item.dart';

class GoalsList extends StatefulWidget {
  final int categoryId;

  const GoalsList({super.key, required this.categoryId});

  @override
  State<GoalsList> createState() => _GoalsListState();
}

class _GoalsListState extends State<GoalsList> {
  @override
  void initState() {
    super.initState();

    context.read<SmartGoalsBloc>().add(SmartGoalsEvent.getGoals(categoryId: widget.categoryId));
  }

  void _onErrorRetryHandler() {
    context.read<SmartGoalsBloc>().add(SmartGoalsEvent.getGoals(categoryId: widget.categoryId));
  }

  void _onItemPressedHandler(SmartGoal item, bool isSelected) {
    if (!isSelected && context.read<SmartGoalsBloc>().state.data.cantAddGoal) return;

    final event = isSelected ? SmartGoalsEvent.unSelectGoal : SmartGoalsEvent.selectGoal;
    context.read<SmartGoalsBloc>().add(event(goal: item));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(builder: (context, state) {
      return state.maybeMap(
        loading: (_) => const Loader(),
        error: (s) => ErrorScreen(error: s.data.error!, onButtonPressed: _onErrorRetryHandler),
        orElse: () => ListView.separated(
          itemCount: state.data.goals.length,
          itemBuilder: (BuildContext context, int index) {
            final item = state.data.goals[index];

            return GoalsListItem(
              item: item,
              onItemPressed: _onItemPressedHandler,
              isSelected: state.data.selectedGoals.contains(item),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 10.0),
        ),
      );
    });
  }
}
