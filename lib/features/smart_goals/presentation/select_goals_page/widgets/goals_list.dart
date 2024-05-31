import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_page/widgets/goals_list_item.dart';

class GoalsList extends StatefulWidget {
  final int categoryId;
  final List<SmartGoal> selectedGoals;
  final void Function(SmartGoal goal, bool isSelected) onGoalSelect;

  const GoalsList({
    super.key,
    required this.categoryId,
    required this.onGoalSelect,
    required this.selectedGoals,
  });

  @override
  State<GoalsList> createState() => _GoalsListState();
}

class _GoalsListState extends State<GoalsList> {
  @override
  void initState() {
    super.initState();
    context.read<SmartGoalsBloc>().add(SmartGoalsEvent.getGoals(categoryId: widget.categoryId));
  }

  void _onErrorRetryHandler() =>
      context.read<SmartGoalsBloc>().add(SmartGoalsEvent.getGoals(categoryId: widget.categoryId));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
      builder: (context, state) {
        return state.maybeMap(
          loading: (_) => const SliverFillRemaining(
              child: Loader(),
            ),
          error: (s) => SliverFillRemaining(
              child: ErrorScreen(
                error: s.data.error!,
                onButtonPressed: _onErrorRetryHandler,
              ),
            ),
          orElse: () => SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList.separated(
              itemCount: state.data.goals.length,
              separatorBuilder:  (_, __) => const SizedBox(height: 12.0),
              itemBuilder: (context, index) {
                final item = state.data.goals[index];
                final isSelected = widget.selectedGoals.contains(item);

                return GoalsListItem(
                  item: item,
                  onItemPressed: widget.onGoalSelect,
                  isSelected: isSelected,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
