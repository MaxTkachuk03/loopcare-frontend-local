import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goals_list_item.dart';

class GoalsList extends StatefulWidget {
  final int categoryId;

  const GoalsList({super.key, required this.categoryId});

  @override
  State<GoalsList> createState() => _GoalsListState();
}

class _GoalsListState extends State<GoalsList> {
  final List<int> _selectedItems = [];

  @override
  void initState() {
    super.initState();

    context.read<SmartGoalsBloc>().add(SmartGoalsEvent.getGoals(categoryId: widget.categoryId));
  }

  void _onErrorRetryHandler() {
    context.read<SmartGoalsBloc>().add(SmartGoalsEvent.getGoals(categoryId: widget.categoryId));
  }

  void _onItemPressedHandler(int itemId, bool isSelected) {
    if (!isSelected && _selectedItems.length >= 2) return;

    isSelected ? _selectedItems.remove(itemId) : _selectedItems.add(itemId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(builder: (context, state) {
      return state.maybeMap(
        loading: (_) => const Loader(),
        error: (s) => ErrorScreen(
          error: s.data.error!,
          onButtonPressed: _onErrorRetryHandler,
        ),
        orElse: () => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.data.goals.length,
          itemBuilder: (BuildContext context, int index) {
            final item = state.data.goals[index];

            return GoalsListItem(
              item: item,
              onItemPressed: _onItemPressedHandler,
              isSelected: _selectedItems.contains(item.id),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 10.0),
        ),
      );
    });
  }
}
